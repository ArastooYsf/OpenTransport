import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_transport/core/providers/app_locale_provider.dart';
import 'package:open_transport/core/providers/current_country_provider.dart';
import 'package:open_transport/core/theme/app_theme.dart';
import 'package:open_transport/core/widgets/autocomplete_field.dart';
import 'package:open_transport/data/catalog/available_country.dart';
import 'package:open_transport/features/home/widgets/home_top_bar.dart';
import 'package:open_transport/l10n/generated/app_localizations.dart';

import '../../../test_utils/fake_preferences_repository.dart';

Widget _appUnderTest(ProviderContainer container) {
  return UncontrolledProviderScope(
    container: container,
    child: MaterialApp(
      theme: AppTheme.light(const Locale('en')),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Scaffold(
        body: Padding(padding: EdgeInsets.all(20), child: HomeTopBar()),
      ),
    ),
  );
}

void main() {
  testWidgets('tapping the country switcher opens a sheet with the reused '
      'AutocompleteField<AvailableCountry>, pre-filled with the current '
      "country — the exact same widget type onboarding's step 1 uses", (
    tester,
  ) async {
    final container = ProviderContainer(overrides: [fakePreferencesOverride()]);
    addTearDown(container.dispose);

    await tester.pumpWidget(_appUnderTest(container));

    await tester.tap(find.text('Iran'));
    await tester.pumpAndSettle();

    expect(find.byType(AutocompleteField<AvailableCountry>), findsOneWidget);
    expect(find.text('Country'), findsOneWidget); // the field's own label
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller?.text,
      'Iran',
    );
  });

  testWidgets('tapping the language switcher opens a sheet with the reused '
      'AutocompleteField<String>, and picking the already-current option '
      'still round-trips through select() and closes the sheet', (
    tester,
  ) async {
    final container = ProviderContainer(overrides: [fakePreferencesOverride()]);
    addTearDown(container.dispose);

    await tester.pumpWidget(_appUnderTest(container));
    expect(container.read(appLocaleProvider), isNull);

    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    expect(find.byType(AutocompleteField<String>), findsOneWidget);
    expect(find.text('Language'), findsOneWidget);

    // Focusing shows the options overlay filtered to the field's own
    // pre-filled text ("English (English)"), which trivially matches
    // itself — tapping that result exercises the real onSelected ->
    // provider -> Navigator.pop wiring without needing to search.
    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(
        of: find.byType(ListView),
        matching: find.text('English (English)'),
      ),
    );
    await tester.pumpAndSettle();

    expect(container.read(appLocaleProvider), const Locale('en'));
    expect(find.text('Language'), findsNothing); // sheet closed
  });

  testWidgets('selecting a country persists it via currentCountryProvider', (
    tester,
  ) async {
    final container = ProviderContainer(overrides: [fakePreferencesOverride()]);
    addTearDown(container.dispose);

    await tester.pumpWidget(_appUnderTest(container));

    await tester.tap(find.text('Iran'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle();
    await tester.tap(
      // The only option, matches itself — scoped to the options list so
      // it doesn't collide with the switcher chip's own "Iran" label
      // still mounted (just covered) behind the sheet.
      find.descendant(of: find.byType(ListView), matching: find.text('Iran')),
    );
    await tester.pumpAndSettle();

    expect(container.read(currentCountryProvider).slug, 'iran');
    expect(find.text('Country'), findsNothing); // sheet closed
  });
}
