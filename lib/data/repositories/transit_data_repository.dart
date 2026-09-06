import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/transit_city_data.dart';

/// Loads bundled `/data/<country>/<city>.json` transit files and exposes
/// them as typed [TransitCityData].
///
/// UI code must never read these JSON assets directly — always go through
/// this repository, per the architecture rules in CLAUDE.md. A future
/// version of this repository can add a `data/remote/` fallback for
/// manifest-driven updates without changing this interface.
class TransitDataRepository {
  const TransitDataRepository();

  /// Loads the bundled data file for [country]/[city], e.g. `'iran'`,
  /// `'tehran'` for `data/iran/tehran.json`.
  Future<TransitCityData> loadCity({
    required String country,
    required String city,
  }) async {
    final raw = await rootBundle.loadString('data/$country/$city.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return TransitCityData.fromJson(json);
  }
}
