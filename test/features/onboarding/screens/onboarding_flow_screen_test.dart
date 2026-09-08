import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_transport/core/theme/app_theme.dart';
import 'package:phosphor_icons/phosphor_icons.dart';
import 'package:open_transport/features/onboarding/providers/onboarding_providers.dart';
import 'package:open_transport/features/onboarding/screens/onboarding_flow_screen.dart';
import 'package:open_transport/l10n/generated/app_localizations.dart';

import '../../../test_utils/fake_preferences_repository.dart';

Widget _appUnderTest(ProviderContainer container) {
  return UncontrolledProviderScope(
    container: container,
    child: MaterialApp(
      theme: AppTheme.light(const Locale('en')),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const OnboardingFlowScreen(),
    ),
  );
}

/// Taps the full-width Continue button and lets its two-phase confirmation
/// — the growing ring (480ms) then the circular accent-fill reveal (320ms)
/// — finish before the step actually advances.
Future<void> _tapContinue(WidgetTester tester) async {
  await tester.tap(find.text('Continue'));
  await tester.pump(); // register the tap before advancing fake time
  // Strictly more than each nominal duration: an AnimationController's
  // forward() future needs a small buffer past its exact duration to
  // report complete in fake time (same quirk as AnimatedSwitcher — see
  // greeting_screen_test).
  await tester.pump(const Duration(milliseconds: 550)); // growing ring
  await tester.pump(const Duration(milliseconds: 370)); // circular fill
  await tester.pump(const Duration(milliseconds: 400)); // step transition
}

void main() {
  testWidgets('happy path through all 3 steps to completion', (tester) async {
    final container = ProviderContainer(overrides: [fakePreferencesOverride()]);
    addTearDown(container.dispose);

    await tester.pumpWidget(_appUnderTest(container));

    // --- Step 1: country + language ---
    expect(find.text('Country & language'), findsOneWidget);

    final countryField = find.byType(TextField).first;
    await tester.enterText(countryField, 'Iran');
    await tester.pumpAndSettle();
    // find.text also matches the field's own EditableText content, so
    // scope the tap to the dropdown option inside the results ListView.
    await tester.tap(
      find.descendant(of: find.byType(ListView), matching: find.text('Iran')),
    );
    await tester.pumpAndSettle();

    expect(container.read(onboardingProvider).countrySlug, 'iran');
    expect(container.read(onboardingProvider).languageCode, 'fa');

    final languageField = tester.widget<TextField>(
      find.byType(TextField).at(1),
    );
    expect(languageField.controller?.text, 'Persian (فارسی)');

    await _tapContinue(tester);

    // --- Step 2: username, first name, last name ---
    expect(find.text('Tell us about yourself'), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, 'arastoo1');
    // Debounce (500ms) + simulated network latency (500ms).
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 600));

    expect(container.read(onboardingProvider).username, 'arastoo1');
    expect(find.byIcon(PhosphorIconsFill.checkCircle), findsOneWidget);

    await _tapContinue(tester);

    // --- Step 3: email, then password ---
    expect(find.text('Email & password'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'arastoo@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'Abcdefg1!');
    await tester.pump();

    expect(find.text('Strong'), findsOneWidget);

    await _tapContinue(tester);

    // --- Completion ---
    expect(find.text('Welcome'), findsOneWidget);
    expect(find.text('arastoo1'), findsOneWidget); // the username line
    expect(find.text('Skip all'), findsNothing); // no skip on this screen

    // Tapping Continue here (through its own glow-sweep) hands off to Home
    // — the tutorial dialog does *not* appear on this screen anymore.
    await _tapContinue(tester);
    expect(find.text('Want to see a quick tour of the app?'), findsNothing);

    // Home registers first; only ~700ms later does the tutorial dialog
    // fade/scale in on top of it. Dismiss it so nothing is left pending.
    await tester.pump(const Duration(milliseconds: 750));
    expect(find.text('Want to see a quick tour of the app?'), findsOneWidget);
    await tester.tap(find.text('Not now'));
    await tester.pumpAndSettle();
  });

  testWidgets('skip all -> confirm shows the post-skip notice on Home', (
    tester,
  ) async {
    final container = ProviderContainer(overrides: [fakePreferencesOverride()]);
    addTearDown(container.dispose);

    await tester.pumpWidget(_appUnderTest(container));

    await tester.tap(find.text('Skip all'));
    await tester.pumpAndSettle();

    expect(find.text('Confirm'), findsOneWidget);
    await tester.tap(find.text('Confirm'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();

    expect(find.text('Without an account'), findsOneWidget);
    expect(find.text('Save your favorite routes'), findsOneWidget);

    await tester.tap(find.text('Got it'));
    await tester.pumpAndSettle();

    expect(find.text('Without an account'), findsNothing);
  });
}
