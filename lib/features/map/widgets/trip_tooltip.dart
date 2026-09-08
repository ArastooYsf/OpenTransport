import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_icons/phosphor_icons.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/localized_text.dart';
import '../../../data/providers/transit_data_providers.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../models/simulated_vehicle_position.dart';
import '../providers/map_providers.dart';
import '../utils/gtfs_time_format.dart';
import 'trip_detail_sheet.dart';

/// The compact chat-bubble-style tooltip for a selected vehicle — origin →
/// destination, ETA to its next station, and departure time, plus a
/// "بیشتر" (more) button opening [showTripDetailSheet]. Callers position
/// this (a plain [Column] ending in a downward-pointing tail, so it reads
/// as anchored to whatever sits directly below it) — see
/// [SchematicLineView] and [OverviewMapView] for the two different
/// anchoring strategies (fixed canvas vs. real map coordinates).
class TripTooltip extends ConsumerWidget {
  const TripTooltip({super.key, required this.vehicle});

  final SimulatedVehiclePosition vehicle;

  static const _tailSize = Size(16, 8);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    final colors = context.colors;
    final stationsById = ref.watch(stationsByIdProvider);
    final stopTimes = ref.watch(tripStopTimesProvider)[vehicle.tripId];

    if (stopTimes == null || stopTimes.isEmpty) return const SizedBox.shrink();

    final originName = resolveLocalizedText(
      stationsById[stopTimes.first.stationId]?.name ?? const {},
      locale,
    );
    final destinationName = resolveLocalizedText(
      stationsById[stopTimes.last.stationId]?.name ?? const {},
      locale,
    );
    final departureRaw =
        stopTimes.first.departureTime ?? stopTimes.first.arrivalTime;
    final etaMinutes = vehicle.etaToNextStation.inSeconds ~/ 60;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: colors.surfaceElevated,
          elevation: AppElevation.level3,
          surfaceTintColor: Colors.transparent,
          borderRadius: BorderRadius.circular(AppTheme.cardRadius),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        originName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(PhosphorIconsRegular.caretRight, size: 14),
                    ),
                    Flexible(
                      child: Text(
                        destinationName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  vehicle.etaToNextStation.inSeconds < 60
                      ? l10n.mapTripArrivingNow
                      : l10n.mapTripNextStationEta(etaMinutes),
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: colors.textSecondary),
                ),
                Text(
                  l10n.mapTripDepartedAt(formatGtfsTime(departureRaw)),
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(48, 32),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () =>
                        showTripDetailSheet(context, tripId: vehicle.tripId),
                    child: Text(l10n.mapTripMoreButton),
                  ),
                ),
              ],
            ),
          ),
        ),
        CustomPaint(
          size: _tailSize,
          painter: _TailPainter(color: colors.surfaceElevated),
        ),
      ],
    );
  }
}

/// A small downward-pointing triangle, the same color as the bubble above
/// it, so the whole shape reads as one continuous speech-bubble pointing
/// at the vehicle icon underneath.
class _TailPainter extends CustomPainter {
  const _TailPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _TailPainter oldDelegate) =>
      oldDelegate.color != color;
}
