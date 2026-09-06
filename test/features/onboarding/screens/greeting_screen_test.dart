import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_transport/features/onboarding/screens/greeting_screen.dart';
import 'package:open_transport/features/onboarding/screens/onboarding_flow_screen.dart';
import 'package:open_transport/l10n/generated/app_localizations.dart';

Widget _appUnderTest() {
  return const ProviderScope(
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: GreetingScreen(),
    ),
  );
}

void main() {
  testWidgets('shows the Persian greeting first, then cross-fades to the '
      'next word', (tester) async {
    await tester.pumpWidget(_appUnderTest());

    expect(find.text('سلام'), findsOneWidget);
    expect(find.text('Hello'), findsNothing);

    // Word interval (1100ms) elapses, then the cross-fade (400ms) finishes —
    // pumping strictly more than the nominal 400ms, since AnimatedSwitcher's
    // ticker needs a small buffer past its exact duration to report
    // "completed" in fake time. Not pumpAndSettle: the word-cycling
    // Timer.periodic never stops on its own, so pumpAndSettle would spin
    // until timeout (same as PulsingLogo).
    await tester.pump(const Duration(milliseconds: 1100));
    await tester.pump(const Duration(milliseconds: 450));

    expect(find.text('Hello'), findsOneWidget);
    expect(find.text('سلام'), findsNothing);
  });

  testWidgets('tapping Continue hands off to onboarding', (tester) async {
    await tester.pumpWidget(_appUnderTest());

    expect(find.byType(OnboardingFlowScreen), findsNothing);

    await tester.tap(find.text('Continue'));
    await tester.pump(); // register the tap before advancing fake time
    // Strictly more than the nominal 700ms — see the note in
    // onboarding_flow_screen_test.dart's _tapContinue.
    await tester.pump(const Duration(milliseconds: 750)); // glow sweep
    await tester.pump(const Duration(milliseconds: 200)); // post-sweep hold
    await tester.pump(const Duration(milliseconds: 400)); // page transition

    expect(find.byType(OnboardingFlowScreen), findsOneWidget);
    expect(find.byType(GreetingScreen), findsNothing);
  });
}
