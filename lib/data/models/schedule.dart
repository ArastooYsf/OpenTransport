import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule.freezed.dart';
part 'schedule.g.dart';

enum DayOfWeek {
  @JsonValue('mon')
  monday,
  @JsonValue('tue')
  tuesday,
  @JsonValue('wed')
  wednesday,
  @JsonValue('thu')
  thursday,
  @JsonValue('fri')
  friday,
  @JsonValue('sat')
  saturday,
  @JsonValue('sun')
  sunday,
}

enum CalendarExceptionType { added, removed }

@freezed
class CalendarException with _$CalendarException {
  const factory CalendarException({
    required String date,
    required CalendarExceptionType type,
  }) = _CalendarException;

  factory CalendarException.fromJson(Map<String, dynamic> json) =>
      _$CalendarExceptionFromJson(json);
}

/// A GTFS-style service pattern — which days a set of trips runs on.
@freezed
class CalendarEntry with _$CalendarEntry {
  const factory CalendarEntry({
    required String id,
    required List<DayOfWeek> daysOfWeek,
    String? startDate,
    String? endDate,
    List<CalendarException>? exceptions,
  }) = _CalendarEntry;

  factory CalendarEntry.fromJson(Map<String, dynamic> json) =>
      _$CalendarEntryFromJson(json);
}

/// One train's run along a line in one direction, tied to a [CalendarEntry].
@freezed
class Trip with _$Trip {
  const factory Trip({
    required String id,
    required String lineId,
    required int direction,
    required String calendarId,
  }) = _Trip;

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);
}

/// A per-station arrival/departure entry for a [Trip] — the full timetable.
@freezed
class StopTime with _$StopTime {
  const factory StopTime({
    required String tripId,
    required String stationId,
    required String arrivalTime,
    String? departureTime,
    required int stopSequence,
  }) = _StopTime;

  factory StopTime.fromJson(Map<String, dynamic> json) =>
      _$StopTimeFromJson(json);
}
