import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../catalog/available_countries.dart';
import '../catalog/available_country.dart';

/// Countries the onboarding country picker can offer.
final availableCountriesProvider = Provider<List<AvailableCountry>>((ref) {
  return availableCountries;
});
