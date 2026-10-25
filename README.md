# Генерация кода на Visual Prolog: данные с GitHub против учебных примеров

## Задача

Большие языковые модели плохо пишут на Visual Prolog: путают его с обычным Прологом и старыми версиями языка, забывают объявления типов, режимы аргументов и детерминизм. Язык редкий, в обучающих данных моделей его почти нет.

## Гипотеза

Дообучение на учебных примерах вида «пояснение → код» сильнее улучшает синтаксическую правильность, чем дообучение на сыром коде с GitHub.

## Методика

- Базовая модель: Qwen2.5-Coder-1.5B-Instruct.
- Два набора данных: сырой код с GitHub и учебные примеры.
- Два LoRA-адаптера, обучение QLoRA в Google Colab (T4).
- Свой бенчмарк из задач на Visual Prolog с эталонными решениями.
- Метрики: доля решений, которые компилируются (`vipBuilder.exe` из Visual Prolog 11), и правильность результата.

## Что в репозитории, а что нет

В репозитории лежат скрипты сбора и сборки датасета, описание того, как он собран, и результаты. Модель и полный датасет хранятся отдельно.

| Что | Где |
|---|---|
| Скрипты сбора и сборки датасета | этот репозиторий, `src/` |
| Открытая часть данных: код с GitHub, wiki Visual Prolog, учебные примеры, лабораторные ТулГУ | этот репозиторий, `data/` |
| Часть из библиотеки PFC | не публикуется, собирается локально (см. ниже) |
| Полный датасет с частью из PFC | приватная папка на Google Drive автора, используется для обучения в Colab |
| Веса модели (LoRA-адаптер и модель после слияния) | Hugging Face (ссылка появится после публикации) |

### Почему часть данных не публикуется

Самый полезный источник для обучения — исходный код библиотеки PFC (Prolog Foundation Classes), который ставится вместе с Visual Prolog 11: около 3700 файлов `.pro`, `.cl` и `.i`. Это код той же версии языка, что и компилятор, и в нём много того, на чём модели ошибаются: объявления классов и интерфейсов, режимы аргументов, детерминизм.

Лицензия Visual Prolog (`license.htm` в папке установки) разрешает использовать этот код, в том числе для обучения модели, но запрещает распространять сами исходники. Поэтому:

- файлы PFC и записи датасета, собранные из них, в репозиторий не кладутся;
- вместо них в репозитории есть скрипт [`src/collect/collect_pfc.py`](src/collect/collect_pfc.py), который собирает эту часть из Visual Prolog, установленного у пользователя, в `data/raw/pfc/`; эта папка и файлы `data/dataset/pfc_*.jsonl` закрыты в `.gitignore`;
- веса модели публикуются: модель обучена на коде, но не содержит и не распространяет его в виде исходников.

Чтобы получить полный датасет, установите Visual Prolog 11 и пересоберите его по командам из раздела «Пересборка».

## Датасет

Только Visual Prolog. Другие языки с теми же расширениями `.pro`, `.cl` и `.i` (Common Lisp, COOL, OpenCL, SWIG, qmake, обычный Пролог) отсеиваются по содержимому файла, см. [`src/vp_filter.py`](src/vp_filter.py).

| Файл | Записей | Что это |
|---|---:|---|
| [`data/dataset/github_code.jsonl`](data/dataset/github_code.jsonl) | 147 | файлы на Visual Prolog из открытых репозиториев GitHub |
| [`data/dataset/textbook_pairs.jsonl`](data/dataset/textbook_pairs.jsonl) | 2052 | пары «пояснение → код»: wiki Visual Prolog (английская и русская), учебники, разборы лабораторных ТулГУ |
| [`data/dataset/textbook_code.jsonl`](data/dataset/textbook_code.jsonl) | 416 | исходники учебных примеров и лабораторных ТулГУ без пояснений |

Ещё два файла собираются только при установленном Visual Prolog 11 и не публикуются:

| Файл | Записей | Что это |
|---|---:|---|
| `data/dataset/pfc_code.jsonl` | 582 | исходники PFC: случайная выборка целых файлов примерно того же объёма, что все остальные данные вместе (иначе модель учит в основном стиль библиотеки) |
| `data/dataset/pfc_pairs.jsonl` | 1318 | пары из документирующих комментариев PFC (`@short`): «описание → объявление и реализация предиката» |

