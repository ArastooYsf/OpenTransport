import 'available_country.dart';

/// The catalog backing the onboarding country picker.
///
/// This is a hand-maintained list, not derived from `data/` at runtime —
/// add an entry here in the same PR that adds a new `data/<slug>/` folder
/// (see CONTRIBUTING.md). Keeping it a plain list keeps it trivial to
/// review, at the cost of needing this one extra edit per new country.
const availableCountries = <AvailableCountry>[
  AvailableCountry(
    slug: 'iran',
    defaultCitySlug: 'tehran',
    isoCode: 'IR',
    name: {'fa': 'ایران', 'en': 'Iran'},
    officialLanguageCode: 'fa',
  ),
];
