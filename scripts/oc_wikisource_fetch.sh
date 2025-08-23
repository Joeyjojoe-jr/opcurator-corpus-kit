#!/usr/bin/env bash
set -euo pipefail
CSV="${1:-manifests/wikisource_curated.csv}"
OUTDIR="${2:-/data/wikisource}"
source ~/operational_curator_v5/.venv_curator/bin/activate
cd "/home/joeyjojo/projects/philosopher-theologian-dataset-factory_20250815_113809" || exit 1
export PYTHONPATH="$PWD/tools:$PYTHONPATH"
mkdir -p "$OUTDIR"
