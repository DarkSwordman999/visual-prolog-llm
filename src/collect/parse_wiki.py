"""Собирает примеры кода с пояснениями со всех страниц wiki.visual-prolog.com.

Запуск из корня репозитория:
    python src/collect/parse_wiki.py        — английская wiki.visual-prolog.com
    python src/collect/parse_wiki.py ru     — русская wikiru.visual-prolog.com

Список страниц берется через API MediaWiki (все страницы основного пространства),
текст страницы — через action=parse. Для каждого блока кода на Visual Prolog
(<pre class="visualprolog">) сохраняются страница, путь заголовков и абзацы текста
между ближайшим заголовком и блоком: это пояснение к коду.

Переводы на китайский пропускаются: код в них тот же, что в английских страницах.
Блоки грамматики (vipbnf) и вывода программ (text) не берутся.

Результат: data/raw/wiki/code_blocks.jsonl (code_blocks_ru.jsonl) — одна строка на блок кода.
"""

import html
import json
import sys
import pathlib
import re
import time
import urllib.parse
import urllib.request
from html.parser import HTMLParser

ROOT = pathlib.Path(__file__).resolve().parents[2]
WIKIS = {
    "en": ("https://wiki.visual-prolog.com", "code_blocks.jsonl"),
    "ru": ("https://wikiru.visual-prolog.com", "code_blocks_ru.jsonl"),
}
LANG = sys.argv[1] if len(sys.argv) > 1 else "en"
SITE, FILE_NAME = WIKIS[LANG]
TARGET = ROOT / "data" / "raw" / "wiki" / FILE_NAME
API = SITE + "/api.php"
CJK = re.compile(r"[　-鿿＀-￯]")
MAX_CONTEXT_CHARS = 2000


def api(**params):
    params["format"] = "json"
    url = API + "?" + urllib.parse.urlencode(params)
    for attempt in range(4):
        try:
            with urllib.request.urlopen(url, timeout=60) as resp:
                return json.load(resp)
        except OSError:
            if attempt == 3:
                raise
            time.sleep(3 * (attempt + 1))


def all_pages():
    titles, cont = [], {}
    while True:
        data = api(action="query", list="allpages", aplimit=500, **cont)
        titles += [p["title"] for p in data["query"]["allpages"]]
        if "continue" not in data:
            return titles
        cont = {"apcontinue": data["continue"]["apcontinue"]}


class PageParser(HTMLParser):
    """Идет по HTML страницы и собирает (заголовки, пояснение, код)."""

    TEXT_TAGS = {"p", "li", "dd", "dt", "td"}

    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.headings = {}       # уровень -> текст
        self.context = []        # абзацы после последнего заголовка
        self.blocks = []
        self.mode = None         # "heading", "text", "code", "skip"
        self.level = 0
        self.buf = []
        self.depth = 0           # вложенность внутри текущего элемента

    VOID_TAGS = {"br", "img", "hr", "input", "wbr", "meta", "link", "col", "area", "source"}

    def handle_starttag(self, tag, attrs):
        if tag in self.VOID_TAGS:
            if tag == "br" and self.mode in ("code", "text"):
                self.buf.append("\n")
            return
        attrs = dict(attrs)
        if self.mode in ("code", "text", "heading"):
            self.depth += 1
            return
        if self.mode == "skip":
            self.depth += 1
            return
        cls = attrs.get("class") or ""
        if tag in ("h2", "h3", "h4", "h5"):
            self.mode, self.level, self.buf, self.depth = "heading", int(tag[1]), [], 0
        elif tag == "pre":
            self.mode = "code" if "visualprolog" in cls else "skip"
            self.buf, self.depth = [], 0
        elif tag in self.TEXT_TAGS:
            self.mode, self.buf, self.depth = "text", [], 0
        elif tag in ("div", "table") and ("toc" in cls or attrs.get("id") == "toc"):
            self.mode, self.depth = "skip", 0
        elif tag in ("span",) and "mw-editsection" in cls:
            self.mode, self.depth = "skip", 0

    def handle_endtag(self, tag):
        if self.mode is None:
            return
        if self.depth > 0:
            self.depth -= 1
            return
        text = html.unescape("".join(self.buf))
        if self.mode == "heading":
            title = re.sub(r"\[\s*edit\s*\]", "", text).strip()
            self.headings = {k: v for k, v in self.headings.items() if k < self.level}
            self.headings[self.level] = title
            self.context = []
        elif self.mode == "text":
            text = " ".join(text.split())
            if text:
                self.context.append(text)
        elif self.mode == "code":
            code = text.strip("\n")
            if code.strip():
                explanation = "\n".join(self.context)[-MAX_CONTEXT_CHARS:]
                self.blocks.append({
                    "section": " / ".join(v for _, v in sorted(self.headings.items())),
                    "explanation": explanation,
                    "code": code,
                })
        self.mode, self.buf = None, []

    def handle_data(self, data):
        if self.mode in ("heading", "text", "code"):
            self.buf.append(data)


def main():
    titles = [t for t in all_pages() if not CJK.search(t)]
    print(f"страниц: {len(titles)}")
    TARGET.parent.mkdir(parents=True, exist_ok=True)
    total = 0
    with open(TARGET, "w", encoding="utf-8", newline="\n") as out:
        for i, title in enumerate(titles, 1):
            data = api(action="parse", page=title, prop="text", redirects=1)
            if "parse" not in data:
                continue
            parser = PageParser()
            parser.feed(data["parse"]["text"]["*"])
            for n, block in enumerate(parser.blocks):
                record = {"page": title, "block": n, "lang": LANG, **block,
                          "url": SITE + "/index.php?title=" + urllib.parse.quote(title.replace(" ", "_"))}
                out.write(json.dumps(record, ensure_ascii=False) + "\n")
            total += len(parser.blocks)
            if i % 25 == 0:
                print(f"  {i}/{len(titles)} страниц, блоков кода: {total}")
            time.sleep(0.3)
    print(f"готово: {total} блоков кода -> {TARGET.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
