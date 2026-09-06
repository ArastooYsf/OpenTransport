import 'package:flutter/material.dart';

/// App-wide theme, built from design.md's principles.
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

  /// design.md's Typography section: Vazirmatn for Persian/Arabic script,
  /// Inter for Latin script.
  static const persianFontFamily = 'Vazirmatn';
  static const latinFontFamily = 'Inter';

  /// The script-appropriate font family for [locale], per design.md — with
  /// the other family listed as a fallback so a stray other-script string
  /// (e.g. a language field showing an endonym like "فارسی" while the UI
  /// itself is in English) still renders in its own font rather than
  /// falling back to a system default.
  static String fontFamilyFor(Locale locale) =>
      locale.languageCode == 'fa' ? persianFontFamily : latinFontFamily;

  static List<String> fontFamilyFallbackFor(Locale locale) => [
    locale.languageCode == 'fa' ? latinFontFamily : persianFontFamily,
  ];

  static ThemeData light(Locale locale) => _themeFrom(Brightness.light, locale);

  static ThemeData dark(Locale locale) => _themeFrom(Brightness.dark, locale);

  static ThemeData _themeFrom(Brightness brightness, Locale locale) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: accent,
        brightness: brightness,
      ),
      fontFamily: fontFamilyFor(locale),
      fontFamilyFallback: fontFamilyFallbackFor(locale),
      // Modern and light: flat surfaces, no heavy shadows (design.md).
      appBarTheme: const AppBarTheme(elevation: 0, scrolledUnderElevation: 1),
      cardTheme: const CardThemeData(elevation: 0),
    );
  }
}
