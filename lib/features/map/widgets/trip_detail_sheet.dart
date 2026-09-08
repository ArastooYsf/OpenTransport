import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/localized_text.dart';
import '../../../core/widgets/line_badge.dart';
import '../../../data/providers/transit_data_providers.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../providers/map_providers.dart';
import '../utils/gtfs_time_format.dart';

/// Opens the full trip detail bottom sheet for [tripId] — the "بیشتر" (more)
/// affordance inside [TripTooltip] — showing the complete station list with
/// times and the line's own info. Selection (see [selectedTripIdProvider])
/// stays active for as long as this sheet is open — closing it (any way:
/// drag down, tap the barrier, back gesture) clears the selection, which is
/// what actually restores every line/rail to its normal color.
Future<void> showTripDetailSheet(
  BuildContext context, {
  required String tripId,
}) async {
  final container = ProviderScope.containerOf(context);
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => _TripDetailSheet(tripId: tripId),
  );
  container.read(selectedTripIdProvider.notifier).state = null;
}

class _TripDetailSheet extends ConsumerWidget {
  const _TripDetailSheet({required this.tripId});

  final String tripId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    final colors = context.colors;
    final stopTimes = ref.watch(tripStopTimesProvider)[tripId] ?? const [];
    final trip = ref.watch(tripsByIdProvider)[tripId];
    final line = trip == null
        ? null
        : ref.watch(linesByIdProvider)[trip.lineId];
    final stationsById = ref.watch(stationsByIdProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Row(
                children: [
                  if (line != null) ...[
                    LineBadge(
                      label:
                          line.shortName ??
                          resolveLocalizedText(line.name, locale),
                      hexColor: line.color,
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Text(
                      l10n.mapTripDetailTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  l10n.mapTripStationsHeading,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: colors.textSecondary),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                itemCount: stopTimes.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final stopTime = stopTimes[index];
                  final name = resolveLocalizedText(
                    stationsById[stopTime.stationId]?.name ?? const {},
                    locale,
                  );
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Text(
                          formatGtfsTime(stopTime.arrivalTime),
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: colors.textSecondary),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
