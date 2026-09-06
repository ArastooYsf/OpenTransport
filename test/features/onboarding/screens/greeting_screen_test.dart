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

bool _continueEnabled(WidgetTester tester) {
  return tester.widget<FilledButton>(find.byType(FilledButton)).onPressed !=
      null;
}

void main() {
  testWidgets('Continue is enabled immediately — the greeting never gates it', (
    tester,
  ) async {
    await tester.pumpWidget(_appUnderTest());
    expect(_continueEnabled(tester), isTrue);

    // Still enabled well into the (infinitely repeating) word cycle.
    await tester.pump(const Duration(milliseconds: 1600));
    expect(_continueEnabled(tester), isTrue);
  });

  testWidgets('crossfades from one word to the next, forever, with no gap '
      "of empty background between them", (tester) async {
    await tester.pumpWidget(_appUnderTest());

    expect(find.text('سلام'), findsOneWidget);
    expect(find.text('Hello'), findsNothing);

    // Word interval (800ms) elapses, then the crossfade (180ms) finishes —
    // pumping strictly more than the nominal 180ms, since AnimatedSwitcher's
    // ticker needs a small buffer past its exact duration to report
    // "completed" in fake time (same quirk noted elsewhere in this suite).
    // Not pumpAndSettle: both the word-cycling Timer.periodic and the
    // wave AnimationController repeat forever.
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pump(const Duration(milliseconds: 230));

    expect(find.text('Hello'), findsOneWidget);
    expect(find.text('سلام'), findsNothing);
  });

  testWidgets('tapping Continue hands off to onboarding', (tester) async {
    await tester.pumpWidget(_appUnderTest());

    expect(find.byType(OnboardingFlowScreen), findsNothing);

    await tester.tap(find.text('Continue'));
    await tester.pump(); // register the tap before advancing fake time
    await tester.pump(const Duration(milliseconds: 700)); // growing ring
    await tester.pump(const Duration(milliseconds: 450)); // circular fill
    await tester.pump(const Duration(milliseconds: 400)); // page transition

    expect(find.byType(OnboardingFlowScreen), findsOneWidget);
    expect(find.byType(GreetingScreen), findsNothing);
  });
}
