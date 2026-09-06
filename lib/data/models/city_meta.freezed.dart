// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'city_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DataSource _$DataSourceFromJson(Map<String, dynamic> json) {
  return _DataSource.fromJson(json);
}

/// @nodoc
mixin _$DataSource {
  SourceType get type => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this DataSource to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DataSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DataSourceCopyWith<DataSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataSourceCopyWith<$Res> {
  factory $DataSourceCopyWith(
    DataSource value,
    $Res Function(DataSource) then,
  ) = _$DataSourceCopyWithImpl<$Res, DataSource>;
  @useResult
  $Res call({SourceType type, String? url, String? note});
}

/// @nodoc
class _$DataSourceCopyWithImpl<$Res, $Val extends DataSource>
    implements $DataSourceCopyWith<$Res> {
  _$DataSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DataSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? url = freezed,
    Object? note = freezed,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as SourceType,
            url: freezed == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String?,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DataSourceImplCopyWith<$Res>
    implements $DataSourceCopyWith<$Res> {
  factory _$$DataSourceImplCopyWith(
    _$DataSourceImpl value,
    $Res Function(_$DataSourceImpl) then,
  ) = __$$DataSourceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SourceType type, String? url, String? note});
}

/// @nodoc
class __$$DataSourceImplCopyWithImpl<$Res>
    extends _$DataSourceCopyWithImpl<$Res, _$DataSourceImpl>
    implements _$$DataSourceImplCopyWith<$Res> {
  __$$DataSourceImplCopyWithImpl(
    _$DataSourceImpl _value,
    $Res Function(_$DataSourceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DataSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? url = freezed,
    Object? note = freezed,
  }) {
    return _then(
      _$DataSourceImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as SourceType,
        url: freezed == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String?,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DataSourceImpl implements _DataSource {
  const _$DataSourceImpl({required this.type, this.url, this.note});

  factory _$DataSourceImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataSourceImplFromJson(json);

  @override
  final SourceType type;
  @override
  final String? url;
  @override
  final String? note;

  @override
  String toString() {
    return 'DataSource(type: $type, url: $url, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataSourceImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, url, note);

  /// Create a copy of DataSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DataSourceImplCopyWith<_$DataSourceImpl> get copyWith =>
      __$$DataSourceImplCopyWithImpl<_$DataSourceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataSourceImplToJson(this);
  }
}

abstract class _DataSource implements DataSource {
  const factory _DataSource({
    required final SourceType type,
    final String? url,
    final String? note,
  }) = _$DataSourceImpl;

  factory _DataSource.fromJson(Map<String, dynamic> json) =
      _$DataSourceImpl.fromJson;

  @override
  SourceType get type;
  @override
  String? get url;
  @override
  String? get note;

  /// Create a copy of DataSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DataSourceImplCopyWith<_$DataSourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CityMeta _$CityMetaFromJson(Map<String, dynamic> json) {
  return _CityMeta.fromJson(json);
}

/// @nodoc
mixin _$CityMeta {
  String get country => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get dataVersion => throw _privateConstructorUsedError;
  String get lastUpdated => throw _privateConstructorUsedError;
  List<DataSource>? get source => throw _privateConstructorUsedError;

  /// Serializes this CityMeta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CityMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CityMetaCopyWith<CityMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CityMetaCopyWith<$Res> {
  factory $CityMetaCopyWith(CityMeta value, $Res Function(CityMeta) then) =
      _$CityMetaCopyWithImpl<$Res, CityMeta>;
  @useResult
  $Res call({
    String country,
    String city,
    String dataVersion,
    String lastUpdated,
    List<DataSource>? source,
  });
}

/// @nodoc
class _$CityMetaCopyWithImpl<$Res, $Val extends CityMeta>
    implements $CityMetaCopyWith<$Res> {
  _$CityMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CityMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? country = null,
    Object? city = null,
    Object? dataVersion = null,
    Object? lastUpdated = null,
    Object? source = freezed,
  }) {
    return _then(
      _value.copyWith(
            country: null == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String,
            city: null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String,
            dataVersion: null == dataVersion
                ? _value.dataVersion
                : dataVersion // ignore: cast_nullable_to_non_nullable
                      as String,
            lastUpdated: null == lastUpdated
                ? _value.lastUpdated
                : lastUpdated // ignore: cast_nullable_to_non_nullable
                      as String,
            source: freezed == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as List<DataSource>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CityMetaImplCopyWith<$Res>
    implements $CityMetaCopyWith<$Res> {
  factory _$$CityMetaImplCopyWith(
    _$CityMetaImpl value,
    $Res Function(_$CityMetaImpl) then,
  ) = __$$CityMetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String country,
    String city,
    String dataVersion,
    String lastUpdated,
    List<DataSource>? source,
  });
}

/// @nodoc
class __$$CityMetaImplCopyWithImpl<$Res>
    extends _$CityMetaCopyWithImpl<$Res, _$CityMetaImpl>
    implements _$$CityMetaImplCopyWith<$Res> {
  __$$CityMetaImplCopyWithImpl(
    _$CityMetaImpl _value,
    $Res Function(_$CityMetaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CityMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? country = null,
    Object? city = null,
    Object? dataVersion = null,
    Object? lastUpdated = null,
    Object? source = freezed,
  }) {
    return _then(
      _$CityMetaImpl(
        country: null == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String,
        city: null == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String,
        dataVersion: null == dataVersion
            ? _value.dataVersion
            : dataVersion // ignore: cast_nullable_to_non_nullable
                  as String,
        lastUpdated: null == lastUpdated
            ? _value.lastUpdated
            : lastUpdated // ignore: cast_nullable_to_non_nullable
                  as String,
        source: freezed == source
            ? _value._source
            : source // ignore: cast_nullable_to_non_nullable
                  as List<DataSource>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CityMetaImpl implements _CityMeta {
  const _$CityMetaImpl({
    required this.country,
    required this.city,
    required this.dataVersion,
    required this.lastUpdated,
    final List<DataSource>? source,
  }) : _source = source;

  factory _$CityMetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$CityMetaImplFromJson(json);

  @override
  final String country;
  @override
  final String city;
  @override
  final String dataVersion;
  @override
  final String lastUpdated;
  final List<DataSource>? _source;
  @override
  List<DataSource>? get source {
    final value = _source;
    if (value == null) return null;
    if (_source is EqualUnmodifiableListView) return _source;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CityMeta(country: $country, city: $city, dataVersion: $dataVersion, lastUpdated: $lastUpdated, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CityMetaImpl &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.dataVersion, dataVersion) ||
                other.dataVersion == dataVersion) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            const DeepCollectionEquality().equals(other._source, _source));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    country,
    city,
    dataVersion,
    lastUpdated,
    const DeepCollectionEquality().hash(_source),
  );

  /// Create a copy of CityMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CityMetaImplCopyWith<_$CityMetaImpl> get copyWith =>
      __$$CityMetaImplCopyWithImpl<_$CityMetaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CityMetaImplToJson(this);
  }
}

abstract class _CityMeta implements CityMeta {
  const factory _CityMeta({
    required final String country,
    required final String city,
    required final String dataVersion,
    required final String lastUpdated,
    final List<DataSource>? source,
  }) = _$CityMetaImpl;

  factory _CityMeta.fromJson(Map<String, dynamic> json) =
      _$CityMetaImpl.fromJson;

  @override
  String get country;
  @override
  String get city;
  @override
  String get dataVersion;
  @override
  String get lastUpdated;
  @override
  List<DataSource>? get source;

  /// Create a copy of CityMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CityMetaImplCopyWith<_$CityMetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
