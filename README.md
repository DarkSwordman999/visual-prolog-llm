# Visual Prolog Code Generation: GitHub vs Textbook Data

## Problem Statement
Large Language Models (LLMs) fail to generate syntactically correct code for Visual Prolog. This niche language lacks representation in training corpora, forcing developers to manually fix or write code from scratch.

## Hypothesis
Fine-tuning on structured textbook examples (explanation → code) yields greater improvement in syntactic correctness than fine-tuning on raw GitHub code.

## Planned Methodology
- Base model: Qwen2.5-Coder-1.5B-Instruct
- Two datasets: raw GitHub code vs. structured textbook examples
- Two LoRA adapters trained with QLoRA on Google Colab T4
- Custom benchmark: 20-30 Visual Prolog tasks with reference solutions
- Metrics: syntactic correctness, semantic correctness

## Dataset

Visual Prolog only — other languages that share the `.pro` / `.cl` / `.i` extensions (Common Lisp, COOL, OpenCL, SWIG, qmake, standard Prolog) are filtered out by content, see [`src/vp_filter.py`](src/vp_filter.py).

| File | Records | What it is |
|---|---:|---|
| [`data/dataset/github_code.jsonl`](data/dataset/github_code.jsonl) | 147 | raw Visual Prolog files from public GitHub repositories |
| [`data/dataset/textbook_pairs.jsonl`](data/dataset/textbook_pairs.jsonl) | 2052 | explanation → code pairs: Visual Prolog wiki (English and Russian), textbooks, TulSU lab walkthroughs |
| [`data/dataset/textbook_code.jsonl`](data/dataset/textbook_code.jsonl) | 416 | source files of textbook examples and TulSU labs, without explanations |

Details by source and dialect — [`data/dataset/STATS.md`](data/dataset/STATS.md).

Record fields: `id`, `source`, `origin` (URL or path), `dialect` (`modern` — Visual Prolog 6+, `legacy` — Visual Prolog 5 / Turbo Prolog), `instruction`, `output`; pairs also have `lang`, `section`, `explanation`.

```json
{"id": "textbook_pairs-00042", "source": "wiki_en", "dialect": "modern", "lang": "en",
 "section": "Lessons/Functions", "explanation": "…", "instruction": "Topic: …\n\n…\n\nWrite the Visual Prolog code.",
 "output": "class predicates\n    makeGreeting : (string Name) -> string Greeting.\n…"}
```

Cleaning: IDE header comments and auto-generated code are removed; files under 40 significant characters (IDE stubs) and over 20 000 characters are dropped; duplicates are removed (files — by code ignoring whitespace, pairs — by explanation + code).

### Sources

| Source | Raw data | Collected by |
|---|---|---|
| GitHub search, 180 of 382 files kept | `data/raw/github/files`, `manifest.csv` (repo, path, dialect, link) | — (file list is in the manifest) |
| Visual Prolog wiki, all pages | `data/raw/wiki/code_blocks.jsonl` (1077 blocks), `code_blocks_ru.jsonl` (696) | `src/collect/parse_wiki.py [ru]` |
| Textbook PDFs: E. Costa «Visual Prolog for Tyros» 7.3, T. W. de Boer «A Beginners' Guide to Visual Prolog» 7.2 | `data/raw/textbook_pdf` (864 pairs) | `src/collect/parse_book_pdfs.py` |
| Textbook examples: de Boer (7.3, 9), Costa Tyros (7.1, 7.3), R. Scott «A Guide to AI with Visual Prolog» | `data/raw/textbook` (1544 files, UTF-8) | `src/collect/download_textbooks.py` |
| TulSU labs, Visual Prolog 11: 5 programs and 51 walkthrough pairs | `data/raw/tulsu_labs` | `src/collect/import_tulsu_labs.py` |

### Rebuild

```bash
pip install -r requirements.txt
python src/collect/download_textbooks.py
python src/collect/parse_wiki.py
python src/collect/parse_wiki.py ru
python src/collect/parse_book_pdfs.py
python src/build_dataset.py
```

Work log and open items (in Russian) — [`CONTEXT.md`](CONTEXT.md).

## Repository layout

```
data/raw/        collected sources, Visual Prolog only
data/dataset/    final JSONL datasets and STATS.md
src/vp_filter.py language / dialect detection
src/collect/     collectors for each source
src/build_dataset.py
```

The code in `data/` belongs to its authors (Prolog Development Center, book authors, GitHub repository owners) and is collected for research purposes; see `origin` of each record.
