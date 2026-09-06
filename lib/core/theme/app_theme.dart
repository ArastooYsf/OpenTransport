import 'package:flutter/material.dart';

/// App-wide theme, built from design.md's principles.
///
/// design.md leaves the exact brand accent color and multi-script font
/// family as open questions (see "Open questions to revisit"). Until those
/// are decided, this uses Material 3's seed-color system as a neutral
/// placeholder rather than inventing a specific hex value — swap
/// [_placeholderSeed] once an accent color is chosen.
abstract final class AppTheme {
  static const _placeholderSeed = Colors.indigo;

  static ThemeData light() => _themeFrom(Brightness.light);

  static ThemeData dark() => _themeFrom(Brightness.dark);

  static ThemeData _themeFrom(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _placeholderSeed,
        brightness: brightness,
      ),
      // Modern and light: flat surfaces, no heavy shadows (design.md).
      appBarTheme: const AppBarTheme(elevation: 0, scrolledUnderElevation: 1),
      cardTheme: const CardThemeData(elevation: 0),
    );
  }
}
