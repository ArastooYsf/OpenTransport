import 'package:flutter/material.dart';
import 'package:phosphor_icons/phosphor_icons.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/contrast_color.dart';
import '../../../data/models/transit_line.dart';
import '../../../data/models/transport_type_info.dart';
import '../../../l10n/generated/app_localizations.dart';

/// [MapScreen]'s top segmented control — "کامل" (overview, `null`) plus one
/// tab per [TransportType] present in the current city's data, in the same
/// dynamic, no-hardcoded-list spirit as Home's options list. A small
/// solid-accent pill slides behind whichever tab is selected, echoing
/// [MainBottomNavBar]'s indicator (without its liquid stretch — a plain
/// slide is enough for a control this size).
class ModeSegmentedControl extends StatelessWidget {
  const ModeSegmentedControl({
    super.key,
    required this.availableTypes,
    required this.selected,
    required this.onSelected,
  });

  /// The transport types to show a tab for — "کامل" is always prepended.
  final List<TransportType> availableTypes;
  final TransportType? selected;
  final ValueChanged<TransportType?> onSelected;

  static const _height = 44.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tabs = <TransportType?>[null, ...availableTypes];
    final selectedIndex = tabs.indexOf(selected);

    return Material(
      color: colors.surfaceElevated,
      elevation: AppElevation.level1,
      surfaceTintColor: Colors.transparent,
      borderRadius: BorderRadius.circular(999),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth / tabs.length;

            return SizedBox(
              height: _height,
              child: Stack(
                children: [
                  AnimatedPositionedDirectional(
                    duration: AppMotion.base,
                    curve: AppMotion.curve,
                    top: 0,
                    bottom: 0,
                    start: itemWidth * selectedIndex,
                    width: itemWidth,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.accent,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      for (final tab in tabs)
                        Expanded(
                          child: _SegmentItem(
                            isSelected: tab == selected,
                            icon: tab == null
                                ? PhosphorIconsRegular.mapTrifold
                                : tab.outlineIcon,
                            fillIcon: tab == null
                                ? PhosphorIconsFill.mapTrifold
                                : tab.fillIcon,
                            label: tab == null
                                ? AppLocalizations.of(context).mapOverviewTab
                                : tab.title(AppLocalizations.of(context)),
                            onTap: () => onSelected(tab),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SegmentItem extends StatelessWidget {
  const _SegmentItem({
    required this.isSelected,
    required this.icon,
    required this.fillIcon,
    required this.label,
    required this.onTap,
  });

  final bool isSelected;
  final IconData icon;
  final IconData fillIcon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final color = isSelected
        ? readableTextColorFor(colors.accent)
        : colors.textSecondary;

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: AnimatedDefaultTextStyle(
          duration: AppMotion.fast,
          style: (Theme.of(context).textTheme.labelLarge ?? const TextStyle())
              .copyWith(color: color, fontWeight: FontWeight.w700),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(isSelected ? fillIcon : icon, size: 18, color: color),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
