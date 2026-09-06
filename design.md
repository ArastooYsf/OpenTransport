# design.md — Metro App Design System

Visual and interaction rules for the app. Every UI decision should be traceable to something in this file. If a case isn't covered here, raise it before improvising.

## Design principles

- **Modern, colorful, Material-inspired** — pill-shaped controls, medium border radii, gentle-but-visible elevation (not flat, not heavy). Think modern Google/Material apps, not flat Notion/Linear minimalism.
- **Fast-feeling** — every transition under ~400ms unless it's a deliberate route-drawing or onboarding animation; no UI element should feel like it's waiting on the user.
- **Map-first** — the transit map/line colors are the visual anchor of the app; chrome around it should stay quiet enough that lines and stations stand out.

## Color system

Exact, final values — do not substitute similar-looking shades. This palette exists specifically to avoid colors reading as "too dark" or "too similar to each other."

**Accent (both themes):**
- `accentLight` (light theme primary): `#0891B2`
- `accentDark` (dark theme primary — brightened for contrast on dark backgrounds): `#22D3EE`
- `accentPressed`/hover tint: `#22B8D4` (light theme), `#67E8F9` (dark theme)

**Light theme surfaces/text:**
- `background`: `#F7FAFC`
- `surface` (cards, fields): `#FFFFFF`
- `surfaceElevated` (dialogs, dropdowns, sheets): `#FFFFFF` + shadow (see Elevation)
- `border`: `#E2E8F0`
- `textPrimary`: `#1A202C`
- `textSecondary`: `#64748B`

**Dark theme surfaces/text:**
- `background`: `#0F172A`
- `surface` (cards, fields): `#1E293B`
- `surfaceElevated` (dialogs, dropdowns, sheets): `#28374D`
- `border`: `#334155`
- `textPrimary`: `#F1F5F9`
- `textSecondary`: `#94A3B8`

**Semantic colors (deliberately distinct hues from each other and from the accent — never reuse the accent hue for a semantic meaning):**
- `success`: `#16A34A` (light) / `#22C55E` (dark)
- `warning`: `#F59E0B` (light) / `#FBBF24` (dark)
- `danger`: `#EF4444` (light) / `#F87171` (dark)
- `info`: `#3B82F6` (light) / `#60A5FA` (dark) — note: intentionally a different hue family from the teal accent so "info" never gets confused with brand/accent elements.

**Line colors:** every metro/transit line uses its real, official color from the transit authority (stored in the data file, not hardcoded). The UI must look correct with *any* line color.
- Always pair a line color with a computed readable text/icon color (white or near-black depending on the line color's luminance).
- Line badges/pills: fill = line color, text = whichever of white/near-black passes contrast against it.

**Theme switching:** full light AND dark mode from day one, following the OS system setting by default, with a manual override in app settings. Line colors stay identical in both themes; only the tokens above change.

## Typography

- **Persian/Arabic script:** Shabnam FD (all weights available — use Regular for body, Medium/Bold for emphasis and headings).
- **Latin script:** Rubik — a geometric, rounded-leaning sans-serif that stylistically pairs well with Shabnam FD's clean/modern character and fits the Material-inspired direction (Inter is an acceptable fallback if Rubik's language coverage is ever insufficient for a specific added country).
- As more countries/scripts get added, pick each new script's pairing for the same geometric/modern character Shabnam FD + Rubik establish — don't let a mismatched font (e.g. an ornate serif) break the visual consistency.
- Type scale: keep it small — a heading size, a body size, a caption size, one weight for emphasis. Avoid introducing more than 3–4 sizes total; this is a utility app, not an editorial one.
- Numerals (arrival times, line numbers): decide once whether to always show Western digits or locale-appropriate digits, and apply that rule everywhere consistently — mixed digit styles in the same screen look broken.

## Iconography

- **Icon set:** Phosphor Icons — wide coverage, consistent stroke weight, and it ships distinct "regular" (outline) and "fill" weight variants, which maps directly onto our state system below.
- **Mixed weight system:** use the **regular/outline** weight for inactive, unselected, or default-state icons; switch to the **fill/filled** weight when that icon represents the active, selected, or current state (e.g. an unselected bottom-nav icon is outline, the selected one is filled; an "upcoming" onboarding-step icon is outline-style, "current"/"completed" use filled icons).

## Elevation

- Material-like elevation — shadows should be visibly present, not flat/borderless, but stay soft-edged (no harsh drop-shadows).
- Suggested scale (adapt values as needed once implemented):
  - Level 0 (base background): no shadow.
  - Level 1 (resting cards, list rows): subtle shadow, barely-there but visible on close look.
  - Level 2 (raised buttons, active cards, dropdowns/menus): clearly visible soft shadow.
  - Level 3 (dialogs, bottom sheets, floating action elements): the most pronounced shadow in the system — should read as "floating above everything else."
- In dark mode, express elevation with a combination of a lighter surface tint AND shadow (shadow alone reads poorly on dark backgrounds).

## Spacing

- Base unit: 8dp grid (use multiples of 8, with 4 allowed as a half-step for tight spots like icon-to-label gaps).
- Target density: **balanced** — not cramped, not overly airy. As a reference: card internal padding ~16dp, gap between stacked fields ~16-20dp, gap between a field group and its primary action button noticeably larger (~32dp+) so the button reads as a separate, final action.
- Keep spacing values consistent across similar components — don't let two visually-similar cards use different internal padding.

## Layout & RTL

- Every screen must work mirrored (RTL) and unmirrored (LTR) without layout bugs — this isn't a Persian-only afterthought, it's core given the multi-country goal.
- Use direction-agnostic spacing/alignment (start/end, not left/right) throughout.
- Bottom navigation / primary actions stay within comfortable thumb reach — this is a one-handed, often-in-transit app.

## Motion

- Route/path drawing (origin → destination) uses a progressive reveal along the actual path geometry with an ease-out curve — fast start, gentle settle at the end.
- Station-to-station progress (e.g. live train position) animates positionally, not by instantly jumping.
- Onboarding/progress indicators (e.g. the step-wizard connector line) fill proportionally to actual completion (e.g. fields filled within a step), animated smoothly — never an instant jump.
- Primary-action confirmation (e.g. a "Continue" button press) can use a short, deliberate animation (such as a glowing border trace around the button) to communicate "processing" — keep it under ~1s total including any settle/pause, so it reads as responsive, not as an artificial delay.
- Keep decorative motion minimal outside of deliberate onboarding/brand moments (like a first-launch greeting) — everyday UI motion should always be explaining something (progress, position, transition), never just decoration.

## Components (initial set)

- **Line badge:** rounded pill, filled with line color, short line identifier (number/letter) as text.
- **Station chip/row:** name + line badges for any interchange lines at that station.
- **Route card:** origin, destination, duration, number of transfers, at-a-glance.
- **Map surface:** minimal, neutral base map; transit lines and stations are the highest-contrast elements on screen.
- **Input field:** modern login/signup-style — rounded (medium radius), clear label, visible focus state, inline validation feedback (icon + color, not just a border color change).
- **Dropdown/autocomplete overlay:** animated scale+fade entrance from the field, options as clearly separated rows with comfortable tap height (~48dp) — never a cramped plain list.
- **Step indicator (onboarding-style):** circles connected by a line; the line fills proportionally to progress; each circle shows one of: upcoming (outline icon, muted), current (filled icon, accent color, slightly scaled up), completed (filled checkmark, success color), skipped/incomplete (filled warning icon, warning color).

## Open questions to revisit

- None currently open — revisit this section as new components/screens raise new questions.