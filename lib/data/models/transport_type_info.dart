import 'package:flutter/widgets.dart';
import 'package:phosphor_icons/phosphor_icons.dart';

import 'transit_line.dart';
import '../../l10n/generated/app_localizations.dart';

/// Shared presentation for each [TransportType] — icon (both weights, per
/// design.md's mixed outline/fill system), and localized title/subtitle —
/// generated from whichever transport types are actually present in the
/// loaded city's data rather than a hardcoded set. Used by Home's dynamic
/// options list and the Map feature's mode segmented control (its [title]
/// doubles as a short tab label).
extension TransportTypeInfo on TransportType {
  IconData get outlineIcon => switch (this) {
    TransportType.metro => PhosphorIconsRegular.train,
    TransportType.bus => PhosphorIconsRegular.bus,
    TransportType.tram => PhosphorIconsRegular.tram,
    // Unchanged from the previous hardcoded BRT tile's icon.
    TransportType.brt => PhosphorIconsRegular.bus,
    TransportType.commuterRail => PhosphorIconsRegular.trainRegional,
    TransportType.other => PhosphorIconsRegular.path,
  };

  IconData get fillIcon => switch (this) {
    TransportType.metro => PhosphorIconsFill.train,
    TransportType.bus => PhosphorIconsFill.bus,
    TransportType.tram => PhosphorIconsFill.tram,
    TransportType.brt => PhosphorIconsFill.bus,
    TransportType.commuterRail => PhosphorIconsFill.trainRegional,
    TransportType.other => PhosphorIconsFill.path,
  };

  String title(AppLocalizations l10n) => switch (this) {
    TransportType.metro => l10n.homeMetroTitle,
    TransportType.bus => l10n.homeBusTitle,
    TransportType.tram => l10n.homeTramTitle,
    TransportType.brt => l10n.homeBrtTitle,
    TransportType.commuterRail => l10n.homeCommuterRailTitle,
    TransportType.other => l10n.homeOtherTransportTitle,
  };

  String subtitle(AppLocalizations l10n) => switch (this) {
    TransportType.metro => l10n.homeMetroSubtitle,
    TransportType.bus => l10n.homeBusSubtitle,
    TransportType.tram => l10n.homeTramSubtitle,
    TransportType.brt => l10n.homeBrtSubtitle,
    TransportType.commuterRail => l10n.homeCommuterRailSubtitle,
    TransportType.other => l10n.homeOtherTransportSubtitle,
  };
}
