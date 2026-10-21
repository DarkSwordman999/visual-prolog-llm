"""Импорт лабораторных работ ТулГУ по Visual Prolog 11 (логическое программирование).

Запуск: python src/collect/import_tulsu_labs.py <папка с лабораторными> [подпапка работ]

Ожидаемая структура: "<N> лаба/<подпапка>/Проект LabN_*/" (проект Visual Prolog) и
"<N> лаба/<подпапка>/Готовые работы/Разбор кода ЛР<N>*.docx" (построчный разбор программы).

Результат:
    data/raw/tulsu_labs/labN/<проект>/*.pro|*.cl|*.i — исходники в UTF-8
    data/raw/tulsu_labs/walkthrough.jsonl — пары из разбора кода: раздел, пояснение, фрагмент кода

Сведения об авторе, преподавателе, группе и варианте в данные не переносятся.
"""

import json
import pathlib
import re
import sys

import docx
from docx.table import Table
from docx.text.paragraph import Paragraph

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parents[1]))
from vp_filter import read_text  # noqa: E402

ROOT = pathlib.Path(__file__).resolve().parents[2]
TARGET = ROOT / "data" / "raw" / "tulsu_labs"
SKIP_DIRS = {"deb64", "exe64", "obj64", "deb", "exe", "obj"}
HEADING = re.compile(r"^\d+(\.\d+)*\s+\S")
VARIANT = re.compile(r"\s*\(?\b[Вв]ариант\s*№?\s*\d+\)?,?")
WORKS = "Моя"  # подпапка с работами внутри "<N> лаба"


def copy_sources(src: pathlib.Path):
    count = 0
    for lab in sorted(src.glob("* лаба")):
        number = lab.name.split()[0]
        for project in sorted((lab / WORKS).glob("Проект *")):
            for f in sorted(project.rglob("*")):
                if f.suffix.lower() not in (".pro", ".cl", ".i") or SKIP_DIRS & set(p.lower() for p in f.parts):
                    continue
                out = TARGET / f"lab{number}" / project.name.removeprefix("Проект ") / f.relative_to(project)
                out.parent.mkdir(parents=True, exist_ok=True)
                text = VARIANT.sub("", read_text(f.read_bytes()).replace("\r\n", "\n"))
                out.write_text(text, encoding="utf-8", newline="\n")
                count += 1
    return count


def walkthrough_pairs(path: pathlib.Path, lab: str):
    """Раздел «N.M Заголовок» → таблицы 1×1 с кодом → абзацы пояснения до следующего заголовка."""
    document = docx.Document(str(path))
    pairs, section, codes, text = [], "", [], []

    def flush():
        if codes:
            pairs.append({"lab": lab, "section": VARIANT.sub("", section),
                          "code": VARIANT.sub("", "\n\n".join(codes)),
                          "explanation": VARIANT.sub("", "\n".join(text)).strip()})

    for el in document.element.body.iterchildren():
        tag = el.tag.rsplit("}", 1)[-1]
        if tag == "tbl":
            table = Table(el, document)
            if len(table.rows) == 1 and len(table.columns) == 1:
                if codes and text:      # новый фрагмент после пояснения к предыдущему
                    flush()
                    codes, text = [], []
                codes.append(table.cell(0, 0).text.replace("\r\n", "\n").strip("\n"))
        elif tag == "p":
            line = Paragraph(el, document).text.strip()
            if not line or line.startswith(("Таблица ", "Рисунок ")):
                continue
            if HEADING.match(line):
                flush()
                section, codes, text = line, [], []
            else:
                text.append(line)
    flush()
    return pairs


def main():
    global WORKS
    if len(sys.argv) not in (2, 3):
        sys.exit(__doc__)
    src = pathlib.Path(sys.argv[1])
    if len(sys.argv) == 3:
        WORKS = sys.argv[2]
    print("исходников скопировано:", copy_sources(src))
    pairs = []
    for report in sorted(src.glob(f"* лаба/{WORKS}/Готовые работы/Разбор кода ЛР*.docx")):
        lab = "lab" + report.parts[-4].split()[0]
        pairs += walkthrough_pairs(report, lab)
    with open(TARGET / "walkthrough.jsonl", "w", encoding="utf-8", newline="\n") as f:
        for p in pairs:
            f.write(json.dumps(p, ensure_ascii=False) + "\n")
    print("пар из разбора кода:", len(pairs))


if __name__ == "__main__":
    main()
