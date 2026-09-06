import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/transit_city_data.dart';
import '../../../data/models/transit_line.dart';
import '../../../data/providers/transit_data_providers.dart';

/// The city currently shown. Hardcoded to Tehran for this first screen —
/// city selection is out of scope until the map/routing work lands.
final cityDataProvider = FutureProvider<TransitCityData>((ref) {
  final repository = ref.watch(transitDataRepositoryProvider);
  return repository.loadCity(country: 'iran', city: 'tehran');
});

/// [TransitLine]s for the current city, indexed by id, for quick per-station
/// lookups when rendering line badges.
final linesByIdProvider = Provider<Map<String, TransitLine>>((ref) {
  final city = ref.watch(cityDataProvider).valueOrNull;
  if (city == null) return const {};
  return {for (final line in city.lines) line.id: line};
});
