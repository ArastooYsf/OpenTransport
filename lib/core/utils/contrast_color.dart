import 'dart:ui' show Color;

/// Picks white or near-black text for readability against [background],
/// per design.md's line-badge contrast rule: never assume white text works
/// on every line color, since line colors are arbitrary and unbounded.
///
/// Picks whichever of the two candidates has the higher *actual* WCAG
/// contrast ratio against [background] — not a `luminance > 0.5` split.
/// That simpler split gets it wrong for plenty of real colors: for a
/// mid-tone, moderately saturated hue (design.md's own accent/success/
/// danger/info tokens included), near-black can have meaningfully better
/// contrast than white even though the background's own luminance is under
/// 0.5. Cross-checked against design.md's exact hex values directly rather
/// than assumed.
Color readableTextColorFor(Color background) {
  final backgroundLuminance = background.computeLuminance();
  final contrastWithWhite = _contrastRatio(1, backgroundLuminance);
  final contrastWithNearBlack = _contrastRatio(
    _nearBlack.computeLuminance(),
    backgroundLuminance,
  );
  return contrastWithNearBlack >= contrastWithWhite ? _nearBlack : _white;
}

/// The WCAG relative-luminance contrast ratio between two already-computed
/// luminance values, each in [0, 1].
double _contrastRatio(double luminanceA, double luminanceB) {
  final lighter = luminanceA > luminanceB ? luminanceA : luminanceB;
  final darker = luminanceA > luminanceB ? luminanceB : luminanceA;
  return (lighter + 0.05) / (darker + 0.05);
}

const _white = Color(0xFFFFFFFF);
// Near-black rather than pure black, matching design.md's "near-black" spec
// so dark-on-light text still feels soft against saturated line colors.
const _nearBlack = Color(0xFF1A1A1A);
