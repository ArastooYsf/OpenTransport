# CLAUDE.md — Metro App Project

This file gives Claude (via Claude Code) the context it needs to work on this repository correctly and consistently. Read this before making changes.

## Project summary

A cross-platform mobile app (Android + iOS) showing metro/subway systems worldwide, starting with Iran. Open source, built for community contribution of transit data for new countries/cities. Long-term goal: voice-assistant integration (Siri Shortcuts, Google Assistant App Actions).

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

- Bundled data lives in `/data/<country>/<city>.json`, validated against `/data/schema.json`.
- **Never hand-edit bundled data without validating against the schema first.** Run the validation script in `/scripts/` before committing any data change.
- Data is hybrid: the app ships with bundled JSON for offline use, and checks a remote manifest for updates/new cities. When adding sync logic, always keep a working fully-offline fallback — the app must never hard-depend on network access.
- Per-line colors must come from the data file (`lineColor` field per official transit authority), not hardcoded in Dart. UI reads color from data, falls back to a neutral gray if missing.
- When adding a new country/city dataset structure, update `schema.json` and `CONTRIBUTING.md` together — they must never drift apart.

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
2. Check `data/schema.json` before touching any transit data file.
3. Run `flutter analyze` and `dart format` after code changes.
4. Keep the offline-first guarantee intact — never introduce a hard network dependency.
5. Write or update tests for any new data-parsing or routing-logic code.

## What Claude should never do

- Never hardcode a color, spacing value, or font outside what's defined in `design.md`.
- Never hardcode user-facing strings — always route through ARB/localization.
- Never assume LTR-only layout.
- Never introduce a new state-management pattern alongside Riverpod.
