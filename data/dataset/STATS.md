# Статистика датасета

Собирается командой `python src/build_dataset.py`.

| Файл | Записей | Символов кода | Источники | Диалект | Отброшено |
|---|---:|---:|---|---|---|
| `github_code.jsonl` | 147 | 439 852 | github 147 | modern 107, legacy 40 | длинный код 17, повтор 16 |
| `textbook_pairs.jsonl` | 2052 | 460 344 | wiki_en 736, book_deBoer-7.2 504, wiki_ru 411, book_tyros-7.3 357, tulsu_labs 44 | modern 1942, legacy 110 | повтор 438, нет пояснения 161, короткий код 34, длинный код 3 |
| `textbook_code.jsonl` | 416 | 357 909 | textbook 409, tulsu_labs 7 | modern 415, legacy 1 | повтор 1134, не Visual Prolog 6, короткий код 3 |
| `algorithms.jsonl` | 91 | 61 764 | algorithms 91 | modern 91 | — |
| `pfc_code.jsonl` | 582 | 1 299 979 | pfc 582 | modern 582 | сверх объема выборки 1028, длинный код 77, не Visual Prolog 7, короткий код 1 |
| `pfc_pairs.jsonl` | 1318 | 548 943 | pfc 1318 | modern 1318 | только объявление 4755, не предикат 374, повтор 5 |
