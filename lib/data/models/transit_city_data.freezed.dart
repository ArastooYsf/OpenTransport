// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transit_city_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TransitCityData _$TransitCityDataFromJson(Map<String, dynamic> json) {
  return _TransitCityData.fromJson(json);
}

/// @nodoc
mixin _$TransitCityData {
  CityMeta get meta => throw _privateConstructorUsedError;
  Map<String, String>? get localizedText => throw _privateConstructorUsedError;
  List<TransitLine> get lines => throw _privateConstructorUsedError;
  List<Station> get stations => throw _privateConstructorUsedError;
  List<CalendarEntry> get calendar => throw _privateConstructorUsedError;
  List<Trip> get trips => throw _privateConstructorUsedError;
  List<StopTime> get stopTimes => throw _privateConstructorUsedError;

  /// Serializes this TransitCityData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransitCityData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransitCityDataCopyWith<TransitCityData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransitCityDataCopyWith<$Res> {
  factory $TransitCityDataCopyWith(
    TransitCityData value,
    $Res Function(TransitCityData) then,
  ) = _$TransitCityDataCopyWithImpl<$Res, TransitCityData>;
  @useResult
  $Res call({
    CityMeta meta,
    Map<String, String>? localizedText,
    List<TransitLine> lines,
    List<Station> stations,
    List<CalendarEntry> calendar,
    List<Trip> trips,
    List<StopTime> stopTimes,
  });

  $CityMetaCopyWith<$Res> get meta;
}

