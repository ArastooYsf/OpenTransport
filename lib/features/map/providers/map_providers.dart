import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/schedule.dart';
import '../../../data/models/transit_line.dart';
import '../../../data/providers/transit_data_providers.dart';
import '../models/simulated_vehicle_position.dart';
import 'vehicle_position_provider.dart';

/// Which segmented-control tab is showing: `null` is the "کامل" (overview)
/// tab — the real OSM map; any [TransportType] is that mode's schematic
/// diagram. Purely in-memory UI state, reset each time the screen opens.
final mapModeProvider = StateProvider<TransportType?>((ref) => null);

/// The current city's lines, grouped by [TransportType] — what the "کامل"
/// overview's toggle-able layers and each schematic tab both draw from.
final linesByTransportTypeProvider =
    Provider<Map<TransportType, List<TransitLine>>>((ref) {
      final city = ref.watch(cityDataProvider).valueOrNull;
      if (city == null) return const {};
      final byType = <TransportType, List<TransitLine>>{};
      for (final line in city.lines) {
        (byType[line.transportType] ??= []).add(line);
      }
      return byType;
    });

/// Which [TransportType] layers are currently shown as overlays on the
/// "کامل" overview map — toggled independently of [mapModeProvider], via
/// the layer chips. Starts with every available type visible.
class VisibleMapLayersNotifier extends StateNotifier<Set<TransportType>> {
  VisibleMapLayersNotifier(this._ref)
    : super(_ref.read(availableTransportTypesProvider).toSet()) {
    _ref.listen(availableTransportTypesProvider, (previous, next) {
      state = next.toSet();
    });
  }

  final Ref _ref;

  void toggle(TransportType type) {
    final next = {...state};
    if (!next.remove(type)) next.add(type);
    state = next;
  }
}

final visibleMapLayersProvider =
    StateNotifierProvider<VisibleMapLayersNotifier, Set<TransportType>>((ref) {
      return VisibleMapLayersNotifier(ref);
    });

/// The tripId of the vehicle currently selected (via its tooltip or the
/// full detail sheet) — `null` means nothing is selected, and every
/// line/rail renders at equal, un-dimmed weight. Set by tapping a vehicle
/// icon (schematic or overview); cleared by tapping elsewhere, tapping the
/// same vehicle again, or closing the tooltip/detail sheet.
final selectedTripIdProvider = StateProvider<String?>((ref) => null);

/// The live [SimulatedVehiclePosition] for [selectedTripIdProvider] —
/// re-derived from the ticking [vehiclePositionsProvider] every second so
/// the tooltip's ETA stays current, not a stale snapshot from the moment
/// of selection. `null` once the trip is no longer active (e.g. it reached
/// its destination while selected).
final selectedVehicleProvider = Provider<SimulatedVehiclePosition?>((ref) {
  final tripId = ref.watch(selectedTripIdProvider);
  if (tripId == null) return null;
  final positions = ref.watch(vehiclePositionsProvider).valueOrNull ?? const [];
  for (final position in positions) {
    if (position.tripId == tripId) return position;
  }
  return null;
});

/// The current city's [Trip]s, indexed by id.
final tripsByIdProvider = Provider<Map<String, Trip>>((ref) {
  final city = ref.watch(cityDataProvider).valueOrNull;
  if (city == null) return const {};
  return {for (final trip in city.trips) trip.id: trip};
});

/// The current city's [StopTime]s, grouped by trip id and sorted by
/// [StopTime.stopSequence] — the full per-trip timetable the tooltip's
/// origin/destination/departure-time figures and the full detail sheet's
/// station list both read from.
final tripStopTimesProvider = Provider<Map<String, List<StopTime>>>((ref) {
  final city = ref.watch(cityDataProvider).valueOrNull;
  if (city == null) return const {};
  final byTrip = <String, List<StopTime>>{};
  for (final stopTime in city.stopTimes) {
    (byTrip[stopTime.tripId] ??= []).add(stopTime);
  }
  for (final stopTimes in byTrip.values) {
    stopTimes.sort((a, b) => a.stopSequence.compareTo(b.stopSequence));
  }
  return byTrip;
});
