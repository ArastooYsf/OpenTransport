import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_meta.freezed.dart';
part 'city_meta.g.dart';

enum SourceType {
  osm,
  @JsonValue('official_gtfs')
  officialGtfs,
  @JsonValue('official_other')
  officialOther,
  @JsonValue('community_survey')
  communitySurvey,
  other,
}

@freezed
class DataSource with _$DataSource {
  const factory DataSource({
    required SourceType type,
    String? url,
    String? note,
  }) = _DataSource;

  factory DataSource.fromJson(Map<String, dynamic> json) =>
      _$DataSourceFromJson(json);
}

/// Provenance and versioning info for one city's data file.
@freezed
class CityMeta with _$CityMeta {
  const factory CityMeta({
    required String country,
    required String city,
    required String dataVersion,
    required String lastUpdated,
    List<DataSource>? source,
  }) = _CityMeta;

  factory CityMeta.fromJson(Map<String, dynamic> json) =>
      _$CityMetaFromJson(json);
}
