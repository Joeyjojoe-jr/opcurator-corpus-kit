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
        header_columns = set(reader.fieldnames)
        missing_cols = REQUIRED_COLUMNS - header_columns
        extra_cols = header_columns - REQUIRED_COLUMNS

        if missing_cols or extra_cols:
            error_messages = []
            if missing_cols:
                error_messages.append(f"missing columns: {', '.join(sorted(missing_cols))}")
            if extra_cols:
                error_messages.append(f"unexpected columns: {', '.join(sorted(extra_cols))}")
            raise ValueError("; ".join(error_messages))
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
