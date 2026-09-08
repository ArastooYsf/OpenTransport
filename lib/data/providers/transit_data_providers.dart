import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/current_country_provider.dart';
import '../models/transit_city_data.dart';
import '../models/transit_line.dart';
import '../repositories/transit_data_repository.dart';

/// Shared instance of [TransitDataRepository] — the only way UI/feature
/// code should reach bundled transit data, per CLAUDE.md's architecture
/// rules.
final transitDataRepositoryProvider = Provider<TransitDataRepository>((ref) {
  return const TransitDataRepository();
});

/// The city currently shown — whichever one belongs to [currentCountryProvider].
/// Only one city is bundled per country today (see [AvailableCountry.defaultCitySlug]),
/// so "current country" and "current city" are, for now, the same choice.
final cityDataProvider = FutureProvider<TransitCityData>((ref) {
  final repository = ref.watch(transitDataRepositoryProvider);
  final country = ref.watch(currentCountryProvider);
  return repository.loadCity(
    country: country.slug,
    city: country.defaultCitySlug,
  );
});

/// [TransitLine]s for the current city, indexed by id, for quick per-station
/// lookups when rendering line badges.
final linesByIdProvider = Provider<Map<String, TransitLine>>((ref) {
  final city = ref.watch(cityDataProvider).valueOrNull;
  if (city == null) return const {};
  return {for (final line in city.lines) line.id: line};
});

/// The distinct [TransportType]s actually present in the current city's
/// lines, in [TransportType.values] order (not raw data order, so tile
/// order stays stable however lines happen to be listed in the JSON) — see
/// Home's dynamic options list, which shows one tile per entry here rather
/// than a hardcoded set.
final availableTransportTypesProvider = Provider<List<TransportType>>((ref) {
  final city = ref.watch(cityDataProvider).valueOrNull;
  if (city == null) return const [];
  final present = city.lines.map((line) => line.transportType).toSet();
  return TransportType.values.where(present.contains).toList();
});
