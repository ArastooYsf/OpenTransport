import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/transit_city_data.dart';

/// Loads bundled transit files for a city and exposes them as one typed
/// [TransitCityData].
///
/// Per CLAUDE.md's Transit data section, a city's data is split into two
/// independently-evolving files on disk — `<city>.json` (structure: lines/
/// stations, validated against `structure.schema.json`) and
/// `<city>.schedule.json` (calendar/trips/stopTimes, validated against
/// `schedule.schema.json`) — but [TransitCityData]'s shape is unchanged, so
/// callers (`cityDataProvider` and everything built on it) don't need to
/// know the split exists. The two files are parsed independently before
/// being merged, so a shape change in one never affects parsing the other.
///
/// UI code must never read these JSON assets directly — always go through
/// this repository, per the architecture rules in CLAUDE.md. A future
/// version of this repository can add a `data/remote/` fallback for
/// manifest-driven updates without changing this interface.
class TransitDataRepository {
  const TransitDataRepository();

  /// Loads and merges the bundled structure + schedule files for
  /// [country]/[city], e.g. `'iran'`, `'tehran'` for
  /// `data/iran/tehran.json` + `data/iran/tehran.schedule.json`.
  Future<TransitCityData> loadCity({
    required String country,
    required String city,
  }) async {
    final structureRaw = await rootBundle.loadString(
      'data/$country/$city.json',
    );
    final structure = jsonDecode(structureRaw) as Map<String, dynamic>;

    final scheduleRaw = await rootBundle.loadString(
      'data/$country/$city.schedule.json',
    );
    final schedule = jsonDecode(scheduleRaw) as Map<String, dynamic>;

    return TransitCityData.fromJson({
      ...structure,
      'calendar': schedule['calendar'],
      'trips': schedule['trips'],
      'stopTimes': schedule['stopTimes'],
    });
  }

  /// The estimated delay for [tripId], sourced from a not-yet-implemented
  /// backend call — always zero until that algorithm exists. Kept on this
  /// repository (rather than left unmodeled) so the eventual real value
  /// is a call-site change, not a rework, once the Map feature's schedule
  /// simulation (still unbuilt) is ready to read it.
  Future<int> getDelaySeconds(String tripId) async => 0;
}
