#!/usr/bin/env python3
"""Validate every bundled transit data file against its matching schema.

Structure files (data/<country>/<city>.json) validate against
structure.schema.json; schedule files (data/<country>/<city>.schedule.json)
validate against schedule.schema.json. A schedule file's lineId/stationId
references are also cross-checked against its companion structure file,
since that's not expressible in either schema in isolation.

Usage: python3 scripts/validate_data.py
Run this before committing any change under data/.
"""
import json
import sys
from pathlib import Path

import jsonschema

ROOT = Path(__file__).resolve().parent.parent
STRUCTURE_SCHEMA_PATH = ROOT / "structure.schema.json"
SCHEDULE_SCHEMA_PATH = ROOT / "schedule.schema.json"
DATA_DIR = ROOT / "data"


def cross_check(structure: dict, schedule: dict, rel: Path) -> list[str]:
    line_ids = {line["id"] for line in structure.get("lines", [])}
    station_ids = {station["id"] for station in structure.get("stations", [])}

    errors = []
    for trip in schedule.get("trips", []):
        if trip["lineId"] not in line_ids:
            errors.append(
                f"trip {trip['id']!r} references unknown lineId {trip['lineId']!r}"
            )
    for stop_time in schedule.get("stopTimes", []):
        if stop_time["stationId"] not in station_ids:
            errors.append(
                f"stopTime for trip {stop_time['tripId']!r} references "
                f"unknown stationId {stop_time['stationId']!r}"
            )
    return errors


def main() -> int:
    structure_schema = json.loads(STRUCTURE_SCHEMA_PATH.read_text())
    schedule_schema = json.loads(SCHEDULE_SCHEMA_PATH.read_text())

    all_files = sorted(DATA_DIR.glob("*/*.json"))
    schedule_files = {f for f in all_files if f.name.endswith(".schedule.json")}
    structure_files = [f for f in all_files if f not in schedule_files]

    if not all_files:
        print(f"No data files found under {DATA_DIR}")
        return 1

    failed = False
    parsed_structures: dict[Path, dict] = {}
    parsed_schedules: dict[Path, dict] = {}

    for path in structure_files:
        rel = path.relative_to(ROOT)
        try:
            instance = json.loads(path.read_text())
            jsonschema.validate(instance=instance, schema=structure_schema)
            parsed_structures[path] = instance
            print(f"OK    {rel}")
        except (json.JSONDecodeError, jsonschema.ValidationError) as exc:
            failed = True
            print(f"FAIL  {rel}\n      {exc}")

    for path in sorted(schedule_files):
        rel = path.relative_to(ROOT)
        try:
            instance = json.loads(path.read_text())
            jsonschema.validate(instance=instance, schema=schedule_schema)
            parsed_schedules[path] = instance
            print(f"OK    {rel}")
        except (json.JSONDecodeError, jsonschema.ValidationError) as exc:
            failed = True
            print(f"FAIL  {rel}\n      {exc}")

    for schedule_path, schedule in parsed_schedules.items():
        structure_path = schedule_path.with_name(
            schedule_path.name.removesuffix(".schedule.json") + ".json"
        )
        rel = schedule_path.relative_to(ROOT)
        structure = parsed_structures.get(structure_path)
        if structure is None:
            failed = True
            print(f"FAIL  {rel}\n      no companion structure file {structure_path.relative_to(ROOT)}")
            continue

        errors = cross_check(structure, schedule, rel)
        if errors:
            failed = True
            print(f"FAIL  {rel} (cross-file references)")
            for error in errors:
                print(f"      {error}")
        else:
            print(f"OK    {rel} (cross-file references)")

    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
