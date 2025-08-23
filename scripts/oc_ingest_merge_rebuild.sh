#!/usr/bin/env bash
set -euo pipefail
source ~/operational_curator_v5/.venv_curator/bin/activate
cd "/home/joeyjojo/projects/philosopher-theologian-dataset-factory_20250815_113809" || exit 1
export PYTHONPATH="$PWD/tools:$PYTHONPATH"
export HOT="/mnt/ssd1/Library"
python tools/ingest_files.py --manifest manifests/gutenberg_philosophy_example.csv --base-dir "/mnt/ssd1/Library/WorldClass/GutenbergPhilosophy" --shelf-name "GutenbergPhilosophy" --license-filter "PD|CC-BY|CC-BY-SA" --lang "eng" --min-words 200 --fresh
cat "/mnt/ssd1/Library/WorldClass/GutenbergPhilosophy/cards.jsonl" >> "/mnt/ssd1/Library/WorldClass/_all/cards.jsonl"
cat "/mnt/ssd1/Library/WorldClass/GutenbergPhilosophy/edges.jsonl" >> "/mnt/ssd1/Library/WorldClass/_all/edges.jsonl"
python tools/build_faiss.py "/mnt/ssd1/Library/WorldClass/_all/cards.jsonl" "/mnt/ssd1/Library/WorldClass/_all/index.faiss" "/mnt/ssd1/Library/WorldClass/_all/meta.jsonl"
