"""Всё обучение одним скриптом: данные → QLoRA → ответы на бенчмарк → сохранение.

Запуск в Google Colab (среда выполнения с GPU T4), одна ячейка:

    !git clone -q --depth 1 https://github.com/DarkSwordman999/visual-prolog-llm /content/visual-prolog-llm
    !pip install -q unsloth
    %run /content/visual-prolog-llm/src/train/train_all.py

Скрипт запускается через %run, а не через !python: так Colab может попросить доступ к Google Диску.
Что он делает:
1. подключает Google Диск (там лежит полный архив с частью PFC и туда сохраняется результат);
2. собирает примеры: алгоритмы (каждый 8-й откладывается для проверки), учебные пары и код, GitHub, PFC;
3. до обучения записывает ответы исходной модели на бенчмарк v2 и отложенные алгоритмы;
4. обучает QLoRA-адаптер;
5. записывает ответы обученной модели;
6. сохраняет адаптер, ответы и журнал обучения на Диск и скачивает файл ответов на компьютер.

Файл ответов answers_<RUN_NAME>.json проверяется на Windows с Visual Prolog 11:
    python src/eval/check_answers.py answers_<RUN_NAME>.json

Параметры можно поменять в блоке «Параметры» ниже или переменными окружения
(например, os.environ["VP_MODEL"] = "unsloth/Qwen2.5-Coder-3B-Instruct-bnb-4bit" перед %run).
"""
import inspect
import json
import os
import pathlib
import random
import time
import zipfile

import torch

# ---------- Параметры ----------
MODEL = os.environ.get("VP_MODEL", "unsloth/Qwen2.5-Coder-7B-Instruct-bnb-4bit")
EPOCHS = int(os.environ.get("VP_EPOCHS", 2))
LEARNING_RATE = float(os.environ.get("VP_LR", 2e-4))
LORA_RANK = int(os.environ.get("VP_LORA_RANK", 32))
MAX_SEQ_LENGTH = int(os.environ.get("VP_MAX_SEQ", 2048))
ALGO_REPEAT = int(os.environ.get("VP_ALGO_REPEAT", 3))
DATA_MODE = os.environ.get("VP_DATA_MODE", "all")          # all / textbook / github
USE_LEGACY = os.environ.get("VP_USE_LEGACY", "0") == "1"
EVAL_BASE = os.environ.get("VP_EVAL_BASE", "1") == "1"
DRIVE_ZIP = os.environ.get("VP_DRIVE_ZIP", "/content/drive/MyDrive/vp_dataset_full.zip")
OUT_DIR = os.environ.get("VP_OUT_DIR", "/content/drive/MyDrive/visual-prolog-llm")
RUN_NAME = os.environ.get("VP_RUN_NAME", "v3_algorithms")
SAVE_GGUF = os.environ.get("VP_SAVE_GGUF", "0") == "1"
SEED = 3407

REPO = pathlib.Path(__file__).resolve().parents[2]
DATA = REPO / "data" / "dataset"
SYSTEM = ("Ты — опытный программист на Visual Prolog 11. Отвечай по-русски. Сначала кратко объясни идею решения, "
          "затем приведи законченную программу в блоке ```visualprolog. Консольная программа — это файл main.pro: "
          "implement main, раздел class predicates для своих предикатов, предикат run() и goal console::runUtf8(main::run).")


def step(text):
    print(f"\n=== {time.strftime('%H:%M:%S')} {text} ===", flush=True)


# ---------- 1. Окружение ----------
step("1/6 Проверка GPU и Google Диска")
assert torch.cuda.is_available(), "Нет GPU: «Среда выполнения» → «Сменить среду выполнения» → T4 GPU"
print("GPU:", torch.cuda.get_device_name(0))
IN_COLAB = True
try:
    from google.colab import drive, files
    if not os.path.isdir("/content/drive/MyDrive"):
        drive.mount("/content/drive")
except ImportError:
    IN_COLAB = False
    OUT_DIR = str(REPO / "runs")
    print("Не Colab: результат будет в", OUT_DIR)

# ---------- 2. Данные ----------
step("2/6 Данные")
use_pfc = DATA_MODE == "all" and os.path.exists(DRIVE_ZIP)
if use_pfc:
    with zipfile.ZipFile(DRIVE_ZIP) as z:
        for name in z.namelist():
            if name.endswith(".jsonl") and "/pfc_" in name:
                (DATA / pathlib.Path(name).name).write_bytes(z.read(name))
    print("Часть PFC взята из", DRIVE_ZIP)
