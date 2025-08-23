#!/usr/bin/env bash
set -euo pipefail
CSV="${1:-manifests/wikisource_curated.csv}"
OUTDIR="${2:-/data/wikisource}"
SHELF="/mnt/ssd1/Library/WorldClass/Wikisource"
source ~/operational_curator_v5/.venv_curator/bin/activate
cd "/home/joeyjojo/projects/philosopher-theologian-dataset-factory_20250815_113809" || exit 1
export PYTHONPATH="$PWD/tools:$PYTHONPATH"
mkdir -p "$SHELF"
python tools/ingest_files.py --manifest "$OUTDIR/_manifest_resolved.csv" --base-dir "$SHELF" --shelf-name "Wikisource" --license-filter "PD|CC-BY|CC-BY-SA" --min-words 150 --fresh
cat "$SHELF/cards.jsonl" >> "/mnt/ssd1/Library/WorldClass/_all/cards.jsonl"
cat "$SHELF/edges.jsonl" >> "/mnt/ssd1/Library/WorldClass/_all/edges.jsonl"
python tools/build_faiss.py "/mnt/ssd1/Library/WorldClass/_all/cards.jsonl" "/mnt/ssd1/Library/WorldClass/_all/index.faiss" "/mnt/ssd1/Library/WorldClass/_all/meta.jsonl"
