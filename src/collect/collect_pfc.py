"""Сбор данных из исходников библиотеки PFC, которая ставится вместе с Visual Prolog 11.

Запуск из корня репозитория:
    python src/collect/collect_pfc.py ["<папка Visual Prolog 11>"]
По умолчанию папка — %APPDATA%\\Visual Prolog\\11.

Лицензия Visual Prolog запрещает распространять исходники PFC, поэтому результат
(data/raw/pfc/) в git не попадает, а каждый собирает его из своей установки.

Что собирается в data/raw/pfc/:
    files.jsonl  — исходники .pro, .cl, .i целиком (в UTF-8, без строки «Copyright PDC»);
    pairs.jsonl  — пары из документирующих комментариев PFC:
        decl — описание (@short / @detail) → объявление предикатов класса или интерфейса;
        impl — описание и объявление → предложения (clauses) из реализации класса.

Пропускаются windowsApi (автоматические привязки к WinAPI) и 5xVIP (совместимость с VP 5).
"""

import json
import os
import pathlib
import re
import sys

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parents[1]))
from vp_filter import read_text  # noqa: E402

ROOT = pathlib.Path(__file__).resolve().parents[2]
OUT = ROOT / "data" / "raw" / "pfc"
SKIP_DIRS = {"windowsApi", "5xVIP"}
EXTS = (".pro", ".cl", ".i")

COPYRIGHT = re.compile(r"\A\s*%\s*Copyright[^\n]*\n", re.I)
# раздел начинается с ключевого слова в начале строки
SECTION = re.compile(r"^(class\s+)?(predicates|properties|constructors|clauses|domains|constants|facts"
                     r"|class\s+facts|delegate|resolve|supports|inherits|open)\b", re.I)
DECL_NAME = re.compile(r"^\s{4}(\w+)\s*:")
CLAUSE_HEAD = re.compile(r"^\s{4}(\w+)\s*(\(|=|:-|\.)")
UNIT = re.compile(r"^(implement|class|interface)\s+(\w+)", re.M)


def doc_text(lines):
    """Текст из комментариев «% @short ... % @end» без разметки."""
    text = []
    for line in lines:
        s = line.strip().lstrip("%").strip()
        if s.startswith("@end"):
            break
        s = re.sub(r"^@(short|detail)\s*", "", s)
        if s.startswith("@"):  # @exception, @example и т. п. — не берем
            continue
        s = re.sub(r"</?\w+[^>]*>", "", s).replace("#", "")
        text.append(s)
    return " ".join(" ".join(text).split())


def sections(text):
    """Разбивает файл на (заголовок раздела, строки раздела)."""
    result, head, body = [], None, []
    for line in text.split("\n"):
        if line and not line[0].isspace() and SECTION.match(line):
            if head is not None:
                result.append((head, body))
            head, body = line.strip(), []
        elif line and not line[0].isspace():
            if head is not None:
                result.append((head, body))
            head, body = None, []
        elif head is not None:
            body.append(line)
    if head is not None:
        result.append((head, body))
    return result


def decl_groups(body):
    """Группы объявлений с идущим за ними комментарием @short."""
    groups, decl, doc = [], [], []

    def flush():
        if decl and any("@short" in d for d in doc):
            groups.append((list(decl), list(doc)))
        decl.clear()
        doc.clear()

    for line in body + [""]:
        stripped = line.strip()
        if stripped.startswith("%"):
            if decl:
                doc.append(line)
        elif not stripped:
            if doc or decl:
                flush()
        else:
            if doc:
                flush()
            decl.append(line)
    return groups


def clauses_by_name(text):
    """Предложения реализации, сгруппированные по имени предиката."""
    found = {}
    for head, body in sections(text):
        if not head.lower().endswith("clauses"):
            continue
        name, chunk = None, []
        for line in body + ["    __end__."]:
            m = CLAUSE_HEAD.match(line)
            if m and not line.startswith("     "):
                if name:
                    found.setdefault(name, []).append("\n".join(chunk).rstrip())
                name, chunk = m.group(1), [line]
            elif name:
                chunk.append(line)
    return found


def main():
    vp = pathlib.Path(sys.argv[1]) if len(sys.argv) > 1 else pathlib.Path(os.environ["APPDATA"]) / "Visual Prolog" / "11"
    pfc = vp / "pfc"
    if not pfc.is_dir():
        sys.exit(f"Не найдена папка {pfc}. Укажите папку Visual Prolog 11 аргументом.")

    paths = sorted(p for p in pfc.rglob("*") if p.suffix.lower() in EXTS
                   and not SKIP_DIRS & set(p.relative_to(pfc).parts) and not p.name.startswith("linknames_"))
    texts = {}
    for p in paths:
        text = read_text(p.read_bytes()).replace("\r\n", "\n")
        texts[p] = COPYRIGHT.sub("", text, count=1)

    OUT.mkdir(parents=True, exist_ok=True)
    with open(OUT / "files.jsonl", "w", encoding="utf-8", newline="\n") as f:
        for p, text in texts.items():
            f.write(json.dumps({"path": p.relative_to(pfc).as_posix(), "code": text}, ensure_ascii=False) + "\n")

    # реализации классов: имя класса → предложения
    impls = {}
    for p, text in texts.items():
        if p.suffix.lower() == ".pro":
            m = re.search(r"^implement\s+(\w+)", text, re.M)
            if m:
                impls[m.group(1).lower()] = (p, clauses_by_name(text))

    n_decl = n_impl = 0
    with open(OUT / "pairs.jsonl", "w", encoding="utf-8", newline="\n") as f:
        for p, text in texts.items():
            if p.suffix.lower() not in (".cl", ".i"):
                continue
            m = UNIT.search(text)
            if not m:
                continue
            kind, unit = m.group(1), m.group(2)
            rel = p.relative_to(pfc).as_posix()
            for head, body in sections(text):
                if not re.search(r"predicates|properties|constructors", head, re.I):
                    continue
                for decl, doc in decl_groups(body):
                    explanation = doc_text(doc)
                    if not explanation:
                        continue
                    decl_code = head + "\n" + "\n".join(decl).rstrip()
                    row = {"kind": "decl", "path": rel, "unit": unit, "unit_kind": kind, "section": head,
                           "explanation": explanation, "declaration": decl_code}
                    f.write(json.dumps(row, ensure_ascii=False) + "\n")
                    n_decl += 1
                    if kind != "class" or unit.lower() not in impls:
                        continue
                    impl_path, clauses = impls[unit.lower()]
                    names = [DECL_NAME.match(line).group(1) for line in decl if DECL_NAME.match(line)]
                    body_code = [c for name in dict.fromkeys(names) for c in clauses.get(name, [])]
                    if not body_code:
                        continue
                    row = dict(row, kind="impl", impl_path=impl_path.relative_to(pfc).as_posix(),
                               clauses="clauses\n" + "\n\n".join(body_code))
                    f.write(json.dumps(row, ensure_ascii=False) + "\n")
                    n_impl += 1
    print(f"Файлов: {len(texts)}, пар «описание - объявление»: {n_decl}, «описание - реализация»: {n_impl}")
    print(f"Сохранено в {OUT}")


if __name__ == "__main__":
    main()
