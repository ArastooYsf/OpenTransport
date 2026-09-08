import 'dart:ui' show PathMetric;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/hex_color.dart';
import '../../../data/models/station.dart';
import '../../../data/models/transit_line.dart';
import '../../../data/models/transport_type_info.dart';
import '../models/simulated_vehicle_position.dart';
import '../providers/map_providers.dart';
import 'trip_tooltip.dart';

/// A single mode tab's (e.g. "مترو") schematic diagram — not the real
/// [OverviewMapView]/OSM map, a custom-drawn simplification: each of that
/// [TransportType]'s lines as a straight/angled path through its stations,
/// in [TransitLine.stationIds] order and the line's own real color, styled
/// with subtle rail-like tick marks. Each active [SimulatedVehiclePosition]
/// on one of [lines] is drawn as a small icon moving along that path;
/// tapping one selects it (see [selectedTripIdProvider]) — dimming every
/// other line/rail and showing its [TripTooltip] anchored just above it.
///
/// Station positions come from a straightforward linear fit of each
/// station's real lat/lng into the available canvas — not a true schematic
/// layout algorithm (45°/90°-snapped paths, deconflicted spacing). That's
/// a reasonable "good enough to start" simplification; a real layout
/// algorithm can replace just this widget's geometry later without
/// touching anything else about the Map feature.
class SchematicLineView extends ConsumerWidget {
  const SchematicLineView({
    super.key,
    required this.lines,
    required this.stationsById,
    this.positions = const [],
  });

  final List<TransitLine> lines;
  final Map<String, Station> stationsById;
  final List<SimulatedVehiclePosition> positions;

