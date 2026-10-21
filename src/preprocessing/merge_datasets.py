
import json
import hashlib

with open('data/processed/dataset_wiki_archives.jsonl', 'r', encoding='utf-8') as f:
    archive_data = [json.loads(line) for line in f]

unique_data = {}
for item in archive_data:
    content_hash = hashlib.md5(item['output'].encode('utf-8')).hexdigest()
    if content_hash not in unique_data:
        unique_data[content_hash] = item

with open('data/processed/dataset_wiki_archives_clean.jsonl', 'w', encoding='utf-8') as f:
    for item in unique_data.values():
        f.write(json.dumps(item, ensure_ascii=False) + '\n')

all_data = []
with open('data/processed/dataset_visual_prolog.jsonl', 'r', encoding='utf-8') as f:
    for line in f: all_data.append(json.loads(line))

with open('data/processed/dataset_wiki_archives_clean.jsonl', 'r', encoding='utf-8') as f:
    for line in f: all_data.append(json.loads(line))

with open('data/processed/final_dataset.jsonl', 'w', encoding='utf-8') as f:
    for item in all_data:
        f.write(json.dumps(item, ensure_ascii=False) + '\n')
