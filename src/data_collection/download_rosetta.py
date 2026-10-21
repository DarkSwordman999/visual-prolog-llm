
import os
import requests
import time

token = os.environ.get("GH_TOKEN", "YOUR_TOKEN_HERE")
headers = {
    "Authorization": f"token {token}",
    "Accept": "application/vnd.github.v3+json"
}

os.makedirs('data/raw/github/rosetta_prolog', exist_ok=True)

url = "https://api.github.com/repos/acmeism/RosettaCodeData/git/trees/master?recursive=1"
resp = requests.get(url, headers=headers)

if resp.status_code == 200:
    tree = resp.json().get('tree', [])
    
    pro_files = [
        item for item in tree 
        if item['path'].endswith('.pro') and 'prolog' in item['path'].lower()
    ]
    
    print(f"Найдено файлов .pro: {len(pro_files)}")
    
    for i, item in enumerate(pro_files):
        file_path = item['path']
        raw_url = f"https://raw.githubusercontent.com/acmeism/RosettaCodeData/master/{file_path}"
        file_resp = requests.get(raw_url)
        
        if file_resp.status_code == 200:
            filename = file_path.replace('/', '_')
            local_path = os.path.join('data/raw/github/rosetta_prolog', filename)
            with open(local_path, 'w', encoding='utf-8') as f:
                f.write(file_resp.text)
            
            if (i + 1) % 20 == 0:
                print(f"Скачано {i + 1} файлов...")
                time.sleep(0.3)
    
    print("Готово! Все файлы скачаны.")
else:
    print(f"Ошибка: {resp.status_code}")
