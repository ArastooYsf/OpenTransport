import 'package:flutter/material.dart';

/// App-wide theme, built from design.md's principles.
///
/// The brand accent (`#0891B2`) is design.md's chosen "App neutral palette"
/// color — see its Color system section. design.md still leaves the
/// multi-script font family as an open question, so typography uses the
/// Material 3 default until that's decided.
abstract final class AppTheme {
  static const _accentSeed = Color(0xFF0891B2);

  static ThemeData light() => _themeFrom(Brightness.light);

  static ThemeData dark() => _themeFrom(Brightness.dark);

  static ThemeData _themeFrom(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _accentSeed,
        brightness: brightness,
      ),
      // Modern and light: flat surfaces, no heavy shadows (design.md).
      appBarTheme: const AppBarTheme(elevation: 0, scrolledUnderElevation: 1),
      cardTheme: const CardThemeData(elevation: 0),
    );
  }
}
