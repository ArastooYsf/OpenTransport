import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_transport/features/station_list/screens/station_list_screen.dart';
import 'package:open_transport/l10n/generated/app_localizations.dart';

import '../../test_utils/fake_preferences_repository.dart';

Widget _appUnderTest(Locale locale) {
  return ProviderScope(
    overrides: [fakePreferencesOverride()],
    child: MaterialApp(
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const StationListScreen(),
    ),
  );
}

/// Pumps until [finder] finds something or [timeout] elapses. The city data
/// loads via a real (non-fake-clock) asset read, so a single fixed-duration
/// pump can race it under load — poll instead of guessing a delay.
Future<void> _pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 10),
}) async {
  final end = DateTime.now().add(timeout);
  while (finder.evaluate().isEmpty && DateTime.now().isBefore(end)) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  setUp(() {
    // Each test pumps its own city-data load; without this, rootBundle's
    // internal string cache can hand a later test a Future tied to an
    // already-torn-down test zone, which then never resolves.
    rootBundle.clear();
  });

  testWidgets('renders stations with line badges in English (LTR)', (
    tester,
  ) async {
    await tester.pumpWidget(_appUnderTest(const Locale('en')));
    await _pumpUntilFound(tester, find.text('Tajrish'));

    expect(find.text('Stations'), findsOneWidget);
    expect(find.text('Tajrish'), findsOneWidget);
    expect(find.text('Imam Khomeini'), findsOneWidget);
    expect(find.text('Rah Ahan'), findsOneWidget);
    expect(find.text('1'), findsNWidgets(3));

    final directionality = tester.widget<Directionality>(
      find.byType(Directionality).first,
    );
    expect(directionality.textDirection, TextDirection.ltr);
  });

  testWidgets('renders stations with line badges in Persian (RTL)', (
    tester,
  ) async {
    await tester.pumpWidget(_appUnderTest(const Locale('fa')));
    await _pumpUntilFound(tester, find.text('تجریش'));

    expect(find.text('ایستگاه‌ها'), findsOneWidget);
    expect(find.text('تجریش'), findsOneWidget);
    expect(find.text('امام خمینی'), findsOneWidget);
    expect(find.text('راه‌آهن'), findsOneWidget);

    final directionality = tester.widget<Directionality>(
      find.byType(Directionality).first,
    );
    expect(directionality.textDirection, TextDirection.rtl);
  });
}
