import 'package:hive/hive.dart';

/// Locally-persisted, immediately-applied user preferences — currently just
/// the selected country and language (see Home's country/language
/// switchers and onboarding's country/language step). Abstract so
/// production code can be backed by a real [Box] while tests substitute an
/// in-memory fake, without either depending on the other.
abstract class PreferencesRepository {
  String? get countrySlug;
  String? get languageCode;

  Future<void> saveCountrySlug(String slug);
  Future<void> saveLanguageCode(String code);
}

/// The real, Hive-backed implementation — see `main.dart` for where the
/// box is opened (before `runApp`, so every provider that reads this can
/// do so synchronously) and how this gets wired in via
/// `preferencesRepositoryProvider.overrideWithValue(...)`.
class HivePreferencesRepository implements PreferencesRepository {
  const HivePreferencesRepository(this._box);

  final Box<String> _box;

  static const countrySlugKey = 'countrySlug';
  static const languageCodeKey = 'languageCode';

  @override
  String? get countrySlug => _box.get(countrySlugKey);

  @override
  String? get languageCode => _box.get(languageCodeKey);

  @override
  Future<void> saveCountrySlug(String slug) => _box.put(countrySlugKey, slug);

  @override
  Future<void> saveLanguageCode(String code) => _box.put(languageCodeKey, code);
}
