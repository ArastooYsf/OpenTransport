import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/providers/app_locale_provider.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/screens/splash_screen.dart';
import 'l10n/generated/app_localizations.dart';

void main() {
  runApp(const ProviderScope(child: OpenTransportApp()));
}

class OpenTransportApp extends ConsumerWidget {
  const OpenTransportApp({super.key});

  /// The locale that decides which font family to use (see
  /// [AppTheme.fontFamilyFor]), before [MaterialApp] itself has resolved a
  /// locale for [Localizations]. Mirrors [localeListResolutionCallback]'s
  /// device-locale fallback below, restricted to the two locales the app
  /// actually supports.
  static Locale _fontLocale(Locale? override) {
    if (override != null) return override;
    final deviceCode = PlatformDispatcher.instance.locale.languageCode;
    return deviceCode == 'fa' ? const Locale('fa') : const Locale('en');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Null until onboarding's language step sets an explicit choice — see
    // core/providers/app_locale_provider.dart. Passing a non-null `locale`
    // to MaterialApp forces it, overriding device-locale resolution below.
    final localeOverride = ref.watch(appLocaleProvider);
    final fontLocale = _fontLocale(localeOverride);

    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: AppTheme.light(fontLocale),
      darkTheme: AppTheme.dark(fontLocale),
      themeMode: ThemeMode.system,
      locale: localeOverride,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeListResolutionCallback: (locales, supported) {
        for (final locale in locales ?? const <Locale>[]) {
          if (supported
              .map((l) => l.languageCode)
              .contains(locale.languageCode)) {
            return locale;
          }
        }
        return const Locale('en');
      },
      home: const SplashScreen(),
    );
  }
}