/// @nodoc
class _$TransitCityDataCopyWithImpl<$Res, $Val extends TransitCityData>
    implements $TransitCityDataCopyWith<$Res> {
  _$TransitCityDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransitCityData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meta = null,
    Object? localizedText = freezed,
    Object? lines = null,
    Object? stations = null,
    Object? calendar = null,
    Object? trips = null,
    Object? stopTimes = null,
  }) {
    return _then(
      _value.copyWith(
            meta: null == meta
                ? _value.meta
                : meta // ignore: cast_nullable_to_non_nullable
                      as CityMeta,
            localizedText: freezed == localizedText
                ? _value.localizedText
                : localizedText // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>?,
            lines: null == lines
                ? _value.lines
                : lines // ignore: cast_nullable_to_non_nullable
                      as List<TransitLine>,
            stations: null == stations
                ? _value.stations
                : stations // ignore: cast_nullable_to_non_nullable
                      as List<Station>,
            calendar: null == calendar
                ? _value.calendar
                : calendar // ignore: cast_nullable_to_non_nullable
                      as List<CalendarEntry>,
            trips: null == trips
                ? _value.trips
                : trips // ignore: cast_nullable_to_non_nullable
                      as List<Trip>,
            stopTimes: null == stopTimes
                ? _value.stopTimes
                : stopTimes // ignore: cast_nullable_to_non_nullable
                      as List<StopTime>,
          )
          as $Val,
    );
  }

  /// Create a copy of TransitCityData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CityMetaCopyWith<$Res> get meta {
    return $CityMetaCopyWith<$Res>(_value.meta, (value) {
      return _then(_value.copyWith(meta: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TransitCityDataImplCopyWith<$Res>
    implements $TransitCityDataCopyWith<$Res> {
  factory _$$TransitCityDataImplCopyWith(
    _$TransitCityDataImpl value,
    $Res Function(_$TransitCityDataImpl) then,
  ) = __$$TransitCityDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    CityMeta meta,
    Map<String, String>? localizedText,
    List<TransitLine> lines,
    List<Station> stations,
    List<CalendarEntry> calendar,
    List<Trip> trips,
    List<StopTime> stopTimes,
  });

  @override
  $CityMetaCopyWith<$Res> get meta;
}

/// @nodoc
class __$$TransitCityDataImplCopyWithImpl<$Res>
    extends _$TransitCityDataCopyWithImpl<$Res, _$TransitCityDataImpl>
    implements _$$TransitCityDataImplCopyWith<$Res> {
  __$$TransitCityDataImplCopyWithImpl(
    _$TransitCityDataImpl _value,
    $Res Function(_$TransitCityDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransitCityData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meta = null,
    Object? localizedText = freezed,
    Object? lines = null,
    Object? stations = null,
    Object? calendar = null,
    Object? trips = null,
    Object? stopTimes = null,
  }) {
    return _then(
      _$TransitCityDataImpl(
        meta: null == meta
            ? _value.meta
            : meta // ignore: cast_nullable_to_non_nullable
                  as CityMeta,
        localizedText: freezed == localizedText
            ? _value._localizedText
            : localizedText // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>?,
        lines: null == lines
            ? _value._lines
            : lines // ignore: cast_nullable_to_non_nullable
                  as List<TransitLine>,
        stations: null == stations
            ? _value._stations
            : stations // ignore: cast_nullable_to_non_nullable
                  as List<Station>,
        calendar: null == calendar
            ? _value._calendar
            : calendar // ignore: cast_nullable_to_non_nullable
                  as List<CalendarEntry>,
        trips: null == trips
            ? _value._trips
            : trips // ignore: cast_nullable_to_non_nullable
                  as List<Trip>,
        stopTimes: null == stopTimes
            ? _value._stopTimes
            : stopTimes // ignore: cast_nullable_to_non_nullable
                  as List<StopTime>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TransitCityDataImpl implements _TransitCityData {
  const _$TransitCityDataImpl({
    required this.meta,
    final Map<String, String>? localizedText,
    required final List<TransitLine> lines,
    required final List<Station> stations,
    required final List<CalendarEntry> calendar,
    required final List<Trip> trips,
    required final List<StopTime> stopTimes,
  }) : _localizedText = localizedText,
       _lines = lines,
       _stations = stations,
       _calendar = calendar,
       _trips = trips,
       _stopTimes = stopTimes;

  factory _$TransitCityDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransitCityDataImplFromJson(json);

  @override
  final CityMeta meta;
  final Map<String, String>? _localizedText;
  @override
  Map<String, String>? get localizedText {
    final value = _localizedText;
    if (value == null) return null;
    if (_localizedText is EqualUnmodifiableMapView) return _localizedText;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<TransitLine> _lines;
  @override
  List<TransitLine> get lines {
    if (_lines is EqualUnmodifiableListView) return _lines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lines);
  }

  final List<Station> _stations;
  @override
  List<Station> get stations {
    if (_stations is EqualUnmodifiableListView) return _stations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stations);
  }

  final List<CalendarEntry> _calendar;
  @override
  List<CalendarEntry> get calendar {
    if (_calendar is EqualUnmodifiableListView) return _calendar;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_calendar);
  }

  final List<Trip> _trips;
  @override
  List<Trip> get trips {
    if (_trips is EqualUnmodifiableListView) return _trips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trips);
  }

  final List<StopTime> _stopTimes;
  @override
  List<StopTime> get stopTimes {
    if (_stopTimes is EqualUnmodifiableListView) return _stopTimes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stopTimes);
  }

  @override
  String toString() {
    return 'TransitCityData(meta: $meta, localizedText: $localizedText, lines: $lines, stations: $stations, calendar: $calendar, trips: $trips, stopTimes: $stopTimes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransitCityDataImpl &&
            (identical(other.meta, meta) || other.meta == meta) &&
            const DeepCollectionEquality().equals(
              other._localizedText,
              _localizedText,
            ) &&
            const DeepCollectionEquality().equals(other._lines, _lines) &&
            const DeepCollectionEquality().equals(other._stations, _stations) &&
            const DeepCollectionEquality().equals(other._calendar, _calendar) &&
            const DeepCollectionEquality().equals(other._trips, _trips) &&
            const DeepCollectionEquality().equals(
              other._stopTimes,
              _stopTimes,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    meta,
    const DeepCollectionEquality().hash(_localizedText),
    const DeepCollectionEquality().hash(_lines),
    const DeepCollectionEquality().hash(_stations),
    const DeepCollectionEquality().hash(_calendar),
    const DeepCollectionEquality().hash(_trips),
    const DeepCollectionEquality().hash(_stopTimes),
  );

  /// Create a copy of TransitCityData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransitCityDataImplCopyWith<_$TransitCityDataImpl> get copyWith =>
      __$$TransitCityDataImplCopyWithImpl<_$TransitCityDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TransitCityDataImplToJson(this);
  }
}

abstract class _TransitCityData implements TransitCityData {
  const factory _TransitCityData({
    required final CityMeta meta,
    final Map<String, String>? localizedText,
    required final List<TransitLine> lines,
    required final List<Station> stations,
    required final List<CalendarEntry> calendar,
    required final List<Trip> trips,
    required final List<StopTime> stopTimes,
  }) = _$TransitCityDataImpl;

  factory _TransitCityData.fromJson(Map<String, dynamic> json) =
      _$TransitCityDataImpl.fromJson;

  @override
  CityMeta get meta;
  @override
  Map<String, String>? get localizedText;
  @override
  List<TransitLine> get lines;
  @override
  List<Station> get stations;
  @override
  List<CalendarEntry> get calendar;
  @override
  List<Trip> get trips;
  @override
  List<StopTime> get stopTimes;

  /// Create a copy of TransitCityData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransitCityDataImplCopyWith<_$TransitCityDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
