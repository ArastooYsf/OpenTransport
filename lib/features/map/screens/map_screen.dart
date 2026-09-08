import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers/transit_data_providers.dart';
import '../providers/map_providers.dart';
import '../providers/vehicle_position_provider.dart';
import '../widgets/mode_segmented_control.dart';
import '../widgets/overview_map_view.dart';
import '../widgets/schematic_line_view.dart';

/// The Map tab: a "کامل" (overview) real-map mode plus one schematic-diagram
/// mode per transport type present in the current city's data — see
/// [ModeSegmentedControl]. Which tab is active lives in [mapModeProvider].
class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availableTypes = ref.watch(availableTransportTypesProvider);
    final mode = ref.watch(mapModeProvider);
    final linesByType = ref.watch(linesByTransportTypeProvider);
    final stationsById = ref.watch(stationsByIdProvider);
    final positions =
        ref.watch(vehiclePositionsProvider).valueOrNull ?? const [];

    final modeLines = linesByType[mode] ?? const [];
    final modeLineIds = modeLines.map((line) => line.id).toSet();
    final modePositions = [
      for (final position in positions)
        if (modeLineIds.contains(position.lineId)) position,
    ];

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: ModeSegmentedControl(
              availableTypes: availableTypes,
              selected: mode,
              onSelected: (type) =>
                  ref.read(mapModeProvider.notifier).state = type,
            ),
          ),
          Expanded(
            child: mode == null
                ? OverviewMapView(availableTypes: availableTypes)
                : SchematicLineView(
                    lines: modeLines,
                    stationsById: stationsById,
                    positions: modePositions,
                  ),
          ),
        ],
      ),
    );
  }
}
