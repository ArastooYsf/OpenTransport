#!/usr/bin/env python3
"""Validate every bundled transit data file against schema.json.

Usage: python3 scripts/validate_data.py
Run this before committing any change under data/.
"""
import json
import sys
from pathlib import Path

import jsonschema

ROOT = Path(__file__).resolve().parent.parent
SCHEMA_PATH = ROOT / "schema.json"
DATA_DIR = ROOT / "data"


def main() -> int:
    schema = json.loads(SCHEMA_PATH.read_text())
    data_files = sorted(DATA_DIR.glob("*/*.json"))

    if not data_files:
        print(f"No data files found under {DATA_DIR}")
        return 1

    failed = False
    for path in data_files:
        rel = path.relative_to(ROOT)
        try:
            instance = json.loads(path.read_text())
            jsonschema.validate(instance=instance, schema=schema)
            print(f"OK    {rel}")
        except (json.JSONDecodeError, jsonschema.ValidationError) as exc:
            failed = True
            print(f"FAIL  {rel}\n      {exc}")

    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
