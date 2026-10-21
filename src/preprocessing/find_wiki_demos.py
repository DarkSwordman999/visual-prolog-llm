
import requests
from bs4 import BeautifulSoup
import json
import time

BASE_URL = "https://wiki.visual-prolog.com/index.php"

# Страница со списком демо-проектов
page_title = "Visual_Prolog_Demo_Examples"
url = f"{BASE_URL}?title={page_title}"

print(f"Парсим страницу со списком демо: {page_title}")

demo_links = []
try:
    r = requests.get(url, timeout=30)
    if r.status_code == 200:
        soup = BeautifulSoup(r.text, 'html.parser')
        
        # Ищем ссылки на внутренние страницы с кодом или описанием демо
        for link in soup.find_all('a', href=True):
            href = link['href']
            if 'title=' in href and 'Special:' not in href:
                page_name = href.split('title=')[-1].split('&')[0]
                # Фильтруем: нас интересуют страницы, связанные с демо
                if 'Demo' in page_name or 'Example' in page_name or 'Tutorial' in page_name:
                    demo_links.append(page_name)
        
        # Убираем дубликаты
        demo_links = list(set(demo_links))
        print(f"Найдено ссылок на демо-страницы: {len(demo_links)}")
        for link in demo_links[:10]:
            print(f" - {link}")
        
        # Сохраняем список
        with open('data/raw/wiki_demo_links.json', 'w', encoding='utf-8') as f:
            json.dump(demo_links, f, indent=2)
        print("Список сохранен в data/raw/wiki_demo_links.json")
        
    else:
        print(f"Ошибка: {r.status_code}")
except Exception as e:
    print(f"Ошибка: {e}")
