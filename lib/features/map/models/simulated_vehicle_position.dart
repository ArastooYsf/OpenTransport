import 'package:latlong2/latlong.dart';

/// A single active trip's interpolated position, computed from the static
/// schedule (calendar/trips/stopTimes) rather than live GPS — see
/// `computeActivePositions` in `providers/vehicle_position_provider.dart`.
/// Purely in-memory, recomputed every tick, so this is a plain immutable
/// class rather than a JSON-backed freezed model.
class SimulatedVehiclePosition {
  const SimulatedVehiclePosition({
    required this.tripId,
    required this.lineId,
    required this.position,
    required this.fromStationId,
    required this.toStationId,
    required this.progress,
    required this.etaToNextStation,
  });

  final String tripId;
  final String lineId;

  /// The interpolated lat/lng between [fromStationId] and [toStationId].
  final LatLng position;

  /// The station this trip most recently departed (or, at `progress == 0`,
  /// is currently at).
  final String fromStationId;

  /// The station this trip is currently heading toward.
  final String toStationId;

  /// How far through the [fromStationId] → [toStationId] segment this
  /// trip is, `0.0` (just departed) to `1.0` (arriving).
  final double progress;

  /// Estimated time remaining until this trip reaches [toStationId] — the
  /// compact selection tooltip's "next station" figure.
  final Duration etaToNextStation;
}