  static const _padding = 32.0;
  static const _tooltipWidth = 180.0;
  static const _tooltipGap = 6.0;
  static const _vehicleRadius = 11.0;
  static const _hitTestRadius = 22.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedVehicle = ref.watch(selectedVehicleProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        final layout = _layoutFor(size);
        if (layout == null) return const SizedBox.shrink();

        final selectedOffset = selectedVehicle == null
            ? null
            : _vehicleOffset(layout, selectedVehicle);

        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapUp: (details) =>
                    _handleTap(ref, layout, details.localPosition),
                child: CustomPaint(
                  painter: _SchematicPainter(
                    layout: layout,
                    positions: positions,
                    selectedLineId: selectedVehicle?.lineId,
                  ),
                  size: Size.infinite,
                ),
              ),
            ),
            if (selectedVehicle != null && selectedOffset != null)
              Positioned(
                top: 0,
                bottom:
                    size.height -
                    selectedOffset.dy +
                    _vehicleRadius +
                    _tooltipGap,
                left: (selectedOffset.dx - _tooltipWidth / 2).clamp(
                  0,
                  (size.width - _tooltipWidth).clamp(0, double.infinity),
                ),
                width: _tooltipWidth,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: IgnorePointer(
                    ignoring: false,
                    child: TripTooltip(vehicle: selectedVehicle),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void _handleTap(WidgetRef ref, _SchematicLayout layout, Offset tapPosition) {
    String? closestTripId;
    var closestDistance = _hitTestRadius;

    for (final lineLayout in layout.lines) {
      for (final vehicle in positions) {
        if (vehicle.lineId != lineLayout.line.id) continue;
        final offset = _vehicleOffset(layout, vehicle);
        if (offset == null) continue;
        final distance = (offset - tapPosition).distance;
        if (distance <= closestDistance) {
          closestDistance = distance;
          closestTripId = vehicle.tripId;
        }
      }
    }

    final current = ref.read(selectedTripIdProvider);
    ref.read(selectedTripIdProvider.notifier).state = closestTripId == current
        ? null
        : closestTripId;
  }

  Offset? _vehicleOffset(
    _SchematicLayout layout,
    SimulatedVehiclePosition vehicle,
  ) {
    final lineLayout = layout.lines.firstWhereOrNull(
      (candidate) => candidate.line.id == vehicle.lineId,
    );
    if (lineLayout == null) return null;

    final fromIndex = lineLayout.line.stationIds.indexOf(vehicle.fromStationId);
    final toIndex = lineLayout.line.stationIds.indexOf(vehicle.toStationId);
    if (fromIndex == -1 || toIndex == -1) return null;

    final segmentStart = lineLayout.cumulativeDistances[fromIndex];
    final segmentEnd = lineLayout.cumulativeDistances[toIndex];
    final distance =
        (segmentStart + (segmentEnd - segmentStart) * vehicle.progress).clamp(
          0.0,
          lineLayout.metric.length,
        );
    return lineLayout.metric.getTangentForOffset(distance)?.position;
  }

  /// Every station referenced by [lines], deduped by id, and each line's
  /// projected [Path]/[PathMetric]/cumulative pixel distances — computed
  /// once per build and shared between painting, tap hit-testing, and the
  /// selected tooltip's anchor position, so all three always agree.
  _SchematicLayout? _layoutFor(Size size) {
    final seen = <String>{};
    final involvedStations = <Station>[];
    for (final line in lines) {
      for (final id in line.stationIds) {
        final station = stationsById[id];
        if (station != null && seen.add(id)) involvedStations.add(station);
      }
    }
    if (involvedStations.isEmpty) return null;

    final project = _projectionFor(involvedStations, size);
    final stationOffsets = {
      for (final station in involvedStations) station.id: project(station),
    };

    final lineLayouts = <_LineLayout>[];
    for (final line in lines) {
      final points = [for (final id in line.stationIds) ?stationOffsets[id]];
      if (points.length < 2) continue;

      final path = Path()..moveTo(points.first.dx, points.first.dy);
      for (final point in points.skip(1)) {
        path.lineTo(point.dx, point.dy);
      }

      final cumulative = <double>[0];
      for (var i = 1; i < points.length; i++) {
        cumulative.add(
          cumulative[i - 1] + (points[i] - points[i - 1]).distance,
        );
      }

      lineLayouts.add(
        _LineLayout(
          line: line,
          points: points,
          metric: path.computeMetrics().first,
          cumulativeDistances: cumulative,
        ),
      );
    }

    return _SchematicLayout(stations: stationOffsets, lines: lineLayouts);
  }

  /// A simple linear fit of every involved station's real lat/lng into
  /// [size] (minus [_padding] on each side), flipping the vertical axis so
  /// higher latitude (north) lands higher on screen, as any north-up map
  /// reads.
  Offset Function(Station) _projectionFor(List<Station> stations, Size size) {
    var minLat = stations.first.lat, maxLat = stations.first.lat;
    var minLng = stations.first.lng, maxLng = stations.first.lng;
    for (final station in stations.skip(1)) {
      minLat = station.lat < minLat ? station.lat : minLat;
      maxLat = station.lat > maxLat ? station.lat : maxLat;
      minLng = station.lng < minLng ? station.lng : minLng;
      maxLng = station.lng > maxLng ? station.lng : maxLng;
    }

    final latSpan = (maxLat - minLat).abs() < 1e-9 ? 1.0 : maxLat - minLat;
    final lngSpan = (maxLng - minLng).abs() < 1e-9 ? 1.0 : maxLng - minLng;
    final width = (size.width - _padding * 2).clamp(1.0, double.infinity);
    final height = (size.height - _padding * 2).clamp(1.0, double.infinity);

    return (station) => Offset(
      _padding + (station.lng - minLng) / lngSpan * width,
      _padding + (1 - (station.lat - minLat) / latSpan) * height,
    );
  }
}

class _SchematicLayout {
  const _SchematicLayout({required this.stations, required this.lines});

  final Map<String, Offset> stations;
  final List<_LineLayout> lines;
}

class _LineLayout {
  const _LineLayout({
    required this.line,
    required this.points,
    required this.metric,
    required this.cumulativeDistances,
  });

  final TransitLine line;
  final List<Offset> points;
  final PathMetric metric;
  final List<double> cumulativeDistances;
}

class _SchematicPainter extends CustomPainter {
  _SchematicPainter({
    required this.layout,
    required this.positions,
    required this.selectedLineId,
  });

  final _SchematicLayout layout;
  final List<SimulatedVehiclePosition> positions;
  final String? selectedLineId;

  static const _stationRadius = 5.0;
  static const _vehicleRadius = 11.0;

  // design.md: "a base line in the line's color plus subtle perpendicular
  // tick marks along it to read as 'railway track' rather than a plain
  // line" — spacing/length are screen-pixel constants since this painter
  // already works in a fixed canvas, not real-world distance.
  static const _tickSpacing = 18.0;
  static const _tickHalfLength = 5.0;

  @override
  void paint(Canvas canvas, Size size) {
    for (final lineLayout in layout.lines) {
      final line = lineLayout.line;
      final isDimmed = selectedLineId != null && selectedLineId != line.id;
      final isSelected = selectedLineId != null && selectedLineId == line.id;
      final color = isDimmed ? fallbackLineColor : colorFromHex(line.color);

      final path = Path()
        ..moveTo(lineLayout.points.first.dx, lineLayout.points.first.dy);
      for (final point in lineLayout.points.skip(1)) {
        path.lineTo(point.dx, point.dy);
      }

      if (isSelected) {
        // A soft glow underneath the selected line's own (slightly
        // thicker) stroke — "full color/emphasis," per the spec.
        canvas.drawPath(
          path,
          Paint()
            ..color = color.withValues(alpha: 0.35)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 12
            ..strokeCap = StrokeCap.round
            ..strokeJoin = StrokeJoin.round
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
        );
      }

      canvas.drawPath(
        path,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = isSelected ? 6 : 4
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      );

      _drawRailTicks(canvas, lineLayout.metric, color);

      final icon = line.transportType.fillIcon;
      for (final vehicle in positions) {
        if (vehicle.lineId != line.id) continue;
        final fromIndex = line.stationIds.indexOf(vehicle.fromStationId);
        final toIndex = line.stationIds.indexOf(vehicle.toStationId);
        if (fromIndex == -1 || toIndex == -1) continue;

        final segmentStart = lineLayout.cumulativeDistances[fromIndex];
        final segmentEnd = lineLayout.cumulativeDistances[toIndex];
        final distance =
            (segmentStart + (segmentEnd - segmentStart) * vehicle.progress)
                .clamp(0.0, lineLayout.metric.length);
        final tangent = lineLayout.metric.getTangentForOffset(distance);
        if (tangent != null) {
          _drawVehicleIcon(canvas, tangent.position, color, icon);
        }
      }
    }

    final stationPaint = Paint()..color = Colors.white;
    for (final entry in layout.stations.entries) {
      canvas.drawCircle(entry.value, _stationRadius, stationPaint);
      canvas.drawCircle(
        entry.value,
        _stationRadius,
        Paint()
          ..color = _ringColorFor(entry.key)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }
  }

  Color _ringColorFor(String stationId) {
    for (final lineLayout in layout.lines) {
      if (!lineLayout.line.stationIds.contains(stationId)) continue;
      final isDimmed =
          selectedLineId != null && selectedLineId != lineLayout.line.id;
      return isDimmed ? fallbackLineColor : colorFromHex(lineLayout.line.color);
    }
    return fallbackLineColor;
  }

  void _drawRailTicks(Canvas canvas, PathMetric metric, Color color) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.6)
      ..strokeWidth = 1.5;

    var distance = _tickSpacing / 2;
    while (distance < metric.length) {
      final tangent = metric.getTangentForOffset(distance);
      if (tangent != null) {
        final direction = tangent.vector;
        final perpendicular = Offset(-direction.dy, direction.dx);
        canvas.drawLine(
          tangent.position + perpendicular * _tickHalfLength,
          tangent.position - perpendicular * _tickHalfLength,
          paint,
        );
      }
      distance += _tickSpacing;
    }
  }

  void _drawVehicleIcon(
    Canvas canvas,
    Offset center,
    Color color,
    IconData icon,
  ) {
    canvas.drawCircle(center, _vehicleRadius, Paint()..color = color);
    canvas.drawCircle(
      center,
      _vehicleRadius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = Colors.white,
    );

    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: 13,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          color: Colors.white,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
      canvas,
      center - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant _SchematicPainter oldDelegate) =>
      oldDelegate.layout != layout ||
      oldDelegate.positions != positions ||
      oldDelegate.selectedLineId != selectedLineId;
}

extension _FirstWhereOrNull<T> on List<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
