import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/utils/hex_color.dart';
import '../../../data/models/station.dart';
import '../../../data/models/transit_line.dart';
import '../../../data/models/transport_type_info.dart';
import '../../../data/providers/transit_data_providers.dart';
import '../models/simulated_vehicle_position.dart';
import '../providers/map_providers.dart';
import '../providers/vehicle_position_provider.dart';
import 'layer_toggle_chips.dart';
import 'trip_tooltip.dart';

/// The "کامل" (overview) tab's real map — an OpenStreetMap base layer (see
/// CLAUDE.md/design.md: free, open, no API key or billing) with each
/// visible [TransportType]'s lines drawn as rail-styled [Polyline]s and
/// stations as [Marker]s, both in the line's own real color, plus a moving
/// icon per active [SimulatedVehiclePosition]. [LayerToggleChips] above it
/// shows/hides a type's overlay via [visibleMapLayersProvider].
///
/// Tapping a vehicle icon selects it (see [selectedTripIdProvider]),
/// dimming every other line/rail/vehicle to [fallbackLineColor] and
/// showing its [TripTooltip] anchored just above it; tapping the map
/// background, or the selected vehicle again, deselects.
class OverviewMapView extends ConsumerWidget {
  const OverviewMapView({super.key, required this.availableTypes});

  final List<TransportType> availableTypes;

  // Required by OSM's tile usage policy: a real user agent identifying the
  // app, not a browser-style default.
  static const _userAgentPackageName = 'org.opentransport.open_transport';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final linesByType = ref.watch(linesByTransportTypeProvider);
    final linesById = ref.watch(linesByIdProvider);
    final stationsById = ref.watch(stationsByIdProvider);
    final visibleLayers = ref.watch(visibleMapLayersProvider);
    final selectedVehicle = ref.watch(selectedVehicleProvider);
    final selectedLineId = selectedVehicle?.lineId;
    final allPositions =
        ref.watch(vehiclePositionsProvider).valueOrNull ?? const [];
    final visiblePositions = [
      for (final position in allPositions)
        if (linesById[position.lineId]?.transportType case final type?)
          if (visibleLayers.contains(type)) position,
    ];

    final center = _centerOf(stationsById.values);

