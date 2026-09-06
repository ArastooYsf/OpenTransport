import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_transport/core/theme/app_theme.dart';
import 'package:open_transport/features/onboarding/providers/onboarding_providers.dart';
import 'package:open_transport/features/onboarding/screens/greeting_screen.dart';
import 'package:open_transport/features/onboarding/screens/onboarding_flow_screen.dart';
import 'package:open_transport/l10n/generated/app_localizations.dart';

/// Every screen in the onboarding flow, checked for overflow/clipping at a
/// small phone width (iPhone SE-class) and a larger one, in both English
/// (LTR) and Persian (RTL) — design.md requires every screen to work
/// mirrored and unmirrored without layout bugs.
void main() {
  const sizes = {
    'small (320x568)': Size(320, 568),
    'large (414x896)': Size(414, 896),
  };
  const locales = {'en (LTR)': Locale('en'), 'fa (RTL)': Locale('fa')};

  Widget appFor(Locale locale, ProviderContainer container) {
    return UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: AppTheme.light(locale),
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const OnboardingFlowScreen(),
      ),
    );
  }

  for (final sizeEntry in sizes.entries) {
    for (final localeEntry in locales.entries) {
      testWidgets(
        'onboarding flow at ${sizeEntry.key}, ${localeEntry.key}: no overflow '
        'on any step',
        (tester) async {
          await tester.binding.setSurfaceSize(sizeEntry.value);
          addTearDown(() => tester.binding.setSurfaceSize(null));

          final container = ProviderContainer();
          addTearDown(container.dispose);

          await tester.pumpWidget(appFor(localeEntry.value, container));
          await tester.pump(const Duration(milliseconds: 400));
          expect(tester.takeException(), isNull, reason: 'step 1 (country)');

          final notifier = container.read(onboardingProvider.notifier);
          notifier.selectCountry('iran');
          notifier.next(); // -> profile
          await tester.pump(const Duration(milliseconds: 400));
          expect(tester.takeException(), isNull, reason: 'step 2 (profile)');

          notifier.updateProfile(username: 'arastoo1', firstName: 'Arastoo');
          await tester.pump(const Duration(milliseconds: 400));
          expect(
            tester.takeException(),
            isNull,
            reason: 'step 2 with an error/status icon showing',
          );

          notifier.next(); // -> email/password
          await tester.pump(const Duration(milliseconds: 400));
          expect(
            tester.takeException(),
            isNull,
            reason: 'step 3 (email/password)',
          );

          notifier.updateEmail('arastoo@example.com');
          notifier.updatePassword('Abcdefg1!');
          await tester.pump(const Duration(milliseconds: 400));
          expect(
            tester.takeException(),
            isNull,
            reason: 'step 3 with the strength meter showing',
          );

          notifier.next(); // -> completion
          await tester.pump(const Duration(milliseconds: 400));
          expect(tester.takeException(), isNull, reason: 'completion screen');
        },
      );

      testWidgets(
        'greeting screen at ${sizeEntry.key}, ${localeEntry.key}: no overflow',
        (tester) async {
          await tester.binding.setSurfaceSize(sizeEntry.value);
          addTearDown(() => tester.binding.setSurfaceSize(null));

          await tester.pumpWidget(
            MaterialApp(
              theme: AppTheme.light(localeEntry.value),
              locale: localeEntry.value,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: const GreetingScreen(),
            ),
          );
          await tester.pump(const Duration(milliseconds: 900));
          expect(tester.takeException(), isNull);
        },
      );
    }
  }
}
