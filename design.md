# design.md — Metro App Design System

Visual and interaction rules for the app. Every UI decision should be traceable to something in this file. If a case isn't covered here, raise it before improvising.

## Design principles

- **Modern and light** — flat surfaces, no heavy shadows or gradients, generous whitespace.
- **Fast-feeling** — every transition under ~400ms unless it's a deliberate route-drawing animation; no UI element should feel like it's waiting on the user.
- **Map-first** — the transit map/line colors are the visual anchor of the app; chrome around it should stay quiet and neutral so lines and stations stand out.

## Color system

- **App neutral palette:** one consistent brand accent color for buttons, active states, and non-map UI (defined once, not per-line). Use a single accent — don't let it compete with line colors.
  - **Chosen accent:** `#0891B2` (a vivid teal-blue/azure). Used for: primary buttons, active nav states, the splash-screen loading bar, focus rings. Pair with a slightly lighter tint (`#22B8D4`-ish) for hover/pressed states, and verify contrast against both light and dark backgrounds before finalizing shades.
- **Line colors:** every metro line uses its real, official color from the transit authority (stored in the data file, not hardcoded). This means the palette is technically unbounded — the UI must be built to look correct with *any* line color, not just a curated set.
  - Always pair a line color with a computed readable text/icon color (white or near-black depending on the line color's luminance) — never assume white text works on every line color.
  - Line color badges/pills: fill = line color, text = whichever of white/near-black passes contrast against it.
- **Dark mode:** required from day one, not a later pass. Line colors stay the same (they're official/recognizable) but surrounding surfaces (backgrounds, cards, text) invert. Test every line color against the dark background for contrast.
- **Semantic colors** (separate from line colors): success/warning/error/info use a fixed neutral set, not derived from any line — used for things like "delay," "closed," "on time."

## Typography

- Needs a font pairing that covers Latin, Persian/Arabic script, and ideally other scripts as more countries are added. Pick a variable/multi-script font family (e.g. a font with full Arabic+Latin coverage) so we're not swapping fonts per locale, which breaks visual consistency.
- Type scale: keep it small — a heading size, a body size, a caption size, one weight for emphasis. Avoid introducing more than 3–4 sizes total; this is a utility app, not an editorial one.
- Numerals (arrival times, line numbers): decide once whether to always show Western digits or locale-appropriate digits, and apply that rule everywhere consistently — mixed digit styles in the same screen look broken.

## Layout & RTL

- Every screen must work mirrored (RTL) and unmirrored (LTR) without layout bugs — this isn't a Persian-only afterthought, it's core given the multi-country goal.
- Use direction-agnostic spacing/alignment (start/end, not left/right) throughout.
- Bottom navigation / primary actions stay within comfortable thumb reach — this is a one-handed, often-in-transit app.

## Motion

- Route/path drawing (origin → destination) uses a progressive reveal along the actual path geometry with an ease-out curve — fast start, gentle settle at the end. Don't animate at constant speed; it reads as robotic.
- Station-to-station progress (e.g. live train position) animates positionally, not by instantly jumping — mirrors real physical motion.
- Keep decorative motion minimal — motion should always be explaining something (progress, position, transition), never just decoration.

## Components (initial set)

- **Line badge:** rounded pill, filled with line color, short line identifier (number/letter) as text.
- **Station chip/row:** name + line badges for any interchange lines at that station.
- **Route card:** origin, destination, duration, number of transfers, at-a-glance.
- **Map surface:** minimal, neutral base map; transit lines and stations are the highest-contrast elements on screen.

## Open questions to revisit

- Specific multi-script font family selection.
- Icon set for transport mode beyond metro (bus/tram) if scope expands later.
