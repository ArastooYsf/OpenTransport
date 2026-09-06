# Contributing to OpenTransport

Thank you for considering a contribution! OpenTransport is a community-mapped
project by design — nobody can single-handedly keep transit data for every
city in the world accurate, so **every contribution matters**, whether it's
a one-line fix to a station name or a brand-new city dataset.

There are two very different, equally welcome kinds of contribution here:

1. **Transit data** — you don't need to write any Dart to help. If you know a
   city's metro/bus/tram system, you can add or fix it.
2. **Code** — Flutter/Dart contributions to the app itself (UI, state
   management, the future map/routing engine, voice assistant integration).

Read the section that matches what you want to do. Both are described in
full below.

---

## Ground rules

- Be kind — see [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).
- Discuss large changes in an issue or [Discussion](https://github.com/ArastooYsf/OpenTransport/discussions)
  before opening a big PR — it's frustrating to spend hours on a PR that
  turns out to conflict with the project's direction.
- Keep pull requests focused. A PR that adds Tehran's Line 2 *and*
  refactors the theme system is two PRs.
- All new code must pass `flutter analyze` and `dart format --set-exit-if-changed`
  cleanly, and all new data files must pass `python3 scripts/validate_data.py`.
  Both run automatically in CI on every PR — see
  [`.github/workflows/ci.yml`](.github/workflows/ci.yml).

---

## Contributing transit data (no coding required)

This is the single most valuable thing you can contribute — and the most
time-sensitive, since transit lines and stations change over time in the
real world.

### 1. Understand the data format

Every city lives in its own file: `data/<country-iso-code>/<city-slug>.json`
(e.g. `data/iran/tehran.json`). The exact shape of that file is defined,
field by field, in [`schema.json`](schema.json) — that file is the single
source of truth; if this document and `schema.json` ever disagree, trust
`schema.json` and please open an issue so we can fix the doc.

A minimal station looks like this:

```json
{
  "id": "tehran-tajrish",
  "name": { "fa": "تجریش", "en": "Tajrish" },
  "lat": 35.8044,
  "lng": 51.4319,
  "lineIds": ["tehran-line-1"],
  "accessibility": { "elevator": true, "ramp": true }
}
```

Key rules baked into the schema:

- **`name` is a map, not a string.** Include at least the local-language
  name; add `en` too if you can, so the app remains usable for
  non-local-language speakers. See `localizedText` in `schema.json`.
- **`color` on a line must be the real, official color** from the transit
  authority (hex, `#RRGGBB`) — never a color you picked because it "looks
  right." The whole point of `lineColor`-driven UI (see
  [`design.md`](design.md)) is that riders recognize their line by its real
  color.
- **Every line/station needs a stable `id`** that won't change later (other
  records reference it by id) — prefix it with the city slug, e.g.
  `tehran-line-1`, `tehran-tajrish`.
- **`meta.source` is required and matters a lot.** Every dataset must say
  where the data came from (`osm`, `official_gtfs`, `official_other`,
  `community_survey`, or `other`), with a `url` or `note` for traceability.
  This is what lets someone come back in a year and re-verify the data —
  please don't skip it.
- `calendar`, `trips`, and `stopTimes` implement a GTFS-style timetable.
  They're **optional to fill in** for a first PR — an empty array is valid.
  Stations and lines with correct colors and locations are useful on their
  own; timetables can follow in a later PR.

### 2. Find or gather the data

Good sources, roughly in order of preference:

