import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../providers/station_list_providers.dart';
import '../widgets/station_row.dart';

/// Lists every station in the currently loaded city, each with badges for
/// the lines serving it.
class StationListScreen extends ConsumerWidget {
  const StationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final cityAsync = ref.watch(cityDataProvider);
    final linesById = ref.watch(linesByIdProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.stationListTitle)),
      body: cityAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(l10n.loadError)),
        data: (city) => ListView.separated(
          itemCount: city.stations.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final station = city.stations[index];
            final lines = [
              for (final lineId in station.lineIds) ?linesById[lineId],
            ];
            return StationRow(station: station, lines: lines);
          },
        ),
      ),
    );
  }
}
