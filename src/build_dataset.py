"""Сборка датасета Visual Prolog из сырых данных data/raw/ в data/dataset/.

Запуск из корня репозитория: python src/build_dataset.py

Под гипотезу проекта (учебные примеры «пояснение → код» против сырого кода с GitHub)
собираются три файла JSONL:

    github_code.jsonl     — файлы Visual Prolog из публичных репозиториев GitHub (без пояснений)
    textbook_pairs.jsonl  — пары «пояснение → код»: wiki (англ. и рус.), учебники в PDF,
                            разборы лабораторных работ ТулГУ
    textbook_code.jsonl   — исходники примеров к учебникам и лабораторных работ (без пояснений)

Поля записи: id, source, origin, dialect (modern — VP 6+, legacy — VP 5 / Turbo Prolog),
instruction, output, а у пар еще section и explanation.

Очистка:
- шаблонная шапка IDE (/****... Copyright (c) ... ****/) и автоматически генерируемый код
  (от «This code is maintained automatically» до «end of automatic code») вырезаются;
- файлы не на Visual Prolog и служебные файлы отсеиваются (src/vp_filter.py);
- слишком короткий (меньше MIN_CODE_CHARS значащих символов в файлах и MIN_PAIR_CODE_CHARS в парах) и слишком длинный
  (больше MAX_CODE_CHARS) код не берется;
- повторы удаляются: файлы — по коду без учета пробелов, пары — по паре (пояснение, код).
"""

import collections
import csv
import hashlib
import json
import pathlib
import re

from vp_filter import classify, read_text

ROOT = pathlib.Path(__file__).resolve().parents[1]
RAW = ROOT / "data" / "raw"
OUT = ROOT / "data" / "dataset"
MIN_CODE_CHARS = 40       # для файлов; меньше — пустые заготовки IDE
MIN_PAIR_CODE_CHARS = 10  # для пар: короткий фрагмент с пояснением тоже полезен (факт, объявление домена)
MAX_CODE_CHARS = 20000

HEADER = re.compile(r"\A\s*/\*{5,}.*?\*{5,}/\s*", re.S)
AUTO_CODE = re.compile(r"[ \t]*%\s*This code is maintained automatically.*?%\s*end of automatic code[ \t]*\n?", re.S | re.I)
KIND = {".pro": "реализацию", ".cl": "объявление класса", ".i": "интерфейс"}


def clean(code: str) -> str:
    code = code.replace("\r\n", "\n").replace("\r", "\n")
    code = HEADER.sub("", code, count=1)
    code = AUTO_CODE.sub("", code)
    lines = [line.rstrip() for line in code.split("\n")]
    code = "\n".join(lines).strip("\n")
    return re.sub(r"\n{3,}", "\n\n", code)


def significant(code: str) -> int:
    no_comments = re.sub(r"/\*.*?\*/|%[^\n]*", "", code, flags=re.S)
    return len(re.sub(r"\s", "", no_comments))


def key(*parts: str) -> str:
    return hashlib.sha1("\x00".join(" ".join(p.split()) for p in parts).encode("utf-8")).hexdigest()


def dialect_of(code: str, default: str = "modern") -> str:
    kind = classify(code)
    return "legacy" if kind == "vp_legacy" else "modern" if kind == "vp_modern" else default


def unit_name(code: str, fallback: str) -> str:
    m = re.search(r"^\s*(implement|class|interface)\s+(\w+)", code, re.M | re.I)
    return m.group(2) if m else fallback


class Collector:
    def __init__(self, name, min_chars=MIN_CODE_CHARS):
        self.name, self.rows, self.seen, self.min_chars = name, [], set(), min_chars
        self.dropped = collections.Counter()

    def add(self, row, dedup_key):
        code = row["output"]
        if significant(code) < self.min_chars:
            self.dropped["короткий код"] += 1
        elif len(code) > MAX_CODE_CHARS:
            self.dropped["длинный код"] += 1
        elif dedup_key in self.seen:
            self.dropped["повтор"] += 1
        else:
            self.seen.add(dedup_key)
            row["id"] = f"{self.name}-{len(self.rows) + 1:05d}"
            self.rows.append({"id": row.pop("id"), **row})

    def save(self):
        with open(OUT / f"{self.name}.jsonl", "w", encoding="utf-8", newline="\n") as f:
            for row in self.rows:
                f.write(json.dumps(row, ensure_ascii=False) + "\n")


def file_row(source, origin, path_name, text, dialect):
    suffix = pathlib.PurePath(path_name).suffix.lower()
    name = unit_name(text, pathlib.PurePath(path_name).stem)
    if dialect == "legacy":
        instruction = f"Напиши программу на Visual Prolog 5 ({name})."
    else:
        instruction = f"Напиши на Visual Prolog {KIND.get(suffix, 'код')} {name}."
    return {"source": source, "origin": origin, "dialect": dialect, "instruction": instruction, "output": text}


