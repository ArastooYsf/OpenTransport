import 'package:freezed_annotation/freezed_annotation.dart';

part 'station.freezed.dart';
part 'station.g.dart';

@freezed
class StationAccessibility with _$StationAccessibility {
  const factory StationAccessibility({
    @Default(false) bool elevator,
    @Default(false) bool ramp,
    @Default(false) bool tactilePaving,
    @Default(false) bool accessibleRestroom,
    String? notes,
  }) = _StationAccessibility;

  factory StationAccessibility.fromJson(Map<String, dynamic> json) =>
      _$StationAccessibilityFromJson(json);
}

@freezed
class StationEntrance with _$StationEntrance {
  const factory StationEntrance({
    Map<String, String>? name,
    required double lat,
    required double lng,
    bool? wheelchairAccessible,
  }) = _StationEntrance;

  factory StationEntrance.fromJson(Map<String, dynamic> json) =>
      _$StationEntranceFromJson(json);
}

/// A single transit station, as defined in schema.json.
///
/// [lineIds] with more than one entry means the station is an interchange.
@freezed
class Station with _$Station {
  const factory Station({
    required String id,
    required Map<String, String> name,
    required double lat,
    required double lng,
    required List<String> lineIds,
    StationAccessibility? accessibility,
    List<StationEntrance>? entrances,
  }) = _Station;

  factory Station.fromJson(Map<String, dynamic> json) =>
      _$StationFromJson(json);
}
