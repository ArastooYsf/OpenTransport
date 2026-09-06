import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_transport/core/theme/app_theme.dart';
import 'package:open_transport/features/onboarding/screens/greeting_screen.dart';
import 'package:open_transport/features/onboarding/screens/onboarding_flow_screen.dart';
import 'package:open_transport/l10n/generated/app_localizations.dart';

Widget _appUnderTest() {
  return ProviderScope(
    child: MaterialApp(
      theme: AppTheme.light(const Locale('en')),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const GreetingScreen(),
    ),
  );
}

/// Advances through exactly one word's fade-in (500ms) → hold (1200ms) →
/// fade-out (400ms) cycle, with a small buffer past each AnimationController
/// phase's nominal duration — the same "needs strictly more than nominal
/// duration to report complete in fake time" quirk documented elsewhere in
/// this suite (e.g. onboarding_flow_screen_test.dart's _tapContinue).
Future<void> _pumpOneWordCycle(WidgetTester tester) async {
  await tester.pump(const Duration(milliseconds: 550)); // fade in
  await tester.pump(const Duration(milliseconds: 1200)); // hold
  await tester.pump(const Duration(milliseconds: 450)); // fade out
  await tester.pump(); // let the next word's setState land
}

bool _continueEnabled(WidgetTester tester) {
  return tester.widget<FilledButton>(find.byType(FilledButton)).onPressed !=
      null;
}

void main() {
  testWidgets('plays the Persian greeting first, then the next word once '
      "its cycle finishes — never both at once", (tester) async {
    await tester.pumpWidget(_appUnderTest());

    expect(find.text('سلام'), findsOneWidget);
    expect(find.text('Hello'), findsNothing);

    await _pumpOneWordCycle(tester);

    expect(find.text('سلام'), findsNothing);
    expect(find.text('Hello'), findsOneWidget);
  });

  testWidgets(
    'Continue starts disabled and only enables once the whole word + wave '
    'sequence finishes, then hands off to onboarding',
    (tester) async {
      await tester.pumpWidget(_appUnderTest());

      expect(_continueEnabled(tester), isFalse);

      // Five words' worth of cycles...
      for (var i = 0; i < 5; i++) {
        await _pumpOneWordCycle(tester);
      }
      // ...then the one-shot hand-wave (1600ms).
      await tester.pump(const Duration(milliseconds: 1650));

      expect(_continueEnabled(tester), isTrue);

      await tester.tap(find.text('Continue'));
      await tester.pump(); // register the tap before advancing fake time
      await tester.pump(const Duration(milliseconds: 750)); // glow sweep
      await tester.pump(const Duration(milliseconds: 200)); // post-sweep hold
      await tester.pump(const Duration(milliseconds: 400)); // page transition

      expect(find.byType(OnboardingFlowScreen), findsOneWidget);
      expect(find.byType(GreetingScreen), findsNothing);
    },
  );
}
