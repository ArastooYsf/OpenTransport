## What does this PR do?

<!-- One or two sentences. If it fixes an open issue, write "Fixes #123". -->

## Type of change

- [ ] Code change (UI, state management, logic)
- [ ] New or updated transit data (`data/<country>/<city>.json`)
- [ ] Schema change (`schema.json`) — must be paired with a `CONTRIBUTING.md` update per CLAUDE.md
- [ ] Documentation only
- [ ] Other (please describe)

## Checklist

<!-- Delete sections that don't apply to this PR. -->

**If this touches code:**

- [ ] `dart format lib/ test/ --set-exit-if-changed` passes
- [ ] `flutter analyze` passes with no issues
- [ ] `flutter test` passes
- [ ] I tested UI changes in at least one **LTR** locale (e.g. `en`) and one **RTL** locale (`fa`)
- [ ] No hardcoded colors/spacing/fonts outside `design.md`, no hardcoded user-facing strings outside ARB files (see `CLAUDE.md`)
- [ ] I added/updated tests for any new data-parsing or state/logic code

**If this touches `data/`:**

- [ ] `python3 scripts/validate_data.py` passes for every file I added/changed
- [ ] Every line's `color` is the real official color from the transit authority
- [ ] Every new line/station/etc. has a stable, city-prefixed `id`
- [ ] `meta.source` is filled in with where this data came from
- [ ] Station/line `name` includes at least the local-language text

## How was this tested?

<!-- Manual steps, screenshots/screen recordings for UI changes, or which automated tests cover it. -->
