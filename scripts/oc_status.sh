#!/usr/bin/env bash
set -euo pipefail
source ~/operational_curator_v5/.venv_curator/bin/activate
cd "/home/joeyjojo/projects/philosopher-theologian-dataset-factory_20250815_113809" || exit 1
export PYTHONPATH="$PWD/tools:$PYTHONPATH"
export HOT="/mnt/ssd1/Library"
wc -l "/mnt/ssd1/Library/WorldClass/_all/edges.jsonl" || true
python - <<'PY'
import faiss
idx = faiss.read_index("/mnt/ssd1/Library/WorldClass/_all/index.faiss")
print("FAISS ntotal:", idx.ntotal)
print("meta lines:", sum(1 for _ in open("/mnt/ssd1/Library/WorldClass/_all/meta.jsonl", 'r', encoding='utf-8')))
print("cards lines:", sum(1 for _ in open("/mnt/ssd1/Library/WorldClass/_all/cards.jsonl", 'r', encoding='utf-8')))
PY
python tools/search_faiss.py "/mnt/ssd1/Library/WorldClass/_all/index.faiss" "/mnt/ssd1/Library/WorldClass/_all/meta.jsonl" "justice and the ideal state" --k 5 | head -n 5
python tools/search_faiss.py "/mnt/ssd1/Library/WorldClass/_all/index.faiss" "/mnt/ssd1/Library/WorldClass/_all/meta.jsonl" "social contract vs state of nature" --k 5 | head -n 5
