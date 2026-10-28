---
base_model: unsloth/Qwen2.5-Coder-1.5B-Instruct-bnb-4bit
library_name: peft
pipeline_tag: text-generation
language:
- ru
- en
tags:
- base_model:adapter:unsloth/Qwen2.5-Coder-1.5B-Instruct-bnb-4bit
- lora
- sft
- transformers
- trl
- unsloth
- visual-prolog
---

# LoRA-адаптер Qwen2.5-Coder-1.5B для Visual Prolog, версия 1

Первая версия адаптера из исследования «Генерация кода на Visual Prolog: данные с GitHub против учебных примеров» (см. [README репозитория](../README.md)).

## Обучение

| Параметр | Значение |
|---|---|
| Базовая модель | Qwen2.5-Coder-1.5B-Instruct (4-бит, Unsloth) |
| Метод | QLoRA: r = 16, alpha = 16, dropout 0, все проекции внимания и MLP |
| Данные | `data/dataset/textbook_pairs.jsonl` — пары «пояснение → код» из wiki Visual Prolog, учебников и лабораторных ТулГУ |
| Эпох | 1 |
| Скорость обучения | 2·10⁻⁴, линейное снижение, AdamW 8-бит |
| Длина контекста | 2048 токенов |
| Потери на проверочной выборке | 1,74 |
| Оборудование | Google Colab, T4 |

Скрипт обучения — [`src/train/train_lora.py`](../src/train/train_lora.py).

## Результат

На бенчмарке из 10 задач ([`results/benchmark_tasks.json`](../results/benchmark_tasks.json)) ни один ответ не компилируется. В 4 задачах модель выдаёт только объявления предикатов без правил. Причина — формат данных: обучение шло на коротких фрагментах, а бенчмарк просит законченную программу.

## Как использовать

```python
from unsloth import FastLanguageModel

model, tokenizer = FastLanguageModel.from_pretrained("lora_model", max_seq_length=2048, load_in_4bit=True)
FastLanguageModel.for_inference(model)
messages = [{"role": "user", "content": "Напиши на Visual Prolog программу, которая находит НОД двух чисел."}]
ids = tokenizer.apply_chat_template(messages, add_generation_prompt=True, return_tensors="pt").to("cuda")
print(tokenizer.decode(model.generate(ids, max_new_tokens=512)[0][ids.shape[1]:], skip_special_tokens=True))
```

Нужна видеокарта NVIDIA (в Google Colab подходит бесплатная T4).

## Ограничения

Модель учебная, обучена на небольшом наборе данных. Код, который она пишет, нужно проверять компилятором Visual Prolog 11 (`vipBuilder.exe`), для этого есть [`src/eval/vp_check.py`](../src/eval/vp_check.py).
