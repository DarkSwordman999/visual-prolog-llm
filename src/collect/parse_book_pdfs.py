"""Извлекает пары «пояснение → код» из PDF учебников по Visual Prolog.

Запуск из корня репозитория: python src/collect/parse_book_pdfs.py
Нужен PyMuPDF (pip install pymupdf). PDF скачиваются в память и в репозиторий не сохраняются.

Книги (ссылки со страниц wiki.visual-prolog.com, Category:Books):
    tyros-7.3   — Eduardo Costa, «Visual Prolog for Tyros» (VP 7.3). Код набран машинописным
                  шрифтом (CMTT) — он и отделяет код от текста.
    deBoer-7.2  — Thomas W. de Boer, «A Beginners' Guide to Visual Prolog» (VP 7.2). Код набран тем же
                  шрифтом, что и текст, поэтому строки кода узнаются по виду: разделы clauses/predicates,
                  «:-», «::», объявления «имя : (...)», факты «имя(...).».

Пояснение — текст между предыдущим блоком кода (или заголовком) и текущим блоком.
Результат: data/raw/textbook_pdf/<книга>.jsonl — книга, страница, раздел, пояснение, код.
"""

import json
import pathlib
import re
import urllib.request

import pymupdf

ROOT = pathlib.Path(__file__).resolve().parents[2]
TARGET = ROOT / "data" / "raw" / "textbook_pdf"
BOOKS = {
    "tyros-7.3": ("https://www.visual-prolog.com/download/73/books/tyros/tyros73.pdf", "font"),
    "deBoer-7.2": ("https://www.visual-prolog.com/download/72/books/deBoer/VisualPrologBeginners.pdf", "pattern"),
}
MAX_CONTEXT_CHARS = 1500
CHAR_WIDTH = 6.2  # ширина знака машинописного шрифта 12 pt в пунктах — для восстановления отступов

HEADING = re.compile(r"^(\d+(\.\d+)*)\s+[A-ZА-Я]")
SECTION_WORDS = r"(predicates|clauses|domains|facts|constants|goal|class\s+predicates|class\s+facts|open\s+core.*" \
                r"|implement\s+\w+.*|end\s+implement.*|class\s+\w+.*|end\s+class.*|interface\s+\w+.*|end\s+interface.*)"
CODE_LINE = [
    re.compile(rf"^\s*{SECTION_WORDS}\s*$", re.I),
    re.compile(r":-"),
    re.compile(r"\w::\w"),
    re.compile(r"^\s*\w+\s*:\s*\(.*\)"),                       # объявление предиката
    re.compile(r"^\s*[a-z]\w*\(.*\)\s*[.,]\s*$"),              # факт или вызов
    re.compile(r"^\s*(%|/\*)"),                               # комментарий
    re.compile(r"^\s*[A-Z]\w*\s*=\s*\S.*[.,]\s*$"),            # присваивание в теле
]


def is_code_line(text):
    words = len(text.split())
    if words > 14 and ":-" not in text:          # длинные предложения — это текст
        return False
    return any(p.search(text) for p in CODE_LINE)


def lines_of(doc, mode):
    """(страница, x левого края, текст строки, это код?, это заголовок?) — по порядку чтения."""
    for pno, page in enumerate(doc, 1):
        for block in page.get_text("dict")["blocks"]:
            for line in block.get("lines", []):
                spans = [s for s in line["spans"] if s["text"].strip()]
                if not spans:
                    continue
                text = "".join(s["text"] for s in line["spans"]).rstrip()
                if mode == "font":
                    mono = sum(len(s["text"]) for s in spans if "TT" in s["font"] or "Courier" in s["font"])
                    code = mono >= 0.6 * sum(len(s["text"]) for s in spans)
                    heading = not code and max(s["size"] for s in spans) >= 14 and "BX" in spans[0]["font"]
                else:
                    code = is_code_line(text)
                    heading = not code and bool(HEADING.match(text)) and len(text) < 90
                if re.fullmatch(r"\s*\d+\s*", text) or text.startswith(("Figure", "Рис")):
                    continue
                yield pno, line["bbox"][0], text, code, heading


def extract(doc, book, mode):
    records, prose, code, section, start_page = [], [], [], "", 0

    def flush():
        nonlocal code, prose
        # отступы в PDF хранятся координатой строки: восстанавливаем их пробелами
        left = min((x for x, _ in code), default=0)
        lines = [t if t[:1].isspace() else " " * round((x - left) / CHAR_WIDTH) + t for x, t in code]
        body = "\n".join(lines).strip("\n")
        # одна короткая строка — скорее упоминание в тексте, чем пример
        if body and (len(code) > 1 or len(body) > 40):
            records.append({"book": book, "page": start_page, "section": section,
                            "explanation": " ".join(" ".join(prose).split())[-MAX_CONTEXT_CHARS:],
                            "code": body})
            prose = []
        elif body:
            prose.extend(t for _, t in code)
        code = []

    for pno, x, text, is_code, is_heading in lines_of(doc, mode):
        if is_code:
            if not code:
                start_page = pno
            code.append((x, text))
            continue
        flush()
        if is_heading:
            section, prose = " ".join(text.split()), []
        else:
            prose.append(text)
    flush()
    return records


def main():
    TARGET.mkdir(parents=True, exist_ok=True)
    for book, (url, mode) in BOOKS.items():
        print(f"{book}: {url}")
        with urllib.request.urlopen(url, timeout=180) as resp:
            doc = pymupdf.open(stream=resp.read(), filetype="pdf")
        records = extract(doc, book, mode)
        with open(TARGET / f"{book}.jsonl", "w", encoding="utf-8", newline="\n") as f:
            for r in records:
                f.write(json.dumps(r, ensure_ascii=False) + "\n")
        print(f"  страниц: {doc.page_count}, пар «пояснение → код»: {len(records)}")


if __name__ == "__main__":
    main()
