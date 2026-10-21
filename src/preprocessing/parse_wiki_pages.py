
import requests
from bs4 import BeautifulSoup
import json
import time

BASE_URL = "https://wiki.visual-prolog.com/index.php"

with open('data/raw/wiki_pages_to_parse.json', 'r', encoding='utf-8') as f:
    pages = json.load(f)

parsed_data = []

for page_title in pages:
    url = f"{BASE_URL}?title={page_title}"
    print(f"Парсим: {page_title}")
    try:
        r = requests.get(url, timeout=30)
        if r.status_code == 200:
            soup = BeautifulSoup(r.text, 'html.parser')
            code_blocks = soup.find_all(['pre', 'code'])
            for block in code_blocks:
                code_text = block.get_text().strip()
                if len(code_text) > 50 and any(kw in code_text.lower() for kw in ['clauses', 'predicates', 'domains', 'implement', 'class']):
                    parsed_data.append({
                        "instruction": f"Напиши пример кода на Visual Prolog по теме: {page_title}",
                        "output": code_text
                    })
        time.sleep(1)
    except Exception as e:
        print(f"  Ошибка: {e}")

output_file = 'data/processed/dataset_wiki_pages.jsonl'
with open(output_file, 'w', encoding='utf-8') as f:
    for item in parsed_data:
        f.write(json.dumps(item, ensure_ascii=False) + '\\n')

print(f"\\nВсего собрано {len(parsed_data)} блоков кода с вики-страниц.")
