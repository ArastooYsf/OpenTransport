import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/contrast_color.dart';
import '../../../data/models/transit_line.dart';
import '../../../data/models/transport_type_info.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../providers/map_providers.dart';

/// One toggle-able chip per [TransportType] present in the current city,
/// shown above the "کامل" overview map — turns that type's lines/stations
/// overlay on [OverviewMapView] on or off via [visibleMapLayersProvider].
class LayerToggleChips extends ConsumerWidget {
  const LayerToggleChips({super.key, required this.availableTypes});

  final List<TransportType> availableTypes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visible = ref.watch(visibleMapLayersProvider);
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final type in availableTypes) ...[
            _LayerChip(
              icon: type.outlineIcon,
              fillIcon: type.fillIcon,
              label: type.title(l10n),
              isOn: visible.contains(type),
              onTap: () =>
                  ref.read(visibleMapLayersProvider.notifier).toggle(type),
            ),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

class _LayerChip extends StatelessWidget {
  const _LayerChip({
    required this.icon,
    required this.fillIcon,
    required this.label,
    required this.isOn,
    required this.onTap,
  });

  final IconData icon;
  final IconData fillIcon;
  final String label;
  final bool isOn;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final foreground = isOn
        ? readableTextColorFor(colors.accent)
        : colors.textSecondary;

    return Semantics(
      button: true,
      selected: isOn,
      label: label,
      excludeSemantics: true,
      child: Material(
        color: isOn ? colors.accent : colors.surface,
        elevation: AppElevation.level1,
        surfaceTintColor: Colors.transparent,
        borderRadius: BorderRadius.circular(999),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(999),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(isOn ? fillIcon : icon, size: 16, color: foreground),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: foreground),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
