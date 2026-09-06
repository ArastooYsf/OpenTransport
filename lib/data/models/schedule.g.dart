// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CalendarExceptionImpl _$$CalendarExceptionImplFromJson(
  Map<String, dynamic> json,
) => _$CalendarExceptionImpl(
  date: json['date'] as String,
  type: $enumDecode(_$CalendarExceptionTypeEnumMap, json['type']),
);

Map<String, dynamic> _$$CalendarExceptionImplToJson(
  _$CalendarExceptionImpl instance,
) => <String, dynamic>{
  'date': instance.date,
  'type': _$CalendarExceptionTypeEnumMap[instance.type]!,
};

const _$CalendarExceptionTypeEnumMap = {
  CalendarExceptionType.added: 'added',
  CalendarExceptionType.removed: 'removed',
};

_$CalendarEntryImpl _$$CalendarEntryImplFromJson(Map<String, dynamic> json) =>
    _$CalendarEntryImpl(
      id: json['id'] as String,
      daysOfWeek: (json['daysOfWeek'] as List<dynamic>)
          .map((e) => $enumDecode(_$DayOfWeekEnumMap, e))
          .toList(),
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      exceptions: (json['exceptions'] as List<dynamic>?)
          ?.map((e) => CalendarException.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CalendarEntryImplToJson(
  _$CalendarEntryImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'daysOfWeek': instance.daysOfWeek.map((e) => _$DayOfWeekEnumMap[e]!).toList(),
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'exceptions': instance.exceptions,
};

const _$DayOfWeekEnumMap = {
  DayOfWeek.monday: 'mon',
  DayOfWeek.tuesday: 'tue',
  DayOfWeek.wednesday: 'wed',
  DayOfWeek.thursday: 'thu',
  DayOfWeek.friday: 'fri',
  DayOfWeek.saturday: 'sat',
  DayOfWeek.sunday: 'sun',
};

_$TripImpl _$$TripImplFromJson(Map<String, dynamic> json) => _$TripImpl(
  id: json['id'] as String,
  lineId: json['lineId'] as String,
  direction: (json['direction'] as num).toInt(),
  calendarId: json['calendarId'] as String,
);

Map<String, dynamic> _$$TripImplToJson(_$TripImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lineId': instance.lineId,
      'direction': instance.direction,
      'calendarId': instance.calendarId,
    };

_$StopTimeImpl _$$StopTimeImplFromJson(Map<String, dynamic> json) =>
    _$StopTimeImpl(
      tripId: json['tripId'] as String,
      stationId: json['stationId'] as String,
      arrivalTime: json['arrivalTime'] as String,
      departureTime: json['departureTime'] as String?,
      stopSequence: (json['stopSequence'] as num).toInt(),
    );

Map<String, dynamic> _$$StopTimeImplToJson(_$StopTimeImpl instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'stationId': instance.stationId,
      'arrivalTime': instance.arrivalTime,
      'departureTime': instance.departureTime,
      'stopSequence': instance.stopSequence,
    };
