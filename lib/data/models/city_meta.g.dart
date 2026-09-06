// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DataSourceImpl _$$DataSourceImplFromJson(Map<String, dynamic> json) =>
    _$DataSourceImpl(
      type: $enumDecode(_$SourceTypeEnumMap, json['type']),
      url: json['url'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$DataSourceImplToJson(_$DataSourceImpl instance) =>
    <String, dynamic>{
      'type': _$SourceTypeEnumMap[instance.type]!,
      'url': instance.url,
      'note': instance.note,
    };

const _$SourceTypeEnumMap = {
  SourceType.osm: 'osm',
  SourceType.officialGtfs: 'official_gtfs',
  SourceType.officialOther: 'official_other',
  SourceType.communitySurvey: 'community_survey',
  SourceType.other: 'other',
};

_$CityMetaImpl _$$CityMetaImplFromJson(Map<String, dynamic> json) =>
    _$CityMetaImpl(
      country: json['country'] as String,
      city: json['city'] as String,
      dataVersion: json['dataVersion'] as String,
      lastUpdated: json['lastUpdated'] as String,
      source: (json['source'] as List<dynamic>?)
          ?.map((e) => DataSource.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CityMetaImplToJson(_$CityMetaImpl instance) =>
    <String, dynamic>{
      'country': instance.country,
      'city': instance.city,
      'dataVersion': instance.dataVersion,
      'lastUpdated': instance.lastUpdated,
      'source': instance.source,
    };
