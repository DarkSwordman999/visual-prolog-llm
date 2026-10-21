"""Скачивает примеры из учебников по Visual Prolog и сохраняет исходники в data/raw/textbook/.

Запуск из корня репозитория: python src/collect/download_textbooks.py

Источники (сайт Visual Prolog, книги из wiki.visual-prolog.com/index.php?title=Category:Books):
    deBoer-7.3, deBoer-9  — Thomas W. de Boer, «A Beginners' Guide to Visual Prolog», примеры к версиям 7.3 и 9
    tyros-7.1, tyros-7.3  — Eduardo Costa, «Visual Prolog for Tyros», примеры к версиям 7.1 и 7.3
    scott-ai              — Randall Scott, «A Guide to Artificial Intelligence with Visual Prolog», дополнительные материалы

Версии одной книги частично повторяются (Tyros 7.1 и 7.3 — 189 общих файлов), повторы убираются
при сборке датасета. Примеры де Бура для 7.2 почти совпадают с 7.3 (346 из 360 файлов) и не берутся.

Исходники Visual Prolog 7 хранятся в UTF-16 — здесь они перекодируются в UTF-8.
Берутся только .pro (реализация), .cl (объявление класса) и .i (интерфейс); .pack и .ph
IDE генерирует сама — это списки #include.
"""

import io
import pathlib
import sys
import urllib.request
import zipfile

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parents[1]))
from vp_filter import read_text  # noqa: E402

ROOT = pathlib.Path(__file__).resolve().parents[2]
TARGET = ROOT / "data" / "raw" / "textbook"
BOOKS = {
    "deBoer-7.3": "https://www.visual-prolog.com/download/73/books/deBoer/deBoer-BeginnersGuide-examples.zip",
    "deBoer-9": "https://www.visual-prolog.com/download/9/books/deBoer/deBoer-BeginnersGuide-examples.zip",
    "tyros-7.1": "https://www.visual-prolog.com/download/71/Costas-Tyros.zip",
    "tyros-7.3": "https://www.visual-prolog.com/download/73/books/tyros/tyros73.zip",
    "scott-ai": "http://www.visual-prolog.com/download/72/books/scott/supplemental.zip",
}
EXTENSIONS = (".pro", ".cl", ".i")


def main():
    for book, url in BOOKS.items():
        print(f"{book}: {url}")
        with urllib.request.urlopen(url, timeout=120) as resp:
            archive = zipfile.ZipFile(io.BytesIO(resp.read()))
        saved = 0
        for name in archive.namelist():
            if not name.lower().endswith(EXTENSIONS):
                continue
            # первая папка архива — имя самого архива (BeginnersGuide7-3, tyros71, Supplemental ...)
            relative = pathlib.PurePosixPath(*pathlib.PurePosixPath(name).parts[1:])
            if ".." in relative.parts or relative.is_absolute():
                continue
            path = TARGET / book / relative
            path.parent.mkdir(parents=True, exist_ok=True)
            text = read_text(archive.read(name)).replace("\r\n", "\n")
            path.write_text(text, encoding="utf-8", newline="\n")
            saved += 1
        print(f"  сохранено файлов: {saved}")


if __name__ == "__main__":
    main()
