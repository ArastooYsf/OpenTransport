import 'dart:ui' show Color;

/// Picks white or near-black text for readability against [background],
/// per design.md's line-badge contrast rule: never assume white text works
/// on every line color, since line colors are arbitrary and unbounded.
Color readableTextColorFor(Color background) {
  // Relative luminance (WCAG). Values above the midpoint read as "light"
  // backgrounds, which need dark text for contrast.
  final luminance = background.computeLuminance();
  return luminance > 0.5 ? _nearBlack : _white;
}

const _white = Color(0xFFFFFFFF);
// Near-black rather than pure black, matching design.md's "near-black" spec
// so dark-on-light text still feels soft against saturated line colors.
const _nearBlack = Color(0xFF1A1A1A);
