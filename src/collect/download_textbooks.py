"""Скачивает примеры из учебников по Visual Prolog и сохраняет исходники в data/raw/textbook/.

Запуск из корня репозитория: python src/collect/download_textbooks.py

Источники (сайт Visual Prolog, раздел книг):
    deBoer       — Thomas W. de Boer, «A Beginners' Guide to Visual Prolog», примеры для версии 7.3
    costas-tyros — Eduardo Costa, «Visual Prolog for Tyros», примеры для версии 7.1

Версия примеров де Бура для 7.2 почти совпадает с 7.3 (346 из 360 файлов одинаковые) и не берется;
ссылка на примеры для 9.0 отвечает 404.

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
    "deBoer": "https://www.visual-prolog.com/download/73/books/deBoer/deBoer-BeginnersGuide-examples.zip",
    "costas-tyros": "https://www.visual-prolog.com/download/71/Costas-Tyros.zip",
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
            # первая папка архива — имя самого архива (BeginnersGuide7-3, tyros71)
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
