import 'package:flutter/material.dart';
import 'package:phosphor_icons/phosphor_icons.dart';

import '../../../core/theme/app_theme.dart';

/// A small pill-shaped control showing a current choice (a flag, a
/// language) with a trailing "tap to change" chevron — used by
/// [HomeTopBar]'s country/language switchers. design.md's Elevation
/// section: a resting, always-visible control, so Level 1 — clearly a
/// tappable surface, but the quietest shadow in the scale.
class SwitcherChip extends StatelessWidget {
  const SwitcherChip({
    super.key,
    required this.leading,
    required this.label,
    required this.semanticLabel,
    required this.onTap,
  });

  final Widget leading;
  final String label;
  final String semanticLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final borderRadius = BorderRadius.circular(999);

    return Semantics(
      button: true,
      label: semanticLabel,
      child: Material(
        color: colors.surface,
        elevation: AppElevation.level1,
        surfaceTintColor: Colors.transparent,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                leading,
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: colors.textPrimary),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  PhosphorIconsRegular.caretDown,
                  size: 14,
                  color: colors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
