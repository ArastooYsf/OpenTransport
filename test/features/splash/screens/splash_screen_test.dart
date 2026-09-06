import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_transport/features/onboarding/screens/onboarding_flow_screen.dart';
import 'package:open_transport/features/splash/screens/splash_screen.dart';
import 'package:open_transport/features/splash/widgets/pulsing_logo.dart';
import 'package:open_transport/features/splash/widgets/splash_loading_bar.dart';
import 'package:open_transport/l10n/generated/app_localizations.dart';

Widget _appUnderTest() {
  return ProviderScope(
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SplashScreen(),
    ),
  );
}

void main() {
  setUp(() {
    // See station_list_screen_test.dart: without this, a later test's real
    // asset load (the logo SVG, here) can be handed a Future tied to an
    // already-torn-down test zone and never resolve.
    rootBundle.clear();
  });

  testWidgets('shows the logo and an indeterminate loading bar', (
    tester,
  ) async {
    await tester.pumpWidget(_appUnderTest());

    expect(find.byType(PulsingLogo), findsOneWidget);
    expect(find.byType(SplashLoadingBar), findsOneWidget);

    // Let the pending _initializeApp() Timer fire and the resulting
    // navigation finish, so nothing is left pending when the test ends.
    await tester.pump(const Duration(milliseconds: 1800));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
  });

  testWidgets('hands off to onboarding once "initialization" finishes', (
    tester,
  ) async {
    await tester.pumpWidget(_appUnderTest());

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(OnboardingFlowScreen), findsNothing);

    // Future.delayed uses a real Timer, which the test binding's fake
    // clock advances synchronously — no real wall-clock wait needed.
    await tester.pump(const Duration(milliseconds: 1800));
    // One frame for the delayed callback's Navigator.pushReplacement to
    // run, then enough time for the 380ms fade/scale transition to finish.
    // (Not pumpAndSettle: PulsingLogo's pulse repeats forever until its
    // page is disposed, which would make pumpAndSettle spin until timeout.)
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.byType(OnboardingFlowScreen), findsOneWidget);
    expect(find.byType(SplashScreen), findsNothing);
  });
}
