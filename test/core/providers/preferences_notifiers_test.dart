import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_transport/core/providers/app_locale_provider.dart';
import 'package:open_transport/core/providers/current_country_provider.dart';
import 'package:open_transport/data/catalog/available_countries.dart';

import '../../test_utils/fake_preferences_repository.dart';

void main() {
  group('appLocaleProvider', () {
    test('starts null (device locale) when nothing was ever saved', () {
      final container = ProviderContainer(
        overrides: [fakePreferencesOverride()],
      );
      addTearDown(container.dispose);

      expect(container.read(appLocaleProvider), isNull);
    });

    test('restores a previously-saved language on startup', () {
      final container = ProviderContainer(
        overrides: [fakePreferencesOverride(languageCode: 'fa')],
      );
      addTearDown(container.dispose);

      expect(container.read(appLocaleProvider), const Locale('fa'));
    });

    test('select() updates state and persists in one call', () {
      final repository = FakePreferencesRepository();
      final container = ProviderContainer(
        overrides: [fakePreferencesOverrideFor(repository)],
      );
      addTearDown(container.dispose);

      container.read(appLocaleProvider.notifier).select(const Locale('fa'));

      expect(container.read(appLocaleProvider), const Locale('fa'));
      expect(repository.languageCode, 'fa');
    });
  });

  group('currentCountryProvider', () {
    test('falls back to the first available country when nothing was '
        'saved, or the saved slug no longer exists', () {
      final container = ProviderContainer(
        overrides: [fakePreferencesOverride(countrySlug: 'no-such-country')],
      );
      addTearDown(container.dispose);

      expect(container.read(currentCountryProvider), availableCountries.first);
    });

    test('select() updates state and persists in one call', () {
      final repository = FakePreferencesRepository();
      final container = ProviderContainer(
        overrides: [fakePreferencesOverrideFor(repository)],
      );
      addTearDown(container.dispose);

      final country = availableCountries.first;
      container.read(currentCountryProvider.notifier).select(country);

      expect(container.read(currentCountryProvider), country);
      expect(repository.countrySlug, country.slug);
    });
  });
}
