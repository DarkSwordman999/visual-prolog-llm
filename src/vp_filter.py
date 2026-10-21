"""Определение языка файла: Visual Prolog (современный или старый диалект) или что-то другое.

Поиск по расширениям .pro, .cl и .i приносит много чужого кода: .cl — это и Common Lisp,
и COOL, и OpenCL; .i — интерфейсы SWIG и препроцессированный C; .pro — проекты Qt
и обычный Пролог (SWI). Здесь по содержимому отбирается только Visual Prolog.

    vp_modern  — Visual Prolog 6 и новее: class / interface / implement ... end implement
    vp_legacy  — Visual Prolog 5 и Turbo/PDC Prolog: разделы domains / predicates / clauses / goal
    generated  — служебные файлы, которые IDE создает сама (VPITools.pro, goal$000.pro, .pack, .ph)
    broken     — намеренно ошибочный код из тестов анализаторов (parser_err_*)
    other      — любой другой язык
"""

import re

M = re.M | re.I

# современный VP: объявления закрываются парным end ...
MODERN_END = re.compile(r"^\s*end\s+(implement|interface|class)\b", M)
MODERN_MARKERS = re.compile(r"^\s*#include\s+@\"|^\s*open\s+core\b|\bcore::|\bstdio::|\bconsole::", M)
MODERN_OPEN = re.compile(r"^\s*(implement|interface|class)\s+\w+", M)

# старый VP / Turbo Prolog: программа из разделов
LEGACY_SECTION = r"^\s*(global\s+)?{name}\b"
LEGACY_SECTIONS = ("domains", "predicates", "clauses", "goal", "database", "facts", "constants")

# чужие языки, которые встречаются среди .pro/.cl/.i
OTHER_LANGS = [
    ("lisp", re.compile(r"\(defun\b|\(in-package\b|\(defclass\b|\(defmacro\b|^\s*;;;", M)),
    ("opencl", re.compile(r"__kernel\b|__global\b")),
    ("cool", re.compile(r"\bclass\s+\w+\s+inherits\s+\w+|\(\*.*\*\)")),
    ("swig", re.compile(r"^\s*%(module|include|\{|typemap|rename)\b", M)),
    ("qmake", re.compile(r"^\s*(QT|SOURCES|HEADERS|TEMPLATE|CONFIG|TARGET|FORMS)\s*[+\-]?=", re.M)),
    ("proguard", re.compile(r"^\s*-(keep|dontwarn)\b", re.M)),
]

GENERATED_NAMES = re.compile(r"(^|[_/\\])(vpitools\.pro|[^/\\]*goal\$000\.pro)$", re.I)
BROKEN_NAMES = re.compile(r"parser_err_", re.I)


def read_text(raw: bytes) -> str:
    """Исходники Visual Prolog 7+ сохраняются в UTF-16, старые — в cp1251 или UTF-8."""
    if raw[:2] in (b"\xff\xfe", b"\xfe\xff"):
        return raw.decode("utf-16")
    if len(raw) > 3 and raw[1:2] == b"\x00" and raw[3:4] == b"\x00":
        return raw.decode("utf-16-le", errors="replace")
    if raw[:3] == b"\xef\xbb\xbf":
        return raw[3:].decode("utf-8", errors="replace")
    try:
        return raw.decode("utf-8")
    except UnicodeDecodeError:
        return raw.decode("cp1251", errors="replace")


def classify(text: str, name: str = "") -> str:
    lower = name.lower()
    if BROKEN_NAMES.search(lower):
        return "broken"
    if GENERATED_NAMES.search(lower) or lower.endswith((".pack", ".ph")):
        return "generated"
    if MODERN_END.search(text) and MODERN_OPEN.search(text):
        return "vp_modern"
    for _, pattern in OTHER_LANGS:
        if pattern.search(text):
            return "other"
    if MODERN_OPEN.search(text) and MODERN_MARKERS.search(text):
        return "vp_modern"
    sections = {s for s in LEGACY_SECTIONS if re.search(LEGACY_SECTION.format(name=s), text, M)}
    if {"predicates", "clauses"} <= sections or {"clauses", "goal"} <= sections:
        return "vp_legacy"
    return "other"
