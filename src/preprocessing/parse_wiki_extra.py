
import requests
from bs4 import BeautifulSoup
import json
import time

BASE_URL = "https://wiki.visual-prolog.com/index.php"

# Конкретные страницы, где точно есть хороший код Visual Prolog
target_pages = [
    "Tutorial_Project._Release_7._Class_Human",
    "Lists_and_Recursion",
    "Tower_of_Hanoi_(Dynamic_Programming)",
    "Lessons/Output_arguments",
    "Lessons/Functions"
]

parsed_data = []

for page_title in target_pages:
    url = f"{BASE_URL}?title={page_title}"
    print(f"Парсим: {page_title}")
    try:
        r = requests.get(url, timeout=30)
        if r.status_code == 200:
            soup = BeautifulSoup(r.text, 'html.parser')
            # Ищем блоки кода
            code_blocks = soup.find_all(['pre', 'code'])
            for block in code_blocks:
                code_text = block.get_text().strip()
                # Берем только достаточно длинный код
                if len(code_text) > 100:
                    parsed_data.append({
                        "instruction": f"Напиши пример кода на Visual Prolog по теме: {page_title}",
                        "output": code_text
                    })
        time.sleep(1)
    except Exception as e:
        print(f"  Ошибка: {e}")

# Сохраняем
output_file = 'data/processed/dataset_wiki_extra.jsonl'
with open(output_file, 'w', encoding='utf-8') as f:
    for item in parsed_data:
        f.write(json.dumps(item, ensure_ascii=False) + '\n')

print(f"\\nСобрано {len(parsed_data)} блоков кода с дополнительных страниц.")
