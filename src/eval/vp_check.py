"""Проверка программы на Visual Prolog: компиляция vipBuilder и запуск.

Программа — содержимое main.pro консольного проекта: класс main уже объявлен
в main.cl (предикат run), вспомогательные предикаты объявляются в разделе
class predicates внутри implement main. Нужен установленный Visual Prolog 11.

    from vp_check import check
    r = check(code, stdin="5\\n")
    r.compiled, r.output, r.errors
"""
import os
import shutil
import subprocess
import tempfile
from dataclasses import dataclass
from pathlib import Path

TEMPLATE = Path(__file__).resolve().parent / "vp_template"
VIP_BUILDER = Path(os.environ.get("APPDATA", "")) / "Visual Prolog" / "11" / "bin64" / "vipBuilder.exe"


@dataclass
class Result:
    compiled: bool
    output: str = ""
    errors: str = ""
    timeout: bool = False


def _errors(log):
    """Строки с ошибками компилятора, без служебного вывода сборки."""
    keep = [ln for ln in log.splitlines() if " error " in ln or "error c" in ln.lower() or "fatal" in ln.lower()]
    return "\n".join(keep) or log[-2000:]


def check(code, stdin="", run=True, timeout=20, workdir=None):
    """Собрать программу и (если run) выполнить её, подав stdin."""
    if not VIP_BUILDER.exists():
        raise FileNotFoundError(f"Не найден {VIP_BUILDER}: нужен Visual Prolog 11")
    # в постоянной рабочей папке библиотека PFC остаётся собранной: повторная сборка
    # перекомпилирует только main.pro и идёт в разы быстрее
    tmp = Path(workdir or tempfile.mkdtemp(prefix="vpcheck_"))
    try:
        if not (tmp / "check.vipprj").exists():
            shutil.copytree(TEMPLATE, tmp, dirs_exist_ok=True)
        (tmp / "exe64" / "check.exe").unlink(missing_ok=True)
        # файлы проекта Visual Prolog — UTF-8 с BOM
        (tmp / "main.pro").write_text(code.strip() + "\n", encoding="utf-8-sig")
        b = subprocess.run([str(VIP_BUILDER), "/build", "/platform", "x64", "check.vipprj"],
                           cwd=tmp, capture_output=True, timeout=300)
        log = b.stdout.decode("utf-8", "replace") + b.stderr.decode("utf-8", "replace")
        exe = tmp / "exe64" / "check.exe"
        if b.returncode != 0 or not exe.exists():
            return Result(False, errors=_errors(log))
        if not run:
            return Result(True)
        try:
            p = subprocess.run([str(exe)], cwd=tmp, input=stdin.encode("utf-8"),
                               capture_output=True, timeout=timeout)
        except subprocess.TimeoutExpired:
            return Result(True, timeout=True)
        out = p.stdout.decode("utf-8", "replace").replace("\r\n", "\n")
        return Result(True, output=out)
    finally:
        if workdir is None:
            shutil.rmtree(tmp, ignore_errors=True)


if __name__ == "__main__":
    import sys
    r = check(Path(sys.argv[1]).read_text(encoding="utf-8-sig"), stdin=sys.stdin.read() if len(sys.argv) > 2 else "")
    print("компилируется" if r.compiled else "ошибки компиляции:\n" + r.errors)
    if r.compiled:
        print(r.output)
