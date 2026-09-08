# CLAUDE.md — Metro App Project

This file gives Claude (via Claude Code) the context it needs to work on this repository correctly and consistently. Read this before making changes.

## Project summary

**OpenTransport** — a cross-platform mobile app (Android + iOS) showing public transit systems worldwide, starting with metro in Iran, built to expand to bus/tram/BRT later. Open source, built for community contribution of transit data for new countries/cities. Long-term goal: voice-assistant integration (Siri Shortcuts, Google Assistant App Actions).

Design language: modern, light, fast, minimal. See `design.md` for all visual rules — never invent colors, spacing, or type styles outside it.

## Tech stack

- **Framework:** Flutter (Dart), single codebase for Android + iOS.
- **State management:** Riverpod. Use providers for all cross-widget state; avoid `setState` outside purely local widget-internal UI state (e.g. an expanded/collapsed toggle).
- **Local storage/cache:** Hive (or Isar if the schema grows relational) for offline-cached transit data and user preferences.
- **Networking:** Dio, isolated behind a `data/remote/` layer — never call it directly from UI code.
- **i18n:** `flutter_localizations` + ARB files. The app is multi-language from day one (see below) — never hardcode user-facing strings.

## Architecture rules

- Strict separation: `core/`, `data/`, `features/`, `assistant/`. UI widgets never talk to Hive/Dio directly — always go through a repository in `data/`.
- Each `features/<name>/` folder is self-contained: its own widgets, providers, and models. Cross-feature sharing goes through `core/` or `data/`, not direct imports between feature folders.
- `assistant/` is a thin abstraction layer for future voice/AI integration (e.g. `AssistantIntent`, `AssistantAction`). Don't wire real AI/voice SDKs into it yet — just keep the interface stable so it can be implemented later without touching feature code.

## Transit data (critical — this is the contribution surface)

Data is split into three independently-evolving layers — never merge them back together:

1. **Structure** — `/data/<country>/<city>.json`, validated against `/structure.schema.json`. Lines and stations: geometry, names, colors, accessibility. Changes rarely (new stations/lines).
2. **Schedule** — `/data/<country>/<city>.schedule.json`, validated against `/schedule.schema.json`. calendar/trips/stopTimes (GTFS-style timing). References station/line ids from the structure file by string id — validate those cross-file references in `scripts/validate_data.py`, not just per-file JSON Schema. Changes on its own cadence (timetable revisions) independent of structure changes.
3. **Live status (not a bundled file at all)** — fetched at runtime from the backend (Supabase/Workers), not shipped in the app or in `/data/`. Represents a per-trip estimated delay, computed by an algorithm from crowd-sourced user reports ("this train left late"). Until that algorithm exists, always default to zero delay (display scheduled time as-is) — build the UI to already expect this value can change from 0 later without a UI rework (e.g. a `delaySeconds` field on the in-app trip state, sourced from the backend, defaulting to 0).

- **Never hand-edit structure or schedule data without validating against the matching schema first.** Run the validation script in `/scripts/` before committing any data change.
- Any generated/estimated schedule value (e.g. derived from published frequency bands rather than an official minute-by-minute feed) must be traceable to a real cited source in that file's `meta.source`, with a note flagging it as an estimate. Never invent timing numbers with no source.
- Per-line colors must come from the structure data file (`lineColor` field per official transit authority), not hardcoded in Dart. UI reads color from data, falls back to a neutral gray if missing.
- When adding a new country/city dataset, update both schemas (if the shape needs to change) and `CONTRIBUTING.md` together — they must never drift apart.

## Internationalization

- The app supports multiple languages and scripts from the start (not just Persian/English) — RTL and LTR both must render correctly everywhere. Test every new screen in at least one RTL and one LTR locale.
- Station/city names in data files should carry a `name` map keyed by locale code, not a single string.
- Never bake text direction assumptions into layout code — use Flutter's `Directionality`-aware widgets (`EdgeInsetsDirectional`, `TextDirection.ltr/rtl` aware `Row`s, etc.), not raw `left`/`right`.

## Coding conventions

- Null safety everywhere, no `!` unless truly unavoidable — prefer proper null handling.
- Format with `dart format` and pass `flutter analyze` clean before considering any task done.
- Prefer small, focused widgets over large `build()` methods.
- Every public method/class that isn't self-explanatory gets a doc comment.

## What Claude should always do

1. Check `design.md` before writing any UI code.
2. Check `structure.schema.json`/`schedule.schema.json` before touching any transit data file.
3. Run `flutter analyze` and `dart format` after code changes.
4. Keep the offline-first guarantee intact — never introduce a hard network dependency.
5. Write or update tests for any new data-parsing or routing-logic code.

## What Claude should never do

- Never hardcode a color, spacing value, or font outside what's defined in `design.md`.
- Never hardcode user-facing strings — always route through ARB/localization.
- Never assume LTR-only layout.
- Never introduce a new state-management pattern alongside Riverpod.