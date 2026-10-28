"""Проверка ответов модели компилятором Visual Prolog 11.

    python src/eval/check_answers.py answers_v3_algorithms.json

Файл ответов сохраняет ноутбук notebooks/train_visual_prolog.ipynb. Из каждого ответа берётся
код из блока ```visualprolog (или весь ответ, если блока нет), программа собирается как main.pro
консольного проекта и запускается. Для отложенных алгоритмов вывод сравнивается с эталоном.
Итог печатается и сохраняется рядом с файлом ответов: <имя>_checked.json.
"""
import json
import queue
import re
import sys
import tempfile
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

from check_algorithms import norm
from vp_check import check

BLOCK = re.compile(r"```(?:visualprolog|prolog|vip)?\s*\n(.*?)```", re.S | re.I)
WORKERS = 4


def extract(answer):
    blocks = BLOCK.findall(answer)
    return max(blocks, key=len) if blocks else answer


def main():
    path = Path(sys.argv[1])
    answers = json.loads(path.read_text(encoding="utf-8"))
    dirs = queue.Queue()
    for i in range(WORKERS):
        dirs.put(str(Path(tempfile.gettempdir()) / f"vp_answer_check_{i}"))

    def one(a):
        d = dirs.get()
        try:
            return check(extract(a["answer"]), stdin=a.get("stdin", ""), workdir=d)
        finally:
            dirs.put(d)

    with ThreadPoolExecutor(WORKERS) as ex:
        results = list(ex.map(one, answers))

    compiled = correct = algos = 0
    for a, r in zip(answers, results):
        a["compiled"] = r.compiled
        a["errors"] = r.errors
        if a.get("kind") == "held_out_algorithm":
            algos += 1
            a["output"] = norm(r.output)
            a["correct"] = r.compiled and not r.timeout and a["output"] == norm(a.get("expected_output", ""))
            correct += a["correct"]
        compiled += r.compiled
        mark = "компилируется" if r.compiled else "ошибка"
        if "correct" in a:
            mark += ", вывод верный" if a["correct"] else ", вывод неверный"
        print(f"{a.get('kind', '')[:9]:9} {str(a.get('id')):22} {mark}")

    print(f"\nКомпилируется: {compiled} из {len(answers)}")
    if algos:
        print(f"Отложенные алгоритмы решены верно: {correct} из {algos}")
    out = path.with_name(path.stem + "_checked.json")
    out.write_text(json.dumps(answers, ensure_ascii=False, indent=1), encoding="utf-8")
    print("Подробности:", out)


if __name__ == "__main__":
    main()
