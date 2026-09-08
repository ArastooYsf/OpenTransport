import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_transport/data/providers/preferences_providers.dart';
import 'package:open_transport/data/repositories/preferences_repository.dart';

/// An in-memory [PreferencesRepository] for widget tests — no real Hive box,
/// so tests don't need file-system access or async setup just to render a
/// screen that reads [appLocaleProvider]/[currentCountryProvider].
class FakePreferencesRepository implements PreferencesRepository {
  FakePreferencesRepository({this.countrySlug, this.languageCode});

  @override
  String? countrySlug;

  @override
  String? languageCode;

  @override
  Future<void> saveCountrySlug(String slug) async => countrySlug = slug;

  @override
  Future<void> saveLanguageCode(String code) async => languageCode = code;
}

/// The one override every test that renders onboarding, Home, or the shell
/// needs — pass to `ProviderContainer(overrides: [...])` or
/// `ProviderScope(overrides: [...])`.
Override fakePreferencesOverride({String? countrySlug, String? languageCode}) {
  return fakePreferencesOverrideFor(
    FakePreferencesRepository(
      countrySlug: countrySlug,
      languageCode: languageCode,
    ),
  );
}

/// Like [fakePreferencesOverride], but for a test that wants to keep its
/// own reference to the [repository] afterward — to assert on what got
/// persisted, not just on the resulting provider state.
Override fakePreferencesOverrideFor(FakePreferencesRepository repository) {
  return preferencesRepositoryProvider.overrideWithValue(repository);
}
