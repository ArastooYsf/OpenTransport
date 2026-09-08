import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_transport/features/station_list/screens/station_list_screen.dart';
import 'package:open_transport/l10n/generated/app_localizations.dart';

import '../../test_utils/fake_preferences_repository.dart';
import '../../test_utils/pump_until_found.dart';

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
    await pumpUntilFound(tester, find.text('Tajrish'));

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
    await pumpUntilFound(tester, find.text('تجریش'));

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
