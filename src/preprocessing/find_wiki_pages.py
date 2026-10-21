
import requests
from bs4 import BeautifulSoup
import json
import time

# Базовый URL вики
BASE_URL = "https://wiki.visual-prolog.com/index.php"

# Список страниц для старта (главная страница и категории)
seed_pages = [
    "Getting_Started",
    "Category:Tutorials",
    "Category:Lessons"
]

found_pages = set()

for seed in seed_pages:
    url = f"{BASE_URL}?title={seed}"
    print(f"Сканируем: {seed}")
    try:
        r = requests.get(url, timeout=30)
        if r.status_code == 200:
            soup = BeautifulSoup(r.text, 'html.parser')
            
            # Ищем все ссылки на внутренние страницы
            for link in soup.find_all('a', href=True):
                href = link['href']
                if 'title=' in href and 'Special:' not in href:
                    # Извлекаем название страницы
                    page_title = href.split('title=')[-1].split('&')[0]
                    # Фильтруем по ключевым словам (Lessons, Tutorials, Succeed, Hello)
                    keywords = ['Lessons', 'Tutorial', 'Hello_World', 'Succeed', 'Output_arguments', 'Getting_Started']
                    if any(kw in page_title for kw in keywords):
                        found_pages.add(page_title)
        time.sleep(1)
    except Exception as e:
        print(f"Ошибка с {seed}: {e}")

# Дополнительно: если нашли "Lessons", попробуем найти подстраницы через поиск в вики
# Но для начала сохраним то, что есть
print(f"\nНайдено уникальных страниц: {len(found_pages)}")
for p in sorted(found_pages):
    print(f" - {p}")

# Сохраняем список
with open('data/raw/wiki_pages_to_parse.json', 'w', encoding='utf-8') as f:
    json.dump(sorted(list(found_pages)), f, indent=2)
print("Список сохранен в data/raw/wiki_pages_to_parse.json")