elif DATA_MODE == "all":
    print("Архива с PFC нет (", DRIVE_ZIP, ") — обучение без PFC")


def load(name):
    path = DATA / f"{name}.jsonl"
    return [json.loads(line) for line in open(path, encoding="utf-8")] if path.exists() else []


parts = {n: load(n) for n in ["algorithms", "textbook_pairs", "textbook_code", "github_code", "pfc_pairs", "pfc_code"]}
for n, rows in parts.items():
    print(f"  {n:15} {len(rows):5}")

random.seed(SEED)
algos = parts["algorithms"]
held_out = [r for i, r in enumerate(algos) if i % 8 == 7]
train_algos = [r for i, r in enumerate(algos) if i % 8 != 7]
sources = {"all": ["textbook_pairs", "textbook_code", "github_code"] + (["pfc_pairs", "pfc_code"] if use_pfc else []),
           "textbook": ["textbook_pairs", "textbook_code"],
           "github": ["github_code"]}[DATA_MODE]
rows = train_algos * ALGO_REPEAT if DATA_MODE == "all" else []
for n in sources:
    rows += [r for r in parts[n] if USE_LEGACY or r.get("dialect") != "legacy"]
random.shuffle(rows)


def answer(row):
    block = "```visualprolog\n" + row["output"].strip() + "\n```"
    return ("Идея: " + row["explanation"].strip() + "\n\n" + block) if row.get("source") == "algorithms" else block


examples = [[{"role": "system", "content": SYSTEM}, {"role": "user", "content": r["instruction"]},
             {"role": "assistant", "content": answer(r)}] for r in rows]
print(f"Режим {DATA_MODE}: примеров {len(examples)}, отложено алгоритмов {len(held_out)}")

# ---------- 3. Модель и ответы до обучения ----------
step("3/6 Загрузка модели " + MODEL)
from unsloth import FastLanguageModel  # noqa: E402
from unsloth.chat_templates import get_chat_template, train_on_responses_only  # noqa: E402

model, tokenizer = FastLanguageModel.from_pretrained(model_name=MODEL, max_seq_length=MAX_SEQ_LENGTH, load_in_4bit=True)
tokenizer = get_chat_template(tokenizer, chat_template="qwen-2.5")
model = FastLanguageModel.get_peft_model(
    model, r=LORA_RANK, lora_alpha=LORA_RANK, lora_dropout=0, bias="none",
    target_modules=["q_proj", "k_proj", "v_proj", "o_proj", "gate_proj", "up_proj", "down_proj"],
    use_gradient_checkpointing="unsloth", random_state=SEED)

bench = json.load(open(REPO / "results" / "benchmark_v2.json", encoding="utf-8"))


def ask(question, max_new_tokens=1024):
    msgs = [{"role": "system", "content": SYSTEM}, {"role": "user", "content": question}]
    ids = tokenizer.apply_chat_template(msgs, add_generation_prompt=True, return_tensors="pt").to("cuda")
    out = model.generate(input_ids=ids, max_new_tokens=max_new_tokens, do_sample=False, repetition_penalty=1.05)
    return tokenizer.decode(out[0][ids.shape[1]:], skip_special_tokens=True)


def evaluate(label):
    FastLanguageModel.for_inference(model)
    t0, res = time.time(), []
    for t in bench:
        res.append({"model": label, "kind": "benchmark", "id": t["id"], "category": t["category"],
                    "instruction": t["instruction"], "stdin": t.get("stdin", ""),
                    "expected_numbers": t["expected_numbers"], "answer": ask(t["instruction"])})
        print(f"  {label} {len(res)}/{len(bench) + len(held_out)}", end="\r", flush=True)
    for r in held_out:
        res.append({"model": label, "kind": "held_out_algorithm", "id": r["id"], "title": r.get("title", ""),
                    "instruction": r["instruction"], "stdin": r.get("stdin", ""),
                    "expected_output": r.get("expected_output", ""), "answer": ask(r["instruction"])})
        print(f"  {label} {len(res)}/{len(bench) + len(held_out)}", end="\r", flush=True)
    print(f"\n  {label}: {len(res)} ответов за {(time.time() - t0) / 60:.0f} мин")
    return res


