// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StationAccessibilityImpl _$$StationAccessibilityImplFromJson(
  Map<String, dynamic> json,
) => _$StationAccessibilityImpl(
  elevator: json['elevator'] as bool? ?? false,
  ramp: json['ramp'] as bool? ?? false,
  tactilePaving: json['tactilePaving'] as bool? ?? false,
  accessibleRestroom: json['accessibleRestroom'] as bool? ?? false,
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$$StationAccessibilityImplToJson(
  _$StationAccessibilityImpl instance,
) => <String, dynamic>{
  'elevator': instance.elevator,
  'ramp': instance.ramp,
  'tactilePaving': instance.tactilePaving,
  'accessibleRestroom': instance.accessibleRestroom,
  'notes': instance.notes,
};

_$StationEntranceImpl _$$StationEntranceImplFromJson(
  Map<String, dynamic> json,
) => _$StationEntranceImpl(
  name: (json['name'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  lat: (json['lat'] as num).toDouble(),
  lng: (json['lng'] as num).toDouble(),
  wheelchairAccessible: json['wheelchairAccessible'] as bool?,
);

Map<String, dynamic> _$$StationEntranceImplToJson(
  _$StationEntranceImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'lat': instance.lat,
  'lng': instance.lng,
  'wheelchairAccessible': instance.wheelchairAccessible,
};

_$StationImpl _$$StationImplFromJson(Map<String, dynamic> json) =>
    _$StationImpl(
      id: json['id'] as String,
      name: Map<String, String>.from(json['name'] as Map),
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      lineIds: (json['lineIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      accessibility: json['accessibility'] == null
          ? null
          : StationAccessibility.fromJson(
              json['accessibility'] as Map<String, dynamic>,
            ),
      entrances: (json['entrances'] as List<dynamic>?)
          ?.map((e) => StationEntrance.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$StationImplToJson(_$StationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lat': instance.lat,
      'lng': instance.lng,
      'lineIds': instance.lineIds,
      'accessibility': instance.accessibility,
      'entrances': instance.entrances,
    };
