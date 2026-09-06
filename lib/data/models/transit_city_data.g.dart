// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transit_city_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransitCityDataImpl _$$TransitCityDataImplFromJson(
  Map<String, dynamic> json,
) => _$TransitCityDataImpl(
  meta: CityMeta.fromJson(json['meta'] as Map<String, dynamic>),
  localizedText: (json['localizedText'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  lines: (json['lines'] as List<dynamic>)
      .map((e) => TransitLine.fromJson(e as Map<String, dynamic>))
      .toList(),
  stations: (json['stations'] as List<dynamic>)
      .map((e) => Station.fromJson(e as Map<String, dynamic>))
      .toList(),
  calendar: (json['calendar'] as List<dynamic>)
      .map((e) => CalendarEntry.fromJson(e as Map<String, dynamic>))
      .toList(),
  trips: (json['trips'] as List<dynamic>)
      .map((e) => Trip.fromJson(e as Map<String, dynamic>))
      .toList(),
  stopTimes: (json['stopTimes'] as List<dynamic>)
      .map((e) => StopTime.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$TransitCityDataImplToJson(
  _$TransitCityDataImpl instance,
) => <String, dynamic>{
  'meta': instance.meta,
  'localizedText': instance.localizedText,
  'lines': instance.lines,
  'stations': instance.stations,
  'calendar': instance.calendar,
  'trips': instance.trips,
  'stopTimes': instance.stopTimes,
};
