// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transit_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OperatingHoursImpl _$$OperatingHoursImplFromJson(Map<String, dynamic> json) =>
    _$OperatingHoursImpl(
      firstTrain: json['firstTrain'] as String?,
      lastTrain: json['lastTrain'] as String?,
    );

Map<String, dynamic> _$$OperatingHoursImplToJson(
  _$OperatingHoursImpl instance,
) => <String, dynamic>{
  'firstTrain': instance.firstTrain,
  'lastTrain': instance.lastTrain,
};

_$TransitLineImpl _$$TransitLineImplFromJson(Map<String, dynamic> json) =>
    _$TransitLineImpl(
      id: json['id'] as String,
      name: Map<String, String>.from(json['name'] as Map),
      shortName: json['shortName'] as String?,
      color: json['color'] as String,
      transportType: $enumDecode(_$TransportTypeEnumMap, json['transportType']),
      stationIds: (json['stationIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      operatingHours: json['operatingHours'] == null
          ? null
          : OperatingHours.fromJson(
              json['operatingHours'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$$TransitLineImplToJson(_$TransitLineImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shortName': instance.shortName,
      'color': instance.color,
      'transportType': _$TransportTypeEnumMap[instance.transportType]!,
      'stationIds': instance.stationIds,
      'operatingHours': instance.operatingHours,
    };

const _$TransportTypeEnumMap = {
  TransportType.metro: 'metro',
  TransportType.bus: 'bus',
  TransportType.tram: 'tram',
  TransportType.brt: 'brt',
  TransportType.commuterRail: 'commuter_rail',
  TransportType.other: 'other',
};
