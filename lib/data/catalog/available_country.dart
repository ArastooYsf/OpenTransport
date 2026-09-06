import 'package:freezed_annotation/freezed_annotation.dart';

part 'available_country.freezed.dart';

/// A country the onboarding country picker can offer — i.e. one we
/// actually bundle at least one city dataset for under `data/<slug>/`.
///
/// This is presentation metadata for the picker (display name, official
/// language), not transit data — it deliberately does not go through
/// schema.json, which has no notion of a country's display name or
/// official language.
@freezed
class AvailableCountry with _$AvailableCountry {
  const factory AvailableCountry({
    /// The `data/<slug>/` folder name, e.g. `'iran'`.
    required String slug,

    /// ISO 3166-1 alpha-2 code, e.g. `'IR'` — matches each city file's
    /// `meta.country`.
    required String isoCode,

    /// Locale code → display name, e.g. `{ 'fa': 'ایران', 'en': 'Iran' }`.
    required Map<String, String> name,

    /// The country's official language, as an app locale code (e.g.
    /// `'fa'`). Used to pre-select a language in onboarding — falls back
    /// to English if the app doesn't support this language yet.
    required String officialLanguageCode,
  }) = _AvailableCountry;
}
