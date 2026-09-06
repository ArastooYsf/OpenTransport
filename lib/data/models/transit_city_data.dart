import 'package:freezed_annotation/freezed_annotation.dart';

import 'city_meta.dart';
import 'schedule.dart';
import 'station.dart';
import 'transit_line.dart';

part 'transit_city_data.freezed.dart';
part 'transit_city_data.g.dart';

/// The full contents of one `/data/<country>/<city>.json` file.
///
/// Mirrors schema.json exactly — see that file for the authoritative shape.
@freezed
class TransitCityData with _$TransitCityData {
  const factory TransitCityData({
    required CityMeta meta,
    Map<String, String>? localizedText,
    required List<TransitLine> lines,
    required List<Station> stations,
    required List<CalendarEntry> calendar,
    required List<Trip> trips,
    required List<StopTime> stopTimes,
  }) = _TransitCityData;

  factory TransitCityData.fromJson(Map<String, dynamic> json) =>
      _$TransitCityDataFromJson(json);
}
