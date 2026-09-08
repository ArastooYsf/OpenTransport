import 'package:flutter/widgets.dart';
import 'package:phosphor_icons/phosphor_icons.dart';

import '../../../data/models/transit_line.dart';
import '../../../l10n/generated/app_localizations.dart';

/// Home-screen presentation for each [TransportType] — the icon and
/// localized title/subtitle for its options-list tile (see [HomeScreen]),
/// generated from whichever transport types are actually present in the
/// loaded city's data rather than a hardcoded tile list.
extension TransportTypeInfo on TransportType {
  IconData get icon => switch (this) {
    TransportType.metro => PhosphorIconsRegular.train,
    TransportType.bus => PhosphorIconsRegular.bus,
    TransportType.tram => PhosphorIconsRegular.tram,
    // Unchanged from the previous hardcoded BRT tile's icon.
    TransportType.brt => PhosphorIconsRegular.bus,
    TransportType.commuterRail => PhosphorIconsRegular.trainRegional,
    TransportType.other => PhosphorIconsRegular.path,
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