save_dir = pathlib.Path(OUT_DIR) / RUN_NAME
save_dir.mkdir(parents=True, exist_ok=True)
answers_path = save_dir / f"answers_{RUN_NAME}.json"
answers = []
if EVAL_BASE:
    step("3/6 Ответы исходной модели (до обучения)")
    answers = evaluate("base")
    json.dump(answers, open(answers_path, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
FastLanguageModel.for_training(model)

# ---------- 4. Обучение ----------
step("4/6 Обучение")
from datasets import Dataset  # noqa: E402
from trl import SFTConfig, SFTTrainer  # noqa: E402

texts = [tokenizer.apply_chat_template(e, tokenize=False) for e in examples]
lengths = [len(tokenizer(t).input_ids) for t in texts]
fits = [t for t, n in zip(texts, lengths) if n <= MAX_SEQ_LENGTH]
print(f"Пропущено длиннее {MAX_SEQ_LENGTH} токенов: {len(texts) - len(fits)}; токенов за эпоху: "
      f"{sum(n for n in lengths if n <= MAX_SEQ_LENGTH):,}".replace(",", " "))
ds = Dataset.from_dict({"text": fits}).train_test_split(test_size=0.03, seed=SEED)

cfg_params = inspect.signature(SFTConfig.__init__).parameters
length_arg = {"max_length" if "max_length" in cfg_params else "max_seq_length": MAX_SEQ_LENGTH}
tok_arg = {"processing_class" if "processing_class" in inspect.signature(SFTTrainer.__init__).parameters
           else "tokenizer": tokenizer}
trainer = SFTTrainer(
    model=model, train_dataset=ds["train"], eval_dataset=ds["test"], **tok_arg,
    args=SFTConfig(
        output_dir="outputs", dataset_text_field="text", packing=False, **length_arg,
        per_device_train_batch_size=2, gradient_accumulation_steps=8,
        num_train_epochs=EPOCHS, learning_rate=LEARNING_RATE, lr_scheduler_type="cosine", warmup_ratio=0.03,
        optim="adamw_8bit", weight_decay=0.01, seed=SEED,
        fp16=not torch.cuda.is_bf16_supported(), bf16=torch.cuda.is_bf16_supported(),
        logging_steps=10, eval_strategy="steps", eval_steps=100, save_strategy="steps", save_steps=100,
        save_total_limit=2, load_best_model_at_end=True, metric_for_best_model="eval_loss", report_to="none"))
trainer = train_on_responses_only(trainer, instruction_part="<|im_start|>user\n",
                                  response_part="<|im_start|>assistant\n")
stats = trainer.train()
log = trainer.state.log_history
eval_losses = [x["eval_loss"] for x in log if "eval_loss" in x]
print(f"Обучение заняло {stats.metrics['train_runtime'] / 60:.0f} мин; лучшие потери на проверке: "
      f"{min(eval_losses) if eval_losses else '—'}")

# ---------- 5. Ответы после обучения ----------
step("5/6 Ответы обученной модели")
answers += evaluate("tuned")
json.dump(answers, open(answers_path, "w", encoding="utf-8"), ensure_ascii=False, indent=1)

# ---------- 6. Сохранение ----------
step("6/6 Сохранение")
model.save_pretrained(save_dir / "lora")
tokenizer.save_pretrained(save_dir / "lora")
json.dump({"model": MODEL, "epochs": EPOCHS, "lr": LEARNING_RATE, "lora_rank": LORA_RANK,
           "max_seq_length": MAX_SEQ_LENGTH, "algo_repeat": ALGO_REPEAT, "data_mode": DATA_MODE,
           "use_pfc": use_pfc, "use_legacy": USE_LEGACY, "train_examples": len(ds["train"]),
           "best_eval_loss": min(eval_losses) if eval_losses else None, "log": log},
          open(save_dir / "train_info.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
try:
    import matplotlib
    matplotlib.use("Agg")
    import matplotlib.pyplot as plt
    tr = [(x["step"], x["loss"]) for x in log if "loss" in x]
    ev = [(x["step"], x["eval_loss"]) for x in log if "eval_loss" in x]
    plt.figure(figsize=(8, 4))
    plt.plot(*zip(*tr), label="обучение")
    if ev:
        plt.plot(*zip(*ev), "o-", label="проверка")
    plt.xlabel("шаг"); plt.ylabel("потери"); plt.legend(); plt.grid(alpha=0.3)
    plt.savefig(save_dir / "loss.png", dpi=120, bbox_inches="tight")
except Exception as e:  # график не обязателен
    print("График не построен:", e)
if SAVE_GGUF:
    model.save_pretrained_gguf(str(save_dir / "gguf"), tokenizer, quantization_method="q4_k_m")
print("Сохранено в", save_dir)
for p in sorted(save_dir.iterdir()):
    print("  ", p.name)
if IN_COLAB:
    files.download(str(answers_path))
    print("\nФайл ответов скачивается в папку «Загрузки». Готово.")
