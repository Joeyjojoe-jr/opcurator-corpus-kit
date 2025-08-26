#!/usr/bin/env python3
"""Validate manifest CSV files for required columns and non-empty fields."""

import argparse
import csv
import sys
from typing import FrozenSet

REQUIRED_COLUMNS: FrozenSet[str] = frozenset([
    "path",
    "title",
    "author",
    "translator",
    "year",
    "language",
    "license_raw",
    "license_norm",
    "source_url",
])

def validate_manifest(path: str) -> None:
    with open(path, newline='', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        if reader.fieldnames is None:
            raise ValueError("missing header")
        missing_cols = [c for c in REQUIRED_COLUMNS if c not in reader.fieldnames]
        extra_cols = [c for c in reader.fieldnames if c not in REQUIRED_COLUMNS]
        if missing_cols:
            raise ValueError(f"missing columns: {', '.join(missing_cols)}")
        if extra_cols:
            raise ValueError(f"unexpected columns: {', '.join(extra_cols)}")
        for line_num, row in enumerate(reader, start=2):
            missing = [c for c in REQUIRED_COLUMNS if not row.get(c)]
            if missing:
                raise ValueError(f"line {line_num} missing values for: {', '.join(missing)}")

def main() -> None:
    parser = argparse.ArgumentParser(description="Validate manifest CSV files.")
    parser.add_argument("manifests", nargs="+", help="Path(s) to manifest CSV files.")
    args = parser.parse_args()

    ok = True
    for path in args.manifests:
        try:
            validate_manifest(path)
            print(f"{path}: OK")
        except Exception as exc:  # pylint: disable=broad-except
            print(f"{path}: {exc}", file=sys.stderr)
            ok = False
    if not ok:
        sys.exit(1)

if __name__ == "__main__":
    main()
