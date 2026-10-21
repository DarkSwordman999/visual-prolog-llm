
import requests
import zipfile
import io
import os
import json

os.makedirs('data/raw/wiki', exist_ok=True)
wiki_data = []

zip_urls = [
    "https://www.visual-prolog.com/download/90/books/deBoer/deBoer-BeginnersGuide-examples.zip",
    "https://www.visual-prolog.com/download/73/books/deBoer/deBoer-BeginnersGuide-examples.zip",
    "https://www.visual-prolog.com/download/72/books/deBoer/deBoer-BeginnersGuide-examples.zip",
    "https://www.visual-prolog.com/download/71/Costas-Tyros.zip"
]

for url in zip_urls:
    print(f"Скачиваем ZIP: {url}")
    try:
        r = requests.get(url, timeout=60)
        if r.status_code == 200:
            z = zipfile.ZipFile(io.BytesIO(r.content))
            extracted = 0
            for file in z.namelist():
                if file.endswith(('.pro', '.cl', '.i', '.ph')):
                    try:
                        content = z.read(file).decode('utf-8', errors='ignore')
                        if len(content) > 100:
                            wiki_data.append({"instruction": f"Напиши код на Visual Prolog из учебного примера: {file}", "output": content})
                            extracted += 1
                    except: pass
            print(f"  Извлечено {extracted} файлов")
        else:
            print(f"  Ошибка: статус {r.status_code}")
    except Exception as e:
        print(f"  Ошибка: {e}")

with open('data/processed/dataset_wiki_archives.jsonl', 'w', encoding='utf-8') as f:
    for item in wiki_data:
        f.write(json.dumps(item, ensure_ascii=False) + '\n')
