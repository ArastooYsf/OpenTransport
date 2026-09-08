import 'package:flutter/material.dart';

import '../../../core/utils/localized_text.dart';
import '../../../core/widgets/line_badge.dart';
import '../../../data/models/station.dart';
import '../../../data/models/transit_line.dart';

/// A station name paired with a badge for every line serving it, per
/// design.md's "Station chip/row" component. More than one badge means
/// the station is an interchange.
class StationRow extends StatelessWidget {
  const StationRow({super.key, required this.station, required this.lines});

  final Station station;

  /// The lines serving [station], in [Station.lineIds] order. Passed in
  /// (rather than looked up here) so this widget stays presentation-only.
  final List<TransitLine> lines;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final name = resolveLocalizedText(station.name, locale);

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(name, style: Theme.of(context).textTheme.bodyLarge),
          ),
          const SizedBox(width: 12),
          Wrap(
            spacing: 6,
            children: [
              for (final line in lines)
                LineBadge(
                  label:
                      line.shortName ?? resolveLocalizedText(line.name, locale),
                  hexColor: line.color,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
