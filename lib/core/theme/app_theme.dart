import 'package:flutter/material.dart';

/// App-wide theme, built from design.md's principles.
///
/// The brand accent (`#0891B2`) is design.md's chosen "App neutral palette"
/// color — see its Color system section. design.md still leaves the
/// multi-script font family as an open question, so typography uses the
/// Material 3 default until that's decided.
abstract final class AppTheme {
  /// design.md's literal chosen accent hex. Exposed directly (rather than
  /// only via [ColorScheme.primary]) for the handful of places design.md
  /// calls out by exact color — e.g. the splash-screen loading bar — since
  /// Material 3's seed-to-tonal-palette generation can shift the seed
  /// color slightly and isn't guaranteed to preserve it exactly.
  static const accent = Color(0xFF0891B2);

  /// design.md's semantic colors — fixed, never derived from a line color.
  static const success = Color(0xFF16A34A);
  static const warning = Color(0xFFF59E0B);

  static ThemeData light() => _themeFrom(Brightness.light);

  static ThemeData dark() => _themeFrom(Brightness.dark);

  static ThemeData _themeFrom(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: accent,
        brightness: brightness,
      ),
      // Modern and light: flat surfaces, no heavy shadows (design.md).
      appBarTheme: const AppBarTheme(elevation: 0, scrolledUnderElevation: 1),
      cardTheme: const CardThemeData(elevation: 0),
    );
  }
}
