import 'package:flutter/material.dart';

import '../utils/contrast_color.dart';

/// design.md's Motion section, made concrete: one shared duration/curve
/// vocabulary so every implicit animation in the app (icon morphs, field
/// clear buttons, dropdown entrances, step transitions) reads as the same
/// motion language instead of each widget picking its own numbers.
///
/// [GreetingScreen]'s cycling-word crossfade and hand-wave are the one
/// deliberate exception design.md itself calls out ("decorative motion...
/// outside of deliberate onboarding/brand moments") and keep their own
/// distinct pacing rather than drawing from this set.
abstract final class AppMotion {
  /// Micro-interactions: icon swaps (clear button, show/hide, status
  /// icons), suggestion-row checkmarks, [MainBottomNavBar]'s press-down/
  /// spring-back feedback (felt before a tab is "officially" selected, so
  /// it reads as immediate rather than as part of the slower switch below).
  static const fast = Duration(milliseconds: 150);

  /// The default for most implicit transitions: step-circle fill/scale,
  /// dropdown entrance, password-strength segments, and every piece of
  /// [MainBottomNavBar]'s tab-switch (indicator slide, icon crossfade+
  /// bounce, label color) — all driven off this one duration so they stay
  /// synchronized rather than each picking its own number.
  static const base = Duration(milliseconds: 250);

  /// Larger movements: step-to-step slide/fade, route push/pop.
  static const slow = Duration(milliseconds: 400);

  /// design.md: "fast start, gentle settle" — the one curve used
  /// everywhere motion needs a curve at all.
  static const curve = Curves.easeOut;
}

/// design.md's Elevation section, as concrete Material elevation values —
/// "visibly present, not flat/borderless, but soft-edged." Material 3's
/// own elevation model already gives dark-theme surfaces the "lighter
/// surface tint AND shadow" combination design.md calls for (via
/// `surfaceTintColor`), so a numeric level plus M3 is enough — no need to
/// hand-roll separate light/dark shadow recipes.
abstract final class AppElevation {
  /// Resting cards and list rows: "subtle... barely-there but visible."
  static const level1 = 1.0;

  /// Raised buttons, active cards, dropdowns/menus: "clearly visible."
  static const level2 = 3.0;

  /// Dialogs, bottom sheets, floating elements: "the most pronounced...
  /// floating above everything else."
  static const level3 = 8.0;
}

/// design.md's exact Color system tokens, as a [ThemeExtension] — every
/// token design.md names by hex (including the semantic colors
/// `ColorScheme` has no native role for: `success`/`warning`/`info`) lives
/// here, read via [AppColorsX.colors]. `ColorScheme` itself (see
/// [AppTheme._themeFrom]) is built from these same values rather than
/// [ColorScheme.fromSeed], so Material widgets that read
/// `Theme.of(context).colorScheme` also land on the exact hexes, not an
/// algorithmically-derived approximation.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.accent,
    required this.accentPressed,
    required this.background,
    required this.surface,
    required this.surfaceElevated,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.success,
    required this.warning,
    required this.danger,
    required this.info,
  });

  final Color accent;
  final Color accentPressed;
  final Color background;
  final Color surface;
  final Color surfaceElevated;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color success;
  final Color warning;
  final Color danger;
  final Color info;

  static const light = AppColors(
    accent: Color(0xFF0891B2),
    accentPressed: Color(0xFF22B8D4),
    background: Color(0xFFF7FAFC),
    surface: Color(0xFFFFFFFF),
    surfaceElevated: Color(0xFFFFFFFF),
    border: Color(0xFFE2E8F0),
    textPrimary: Color(0xFF1A202C),
    textSecondary: Color(0xFF64748B),
    success: Color(0xFF16A34A),
    warning: Color(0xFFF59E0B),
    danger: Color(0xFFEF4444),
    info: Color(0xFF3B82F6),
  );

  static const dark = AppColors(
    accent: Color(0xFF22D3EE),
    accentPressed: Color(0xFF67E8F9),
    background: Color(0xFF0F172A),
    surface: Color(0xFF1E293B),
    surfaceElevated: Color(0xFF28374D),
    border: Color(0xFF334155),
    textPrimary: Color(0xFFF1F5F9),
    textSecondary: Color(0xFF94A3B8),
    success: Color(0xFF22C55E),
    warning: Color(0xFFFBBF24),
    danger: Color(0xFFF87171),
    info: Color(0xFF60A5FA),
  );

  @override
  AppColors copyWith({
    Color? accent,
    Color? accentPressed,
    Color? background,
    Color? surface,
    Color? surfaceElevated,
    Color? border,
    Color? textPrimary,
    Color? textSecondary,
    Color? success,
    Color? warning,
    Color? danger,
    Color? info,
  }) {
    return AppColors(
      accent: accent ?? this.accent,
      accentPressed: accentPressed ?? this.accentPressed,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      border: border ?? this.border,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
      info: info ?? this.info,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      accent: Color.lerp(accent, other.accent, t)!,
      accentPressed: Color.lerp(accentPressed, other.accentPressed, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      border: Color.lerp(border, other.border, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      info: Color.lerp(info, other.info, t)!,
    );
  }
}

/// Shorthand for `Theme.of(context).extension<AppColors>()!` — every custom
/// widget that needs a design.md color token design.md gave `ColorScheme`
/// no slot for (success/warning/info, textSecondary, surfaceElevated,
/// border, accentPressed) should read it through here rather than
/// hardcoding a hex.
extension AppColorsX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}

