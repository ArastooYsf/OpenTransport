import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_transport/core/theme/app_theme.dart';
import 'package:open_transport/features/home/screens/home_screen.dart';
import 'package:open_transport/l10n/generated/app_localizations.dart';
import 'package:phosphor_icons/phosphor_icons.dart';

import '../../../test_utils/fake_preferences_repository.dart';
import '../../../test_utils/pump_until_found.dart';

Widget _appUnderTest(Locale locale) {
  return ProviderScope(
    overrides: [fakePreferencesOverride()],
    child: MaterialApp(
      theme: AppTheme.light(locale),
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomeScreen(),
    ),
  );
}

void main() {
  setUp(() {
    // See station_list_screen_test.dart's identical setUp: without this,
    // rootBundle's internal string cache can hand a later test a Future
    // tied to an already-torn-down test zone, which then never resolves.
    rootBundle.clear();
  });

  testWidgets('renders Smart (always) and Metro (from Tehran\'s data) in '
      'English (LTR) — Tehran has no BRT/bus/tram data, so those tiles '
      "don't appear", (tester) async {
    await tester.pumpWidget(_appUnderTest(const Locale('en')));
    await pumpUntilFound(tester, find.text('Metro'));

    expect(find.text('Smart'), findsOneWidget);
    expect(
      find.text('The easiest way to any destination or station'),
      findsOneWidget,
    );
    expect(find.text('Metro'), findsOneWidget);
    expect(find.text('Lines & stations'), findsOneWidget);
    expect(find.text('BRT'), findsNothing);
    expect(find.text('Bus'), findsNothing);
    expect(find.text('Tram'), findsNothing);

    final directionality = tester.widget<Directionality>(
      find.byType(Directionality).first,
    );
    expect(directionality.textDirection, TextDirection.ltr);
  });

  testWidgets('renders Smart and Metro in Persian (RTL)', (tester) async {
    await tester.pumpWidget(_appUnderTest(const Locale('fa')));
    await pumpUntilFound(tester, find.text('مترو'));

    expect(find.text('همگانی'), findsOneWidget);
    expect(find.text('مترو'), findsOneWidget);
    expect(find.text('BRT'), findsNothing);

    final directionality = tester.widget<Directionality>(
      find.byType(Directionality).first,
    );
    expect(directionality.textDirection, TextDirection.rtl);
  });

  testWidgets('tapping Metro opens a placeholder screen', (tester) async {
    await tester.pumpWidget(_appUnderTest(const Locale('en')));
    await pumpUntilFound(tester, find.text('Metro'));

    await tester.tap(find.text('Metro'));
    await tester.pumpAndSettle();

    expect(find.text('This section is coming soon.'), findsOneWidget);
  });

  testWidgets('tapping Smart still navigates', (tester) async {
    await tester.pumpWidget(_appUnderTest(const Locale('en')));
    await pumpUntilFound(tester, find.text('Smart'));

    await tester.tap(find.text('Smart'));
    await tester.pumpAndSettle();

    expect(find.text('This section is coming soon.'), findsOneWidget);
  });

  testWidgets('shows a country switcher and a language switcher in the top '
      'bar', (tester) async {
    await tester.pumpWidget(_appUnderTest(const Locale('en')));
    await pumpUntilFound(tester, find.text('Metro'));

    expect(find.text('Iran'), findsOneWidget); // country switcher label
    expect(find.text('English'), findsOneWidget); // language switcher label
  });

  // design.md requires every screen to work at a small phone width and in
  // both LTR/RTL without clipping or overflow.
  for (final locale in const [Locale('en'), Locale('fa')]) {
    testWidgets('no overflow at a small phone width (${locale.languageCode})', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(320, 568));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_appUnderTest(locale));
      await pumpUntilFound(tester, find.byIcon(PhosphorIconsRegular.train));
      await tester.pump(const Duration(milliseconds: 400));

      expect(tester.takeException(), isNull);
    });
  }
}