    Color colorFor(TransitLine line) {
      if (selectedLineId == null) return colorFromHex(line.color);
      return selectedLineId == line.id
          ? colorFromHex(line.color)
          : fallbackLineColor;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: LayerToggleChips(availableTypes: availableTypes),
        ),
        Expanded(
          child: FlutterMap(
            options: MapOptions(
              initialCenter: center,
              initialZoom: 12,
              onTap: (_, _) =>
                  ref.read(selectedTripIdProvider.notifier).state = null,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: _userAgentPackageName,
                // Plain network fetch, no on-disk tile cache: flutter_map
                // defaults to an on-disk cache (via path_provider) if a
                // caching provider isn't given explicitly, which is a real
                // feature this phase doesn't ask for (it'd need its own
                // eviction/size policy, not a drive-by add) — not just a
                // no-op default.
                tileProvider: NetworkTileProvider(
                  cachingProvider: const DisabledMapCachingProvider(),
                ),
              ),
              for (final type in availableTypes)
                if (visibleLayers.contains(type))
                  PolylineLayer(
                    polylines: [
                      for (final line in linesByType[type] ?? const [])
                        Polyline(
                          points: _pointsFor(line, stationsById),
                          color: colorFor(line),
                          strokeWidth: selectedLineId == line.id ? 6 : 4,
                        ),
                      // design.md: "a base line in the line's color plus
                      // subtle perpendicular tick marks... to read as
                      // 'railway track'." Drawn as short Polylines (not a
                      // fixed-pixel overlay) so they pan/zoom with the map
                      // like any other real-world-coordinate layer.
                      for (final line in linesByType[type] ?? const [])
                        ..._railTicksFor(
                          _pointsFor(line, stationsById),
                          colorFor(line),
                        ),
                    ],
                  ),
              for (final type in availableTypes)
                if (visibleLayers.contains(type))
                  MarkerLayer(
                    markers: [
                      for (final line in linesByType[type] ?? const [])
                        for (final station in _stationsFor(line, stationsById))
                          Marker(
                            point: LatLng(station.lat, station.lng),
                            width: 12,
                            height: 12,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: colorFor(line),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                    ],
                  ),
              MarkerLayer(
                markers: [
                  for (final vehicle in visiblePositions)
                    if (linesById[vehicle.lineId] case final line?)
                      if (vehicle.tripId == selectedVehicle?.tripId)
                        Marker(
                          point: vehicle.position,
                          width: 200,
                          height: 200,
                          alignment: Alignment.topCenter,
                          child: GestureDetector(
                            key: ValueKey('vehicle-marker-${vehicle.tripId}'),
                            onTap: () =>
                                ref
                                        .read(selectedTripIdProvider.notifier)
                                        .state =
                                    null,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TripTooltip(vehicle: vehicle),
                                const SizedBox(height: 2),
                                _VehicleMarker(
                                  color: colorFromHex(line.color),
                                  icon: line.transportType.fillIcon,
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        Marker(
                          point: vehicle.position,
                          width: 26,
                          height: 26,
                          child: GestureDetector(
                            key: ValueKey('vehicle-marker-${vehicle.tripId}'),
                            onTap: () =>
                                ref
                                        .read(selectedTripIdProvider.notifier)
                                        .state =
                                    vehicle.tripId,
                            child: _VehicleMarker(
                              color: colorFor(line),
                              icon: line.transportType.fillIcon,
                            ),
                          ),
                        ),
                ],
              ),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    '© OpenStreetMap contributors',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<LatLng> _pointsFor(TransitLine line, Map<String, Station> byId) {
    return _stationsFor(
      line,
      byId,
    ).map((station) => LatLng(station.lat, station.lng)).toList();
  }

  List<Station> _stationsFor(TransitLine line, Map<String, Station> byId) {
    return line.stationIds.map((id) => byId[id]).whereType<Station>().toList();
  }

  LatLng _centerOf(Iterable<Station> stations) {
    if (stations.isEmpty) {
      // Tehran, as a reasonable fallback while no station data has loaded.
      return const LatLng(35.6892, 51.3890);
    }
    final lat =
        stations.map((s) => s.lat).reduce((a, b) => a + b) / stations.length;
    final lng =
        stations.map((s) => s.lng).reduce((a, b) => a + b) / stations.length;
    return LatLng(lat, lng);
  }

  /// A handful of short perpendicular tick marks along each segment of
  /// [points] — sized as a fraction of that segment's own length rather
  /// than a real-world distance, the same "good enough to start"
  /// simplification [SchematicLineView]'s geometry already accepts.
  List<Polyline> _railTicksFor(List<LatLng> points, Color color) {
    const ticksPerSegment = 5;
    const tickHalfLengthFactor = 0.05;
    final tickColor = color.withValues(alpha: 0.6);

    final ticks = <Polyline>[];
    for (var i = 0; i < points.length - 1; i++) {
      final from = points[i];
      final to = points[i + 1];
      final deltaLat = to.latitude - from.latitude;
      final deltaLng = to.longitude - from.longitude;
      final length = math.sqrt(deltaLat * deltaLat + deltaLng * deltaLng);
      if (length == 0) continue;

      final perpLat = -deltaLng / length * length * tickHalfLengthFactor;
      final perpLng = deltaLat / length * length * tickHalfLengthFactor;

      for (var t = 1; t < ticksPerSegment; t++) {
        final fraction = t / ticksPerSegment;
        final baseLat = from.latitude + deltaLat * fraction;
        final baseLng = from.longitude + deltaLng * fraction;
        ticks.add(
          Polyline(
            points: [
              LatLng(baseLat + perpLat, baseLng + perpLng),
              LatLng(baseLat - perpLat, baseLng - perpLng),
            ],
            color: tickColor,
            strokeWidth: 2,
          ),
        );
      }
    }
    return ticks;
  }
}

class _VehicleMarker extends StatelessWidget {
  const _VehicleMarker({required this.color, required this.icon});

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Icon(icon, size: 14, color: Colors.white),
    );
  }
}