/// App-wide theme, built from design.md's principles.
abstract final class AppTheme {
  /// design.md's Typography section: Shabnam FD for Persian/Arabic script,
  /// Rubik for Latin script.
  static const persianFontFamily = 'Shabnam FD';
  static const latinFontFamily = 'Rubik';

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

  /// design.md's Components section: "Input field... rounded (medium
  /// radius)" — one shared value so every text field in the app (not just
  /// the ones that remember to set it) gets the same shape.
  static const fieldRadius = 14.0;

  /// design.md's "modern, colorful, Material-inspired... medium border
  /// radii" for larger tap surfaces that aren't fields — home-screen
  /// option cards, dropdown/menu surfaces. One step up from [fieldRadius]
  /// since these are visually bigger surfaces, not a different rule.
  static const cardRadius = 20.0;

  /// design.md's "pill-shaped controls" — the full-width primary button.
  /// Half of [ContinueButton]'s fixed 52dp height, so the shape reads as a
  /// true pill rather than just "rounded."
  static const pillRadius = 26.0;

  static ThemeData light(Locale locale) => _themeFrom(Brightness.light, locale);

  static ThemeData dark(Locale locale) => _themeFrom(Brightness.dark, locale);

  static ThemeData _themeFrom(Brightness brightness, Locale locale) {
    final colors = brightness == Brightness.light
        ? AppColors.light
        : AppColors.dark;

    // Roles design.md's Color system doesn't name (Material's container
    // tiers) are derived from the exact tokens above via a blend, rather
    // than picked by eye — kept traceable to the real tokens even though
    // design.md itself doesn't enumerate them.
    final mutedSurface = Color.lerp(colors.surface, colors.border, 0.6)!;
    final accentContainer = Color.lerp(colors.surface, colors.accent, 0.14)!;

    final scheme = ColorScheme(
      brightness: brightness,
      primary: colors.accent,
      onPrimary: readableTextColorFor(colors.accent),
      primaryContainer: accentContainer,
      onPrimaryContainer: colors.textPrimary,
      secondary: colors.accent,
      onSecondary: readableTextColorFor(colors.accent),
      error: colors.danger,
      onError: readableTextColorFor(colors.danger),
      surface: colors.surface,
      onSurface: colors.textPrimary,
      onSurfaceVariant: colors.textSecondary,
      outline: colors.border,
      outlineVariant: colors.border,
      surfaceContainerLow: colors.surface,
      surfaceContainerHigh: mutedSurface,
      surfaceContainerHighest: mutedSurface,
    );

    final fieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(fieldRadius),
      borderSide: BorderSide(color: colors.border),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: colors.background,
      extensions: [colors],
      fontFamily: fontFamilyFor(locale),
      fontFamilyFallback: fontFamilyFallbackFor(locale),
      // Modern and light: flat surfaces, no heavy shadows (design.md).
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
      ),
      // design.md's Elevation section: resting cards get a soft, visible
      // Level 1 shadow rather than sitting flush with the background.
      cardTheme: CardThemeData(
        elevation: AppElevation.level1,
        color: colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
      ),
      // Dialogs are the most pronounced surface in the elevation scale
      // (Level 3) — "floating above everything else."
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surfaceElevated,
        elevation: AppElevation.level3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
      ),
      textTheme: _textTheme(colors),
      // design.md's Components section: every input field is rounded
      // (medium radius) and uses the surface/border tokens — set once here
      // so individual fields don't need to repeat it.
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surface,
        border: fieldBorder,
        enabledBorder: fieldBorder,
        disabledBorder: fieldBorder,
        focusedBorder: fieldBorder.copyWith(
          borderSide: BorderSide(color: colors.accent, width: 2),
        ),
        errorBorder: fieldBorder.copyWith(
          borderSide: BorderSide(color: colors.danger),
        ),
        focusedErrorBorder: fieldBorder.copyWith(
          borderSide: BorderSide(color: colors.danger, width: 2),
        ),
      ),
    );
  }

  /// design.md's Typography section: "keep it small — a heading size, a
  /// body size, a caption size, one weight for emphasis. Avoid introducing
  /// more than 3–4 sizes total." Every `TextTheme` role the app actually
  /// reads from collapses onto one of exactly four sizes (22/17/14/12);
  /// call sites layer on `FontWeight.w700` for emphasis (the one weight
  /// design.md allows) rather than reaching for a new size. `displaySmall`
  /// is the sole, deliberate exception — [CompletionStep]'s "oversized
  /// congratulatory text" design.md's own utility-app rule carves out.
  ///
  /// Regular weight is left implicit (Flutter's default, 400) rather than
  /// stated everywhere; only 400 and 700 are ever requested, both of which
  /// Shabnam FD ships as real static weights (unlike, say, 600 — Shabnam
  /// has no 600 file, so requesting it would silently fall back to
  /// whichever weight the engine snaps to, differently per script).
  static TextTheme _textTheme(AppColors colors) {
    const headingSize = 22.0;
    const subheadingSize = 17.0;
    const bodySize = 14.0;
    const captionSize = 12.0;
    const celebrationSize = 40.0;

    return const TextTheme(
      displaySmall: TextStyle(
        fontSize: celebrationSize,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: TextStyle(fontSize: headingSize),
      titleLarge: TextStyle(
        fontSize: subheadingSize,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(fontSize: bodySize, fontWeight: FontWeight.w700),
      bodyMedium: TextStyle(fontSize: bodySize),
      bodySmall: TextStyle(fontSize: bodySize),
      labelLarge: TextStyle(fontSize: captionSize),
      labelMedium: TextStyle(fontSize: captionSize),
      labelSmall: TextStyle(fontSize: captionSize),
    ).apply(bodyColor: colors.textPrimary, displayColor: colors.textPrimary);
  }
}
