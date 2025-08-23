#!/usr/bin/env bash
source ~/operational_curator_v5/.venv_curator/bin/activate
cd "/home/joeyjojo/projects/philosopher-theologian-dataset-factory_20250815_113809" || exit 1
export PYTHONPATH="$PWD/tools:$PYTHONPATH"
export HOT="/mnt/ssd1/Library"
mkdir -p "/mnt/ssd1/.hf" && chmod 700 "/mnt/ssd1/.hf"
export HF_HOME="/mnt/ssd1/.hf"
export HF_HUB_ENABLE_HF_TRANSFER=1
find "$HF_HOME" -type f -name "*.lock" -delete 2>/dev/null
