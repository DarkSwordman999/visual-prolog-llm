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

# LoRA-адаптер Qwen2.5-Coder-1.5B для Visual Prolog, версия 2

Вторая версия адаптера из исследования «Генерация кода на Visual Prolog: данные с GitHub против учебных примеров» (см. [README репозитория](../README.md)).

## Обучение

| Параметр | Значение |
|---|---|
| Базовая модель | Qwen2.5-Coder-1.5B-Instruct (4-бит, Unsloth) |
| Метод | QLoRA: r = 16, alpha = 16, dropout 0, все проекции внимания и MLP |
| Данные | учебные пары и код, плюс часть из библиотеки PFC Visual Prolog 11 (исходники и пары «описание → объявление»; в репозиторий не публикуются по лицензии) |
| Потери на проверочной выборке | 0,96 |
| Оборудование | Google Colab, T4 |

Потери нельзя напрямую сравнивать с версией 1: у версий разные проверочные выборки.

## Известная проблема

Около 4,7 тыс. пар PFC вида «описание → только объявление» научили модель останавливаться после объявления предиката. После обучения эти пары убраны из датасета (`pfc_pairs` теперь содержит только пары «описание → объявление и реализация»); следующая версия обучается на исправленных данных и наборе алгоритмов (`data/dataset/algorithms.jsonl`).

## Как использовать

```python
from unsloth import FastLanguageModel

model, tokenizer = FastLanguageModel.from_pretrained("lora_model_v2", max_seq_length=2048, load_in_4bit=True)
FastLanguageModel.for_inference(model)
messages = [{"role": "user", "content": "Напиши на Visual Prolog программу, которая находит НОД двух чисел."}]
ids = tokenizer.apply_chat_template(messages, add_generation_prompt=True, return_tensors="pt").to("cuda")
print(tokenizer.decode(model.generate(ids, max_new_tokens=512)[0][ids.shape[1]:], skip_special_tokens=True))
```

Нужна видеокарта NVIDIA (в Google Colab подходит бесплатная T4).

## Ограничения

Модель учебная, обучена на небольшом наборе данных. Код, который она пишет, нужно проверять компилятором Visual Prolog 11 (`vipBuilder.exe`), для этого есть [`src/eval/vp_check.py`](../src/eval/vp_check.py).
