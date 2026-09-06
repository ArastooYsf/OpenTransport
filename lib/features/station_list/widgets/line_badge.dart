import 'package:flutter/material.dart';

import '../../../core/utils/contrast_color.dart';
import '../../../core/utils/hex_color.dart';

/// A rounded pill filled with a transit line's color, per design.md's
/// "Line badge" component spec. Text color is computed for contrast rather
/// than assumed, since line colors are unbounded and data-driven.
class LineBadge extends StatelessWidget {
  const LineBadge({super.key, required this.label, required this.hexColor});

  /// Short line identifier, e.g. "1" or "A".
  final String label;

  /// The line's official color as `#RRGGBB`, straight from the data file.
  final String hexColor;

  @override
  Widget build(BuildContext context) {
    final background = colorFromHex(hexColor);
    final textColor = readableTextColorFor(background);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