1. **Official GTFS feed**, if the transit authority publishes one — check
   [transitfeeds.com](https://transitfeeds.com) or the authority's own open
   data portal. This is the gold standard: cite it as `official_gtfs`.
2. **Official transit authority website/map/PDF** (fares, hours, official
   line colors) — cite as `official_other` with the URL.
3. **[OpenStreetMap](https://www.openstreetmap.org)** — station
   coordinates and line geometry are usually excellent on OSM. Cite as
   `osm` with a link to the relevant relation/way.
4. **Personal knowledge / a survey you did in person** — totally valid for
   a first pass, but mark it as `community_survey` with a note, so others
   know it may need re-verification against an official source later.

### 3. Write and validate the file

Add or edit the JSON under `data/<country>/<city>.json`, then validate it
before you commit:

```bash
python3 scripts/validate_data.py
```

This checks **every** file under `data/` against `schema.json` and prints
`OK`/`FAIL` per file. Fix any `FAIL` before opening a PR — CI will reject a
PR that fails this check.

If you're adding a country/city folder structure that doesn't fit the
current schema (e.g. a transport concept the schema doesn't model yet),
**update `schema.json` in the same PR**, per the rule in
[`CLAUDE.md`](CLAUDE.md): schema and this contributing guide must never
drift apart.

### 4. Open a PR

Use the **"New transit data"** issue/PR template if you're proposing a new
city from scratch, so reviewers know what to check. One city (or one
meaningful update to an existing city) per PR, please.

---

## Contributing code

### Before you start

Read these three files — the whole codebase is built to follow them
exactly, and PRs that don't will be asked to change:

- [`CLAUDE.md`](CLAUDE.md) — architecture rules, tech stack, folder
  structure, and the "always/never" list.
- [`design.md`](design.md) — every visual decision (color, spacing,
  typography, motion) must trace back to something in this file. If your UI
  idea isn't covered by it, raise it in an issue before implementing.
- [`schema.json`](schema.json) — the data contract, if your change touches
  data parsing or models.

### Local setup

```bash
git clone https://github.com/ArastooYsf/OpenTransport.git
cd OpenTransport
flutter pub get

# Generate localization classes (from lib/l10n/*.arb)
flutter gen-l10n

# Generate the freezed/json_serializable data models
dart run build_runner build --delete-conflicting-outputs
```

Requirements: Flutter 3.44+ (stable channel), Dart 3.12+ (bundled with
Flutter). Run `flutter doctor` to confirm your toolchain is healthy for
your target platform (Android Studio + SDK for Android, Xcode for iOS).

### While you work

- **State management is Riverpod, exclusively.** Don't introduce
  `Provider`, `Bloc`, `GetX`, or raw `setState` for anything beyond a
  widget's own purely-local UI state (e.g. an expand/collapse toggle).
- **UI never touches Hive/Dio/`rootBundle` directly** — always go through a
  repository in `data/`. If you need a new kind of data access, add a
  method to the relevant repository, not a one-off call in a widget.
- **Every screen must work in both LTR and RTL** without layout bugs. Use
  `EdgeInsetsDirectional`, `start`/`end`, and direction-aware widgets —
  never raw `left`/`right`. Test with at least one RTL locale (`fa`) and
  one LTR locale (`en`).
- **Never hardcode a color, spacing value, or font** outside what
  `design.md` defines. Line colors always come from the data file, with a
  computed (never assumed) readable text color — see
  `lib/core/utils/contrast_color.dart`.
- **Never hardcode user-facing strings.** Add a key to
  `lib/l10n/app_en.arb` (the template) and `lib/l10n/app_fa.arb`, then run
  `flutter gen-l10n`.
- Keep `assistant/` a thin, stable interface — don't wire a real voice/AI
  SDK into it yet; that's intentionally deferred.

### Before you open a PR

```bash
dart format lib/ test/ --set-exit-if-changed
flutter analyze
flutter test
python3 scripts/validate_data.py   # only if you touched anything under data/
```

All four run in CI; a red CI check will block review, so it's faster to
catch it locally first.

- Write or update tests for any new data-parsing or state/logic code (a
  UI-only tweak doesn't need one, but a new repository method or provider
  does).
- Keep commits focused and messages descriptive of *why*, not just *what*.
- Open the PR against `main` and fill in the PR template — it asks what
  changed, why, and how you tested it (including, for UI changes, whether
  you checked both an RTL and an LTR locale).

### Good first issues

Look for issues labeled
[`good first issue`](https://github.com/ArastooYsf/OpenTransport/labels/good%20first%20issue)
or [`help wanted`](https://github.com/ArastooYsf/OpenTransport/labels/help%20wanted).
If nothing's labeled yet (the project is brand new!), open a
[Discussion](https://github.com/ArastooYsf/OpenTransport/discussions) and ask
— a maintainer will point you at something.

---

## Getting help

- **Questions about using the app or the codebase:**
  [GitHub Discussions](https://github.com/ArastooYsf/OpenTransport/discussions).
- **A bug you can reproduce:** open an
  [issue](https://github.com/ArastooYsf/OpenTransport/issues/new/choose)
  with the bug report template.
- **An idea for a new feature:** open an issue with the feature request
  template, or start a Discussion first if it's a big change.
- **Found bad or outdated transit data:** open an issue with the "New
  transit data" template — even just flagging it (without fixing it
  yourself) genuinely helps.

Thank you for helping build a transit app that works for riders everywhere,
in their own language, starting with Iran.
