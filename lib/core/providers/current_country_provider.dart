import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/catalog/available_countries.dart';
import '../../data/catalog/available_country.dart';
import '../../data/providers/preferences_providers.dart';
import '../../data/repositories/preferences_repository.dart';

/// The country Home and its transit-data providers currently show —
/// set once during onboarding's country step and from then on changeable
/// via Home's country switcher (see `MainShellScreen`'s Home tab).
///
/// Initialized from [PreferencesRepository.countrySlug] (persisted from a
/// previous launch), falling back to the first entry in [availableCountries]
/// if nothing's been saved yet or the saved slug no longer exists. Use
/// [select] rather than assigning `.state` directly so a change is never
/// applied without also being saved.
class CurrentCountryNotifier extends StateNotifier<AvailableCountry> {
  CurrentCountryNotifier(this._repository) : super(_initial(_repository));

  final PreferencesRepository _repository;

  static AvailableCountry _initial(PreferencesRepository repository) {
    final slug = repository.countrySlug;
    return availableCountries.firstWhere(
      (country) => country.slug == slug,
      orElse: () => availableCountries.first,
    );
  }

  void select(AvailableCountry country) {
    state = country;
    _repository.saveCountrySlug(country.slug);
  }
}

final currentCountryProvider =
    StateNotifierProvider<CurrentCountryNotifier, AvailableCountry>((ref) {
      return CurrentCountryNotifier(ref.watch(preferencesRepositoryProvider));
    });