def build_github():
    out = Collector("github_code")
    manifest = {r["file"]: r for r in csv.DictReader(open(RAW / "github" / "manifest.csv", encoding="utf-8"))}
    for path in sorted((RAW / "github" / "files").iterdir()):
        text = read_text(path.read_bytes())
        kind = classify(text, path.name)
        if kind not in ("vp_modern", "vp_legacy"):
            out.dropped["не Visual Prolog"] += 1
            continue
        code = clean(text)
        meta = manifest.get(path.name, {})
        row = file_row("github", meta.get("url") or path.name, meta.get("path") or path.name, code,
                       kind.removeprefix("vp_"))
        out.add(row, key(code))
    return out


def build_textbook_code():
    out = Collector("textbook_code")
    sources = [("textbook", p) for p in sorted((RAW / "textbook").rglob("*")) if p.is_file()]
    sources += [("tulsu_labs", p) for p in sorted((RAW / "tulsu_labs").rglob("*")) if p.suffix in KIND]
    for source, path in sources:
        text = path.read_text(encoding="utf-8")
        kind = classify(text, path.name)
        if kind not in ("vp_modern", "vp_legacy"):
            out.dropped["не Visual Prolog"] += 1
            continue
        code = clean(text)
        origin = path.relative_to(RAW).as_posix()
        out.add(file_row(source, origin, path.name, code, kind.removeprefix("vp_")), key(code))
    return out


def pair_row(source, origin, section, explanation, code, lang="en"):
    section = " ".join(section.split())
    explanation = explanation.strip()
    if lang == "ru":
        head = f"Тема: {section}." if section else ""
        tail = "Напиши код на Visual Prolog."
    else:
        head = f"Topic: {section}." if section else ""
        tail = "Write the Visual Prolog code."
    instruction = "\n\n".join(p for p in (head, explanation, tail) if p)
    return {"source": source, "origin": origin, "dialect": dialect_of(code), "lang": lang,
            "section": section, "explanation": explanation, "instruction": instruction, "output": code}


def build_textbook_pairs():
    out = Collector("textbook_pairs", MIN_PAIR_CODE_CHARS)

    def add(row):
        if not row["explanation"]:
            out.dropped["нет пояснения"] += 1
            return
        out.add(row, key(row["explanation"], row["output"]))

    for name, lang in (("code_blocks.jsonl", "en"), ("code_blocks_ru.jsonl", "ru")):
        for line in open(RAW / "wiki" / name, encoding="utf-8"):
            r = json.loads(line)
            add(pair_row(f"wiki_{lang}", r["url"], f'{r["page"]} / {r["section"]}'.strip(" /"),
                         r["explanation"], clean(r["code"]), lang))
    for path in sorted((RAW / "textbook_pdf").glob("*.jsonl")):
        for line in open(path, encoding="utf-8"):
            r = json.loads(line)
            add(pair_row(f"book_{r['book']}", f"{r['book']}, с. {r['page']}", r["section"],
                         r["explanation"], clean(r["code"]), "en"))
    for line in open(RAW / "tulsu_labs" / "walkthrough.jsonl", encoding="utf-8"):
        r = json.loads(line)
        add(pair_row("tulsu_labs", f"tulsu_labs/{r['lab']}", r["section"], r["explanation"],
                     clean(r["code"]), "ru"))
    return out


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    report = []
    for build in (build_github, build_textbook_pairs, build_textbook_code):
        out = build()
        out.save()
        by_source = collections.Counter(r["source"] for r in out.rows)
        by_dialect = collections.Counter(r["dialect"] for r in out.rows)
        chars = sum(len(r["output"]) for r in out.rows)
        report.append((out.name, len(out.rows), chars, by_source, by_dialect, out.dropped))
        print(f"{out.name}: {len(out.rows)} записей, отброшено {dict(out.dropped)}")
    write_stats(report)


def write_stats(report):
    lines = ["# Статистика датасета", "", "Собирается командой `python src/build_dataset.py`.", "",
             "| Файл | Записей | Символов кода | Источники | Диалект | Отброшено |", "|---|---:|---:|---|---|---|"]
    def fmt(counter):
        return ", ".join(f"{k} {v}" for k, v in counter.most_common())

    for name, n, chars, sources, dialects, dropped in report:
        lines.append(f"| `{name}.jsonl` | {n} | {chars:,}".replace(",", " ")
                     + f" | {fmt(sources)} | {fmt(dialects)} | {fmt(dropped) or '—'} |")
    (OUT / "STATS.md").write_text("\n".join(lines) + "\n", encoding="utf-8", newline="\n")


if __name__ == "__main__":
    main()