Подробно по источникам и диалектам — [`data/dataset/STATS.md`](data/dataset/STATS.md).

Поля записи: `id`, `source`, `origin` (ссылка или путь), `dialect` (`modern` — Visual Prolog 6 и новее, `legacy` — Visual Prolog 5 и Turbo Prolog), `instruction`, `output`. У пар есть ещё `lang`, `section` и `explanation`.

```json
{"id": "textbook_pairs-00042", "source": "wiki_en", "dialect": "modern", "lang": "en",
 "section": "Lessons/Functions", "explanation": "…", "instruction": "Topic: …\n\n…\n\nWrite the Visual Prolog code.",
 "output": "class predicates\n    makeGreeting : (string Name) -> string Greeting.\n…"}
```

Очистка: служебные комментарии и автокод IDE вырезаются; файлы короче 40 значащих символов (заготовки IDE) и длиннее 20 000 символов отбрасываются; повторы удаляются (файлы сравниваются по коду без пробелов, пары — по пояснению и коду).

### Источники

| Источник | Сырые данные | Чем собрано |
|---|---|---|
| Поиск по GitHub, оставлено 180 файлов из 382 | `data/raw/github/files`, `manifest.csv` (репозиторий, путь, диалект, ссылка) | — (список файлов в манифесте) |
| Wiki Visual Prolog, все страницы | `data/raw/wiki/code_blocks.jsonl` (1077 блоков), `code_blocks_ru.jsonl` (696) | `src/collect/parse_wiki.py [ru]` |
| Учебники в PDF: E. Costa «Visual Prolog for Tyros» 7.3, T. W. de Boer «A Beginners' Guide to Visual Prolog» 7.2 | `data/raw/textbook_pdf` (864 пары) | `src/collect/parse_book_pdfs.py` |
| Примеры к учебникам: de Boer (7.3, 9), Costa «Tyros» (7.1, 7.3), R. Scott «A Guide to AI with Visual Prolog» | `data/raw/textbook` (1544 файла, UTF-8) | `src/collect/download_textbooks.py` |
| Лабораторные ТулГУ, Visual Prolog 11: 5 программ и 51 пара из разборов кода | `data/raw/tulsu_labs` | `src/collect/import_tulsu_labs.py` |
| Библиотека PFC из Visual Prolog 11 (без `windowsApi` и `5xVIP`) | `data/raw/pfc` — не публикуется | `src/collect/collect_pfc.py` |

### Пересборка

```bash
pip install -r requirements.txt
python src/collect/download_textbooks.py
python src/collect/parse_wiki.py
python src/collect/parse_wiki.py ru
python src/collect/parse_book_pdfs.py
python src/collect/collect_pfc.py   # нужен установленный Visual Prolog 11
python src/build_dataset.py
```

Журнал работы с данными и открытые вопросы — [`CONTEXT.md`](CONTEXT.md).

## Обучение и результаты

- Скрипт обучения: [`src/train/train_lora.py`](src/train/train_lora.py) (Unsloth, QLoRA, r = 16, alpha = 16).
- Первый адаптер обучен на `textbook_pairs` за 1 эпоху, val_loss 1,74.
- Бенчмарк: [`results/benchmark_tasks.json`](results/benchmark_tasks.json) (10 задач), ответы модели — [`results/benchmark_results.json`](results/benchmark_results.json).

Первый результат отрицательный: ни один из 10 ответов не компилируется. В 4 задачах модель выдала только объявления предикатов без правил. Причина в формате данных: модель учили на коротких фрагментах кода, а в бенчмарке просят законченную программу. Следующие шаги: перевести данные в формат «задача → законченная программа», добавить часть из PFC, сравнить с исходной моделью без дообучения и с моделью, обученной на коде с GitHub.

## Структура репозитория

```
data/raw/            собранные источники, только Visual Prolog
data/dataset/        итоговые JSONL-файлы и STATS.md
src/vp_filter.py     определение языка и диалекта
src/collect/         сборщики для каждого источника
src/build_dataset.py сборка датасета
src/train/           обучение LoRA
results/             бенчмарк и ответы модели
```

## Права на данные

Код в `data/` принадлежит его авторам (Prolog Development Center, авторы книг, владельцы репозиториев GitHub) и собран для исследования. Источник каждой записи указан в поле `origin`.
