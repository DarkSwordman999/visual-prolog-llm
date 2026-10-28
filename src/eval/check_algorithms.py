"""Проверка набора алгоритмов data/raw/algorithms: каждая программа собирается vipBuilder,
запускается с заданным вводом, и её вывод сравнивается с ожидаемым.

    python src/eval/check_algorithms.py               # проверить все
    python src/eval/check_algorithms.py gcd_lcm bst   # только указанные
    python src/eval/check_algorithms.py --update      # записать фактический вывод как ожидаемый
                                                      # (только после ручной проверки вывода!)

Поле verified в tasks.jsonl ставится в true, если программа компилируется и вывод совпал.
Нужен установленный Visual Prolog 11. Сборка на медленном компьютере — минуты на программу,
поэтому программы собираются в четырёх постоянных папках параллельно: библиотека PFC в них
компилируется один раз, дальше пересобирается только main.pro.
"""
import json
import queue
import sys
import tempfile
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

from vp_check import check

ROOT = Path(__file__).resolve().parents[2]
ALGO = ROOT / "data" / "raw" / "algorithms"
WORKERS = 4


def norm(text):
    return "\n".join(line.rstrip() for line in text.replace("\r\n", "\n").strip().split("\n"))


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    update = "--update" in sys.argv
    tasks = [json.loads(line) for line in open(ALGO / "tasks.jsonl", encoding="utf-8")]
    todo = [t for t in tasks if not args or t["slug"] in args]

    dirs = queue.Queue()
    for i in range(WORKERS):
        dirs.put(str(Path(tempfile.gettempdir()) / f"vp_algo_check_{i}"))

    def one(t):
        d = dirs.get()
        try:
            code = (ALGO / f"{t['slug']}.pro").read_text(encoding="utf-8-sig")
            return t["slug"], check(code, stdin=t.get("stdin", ""), workdir=d)
        finally:
            dirs.put(d)

    with ThreadPoolExecutor(WORKERS) as ex:
        results = dict(ex.map(one, todo))

    ok = 0
    for t in tasks:
        r = results.get(t["slug"])
        if r is None:
            continue
        if update and r.compiled and not r.timeout:
            t["expected_output"] = norm(r.output)
        t["verified"] = bool(r.compiled and not r.timeout and norm(r.output) == t.get("expected_output"))
        ok += t["verified"]
        status = "OK " if t["verified"] else ("ВЫВОД" if r.compiled else "ОШИБКА")
        print(f"{status:6} {t['slug']}")
        if not r.compiled:
            print("       " + r.errors.replace("\n", "\n       "))
        elif not t["verified"]:
            print("       ожидалось:\n         " + t.get("expected_output", "").replace("\n", "\n         "))
            print("       получено:\n         " + norm(r.output).replace("\n", "\n         "))

    with open(ALGO / "tasks.jsonl", "w", encoding="utf-8", newline="\n") as f:
        for t in tasks:
            f.write(json.dumps(t, ensure_ascii=False) + "\n")
    print(f"\nПроверено: {ok} из {len(results)}")


if __name__ == "__main__":
    main()
