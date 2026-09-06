import 'package:freezed_annotation/freezed_annotation.dart';

part 'transit_line.freezed.dart';
part 'transit_line.g.dart';

/// The transport modes a [TransitLine] can represent.
///
/// Kept generic on purpose (see schema.json) so bus/tram/BRT can be added
/// later without changing this model.
enum TransportType {
  metro,
  bus,
  tram,
  brt,
  @JsonValue('commuter_rail')
  commuterRail,
  other,
}

@freezed
class OperatingHours with _$OperatingHours {
  const factory OperatingHours({String? firstTrain, String? lastTrain}) =
      _OperatingHours;

  factory OperatingHours.fromJson(Map<String, dynamic> json) =>
      _$OperatingHoursFromJson(json);
}

/// One transit line (e.g. a metro line), as defined in schema.json.
@freezed
class TransitLine with _$TransitLine {
  const factory TransitLine({
    required String id,
    required Map<String, String> name,
    String? shortName,
    required String color,
    required TransportType transportType,
    required List<String> stationIds,
    OperatingHours? operatingHours,
  }) = _TransitLine;

  factory TransitLine.fromJson(Map<String, dynamic> json) =>
      _$TransitLineFromJson(json);
}
