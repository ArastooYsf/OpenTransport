// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transit_line.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OperatingHours _$OperatingHoursFromJson(Map<String, dynamic> json) {
  return _OperatingHours.fromJson(json);
}

/// @nodoc
mixin _$OperatingHours {
  String? get firstTrain => throw _privateConstructorUsedError;
  String? get lastTrain => throw _privateConstructorUsedError;

  /// Serializes this OperatingHours to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OperatingHours
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OperatingHoursCopyWith<OperatingHours> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OperatingHoursCopyWith<$Res> {
  factory $OperatingHoursCopyWith(
    OperatingHours value,
    $Res Function(OperatingHours) then,
  ) = _$OperatingHoursCopyWithImpl<$Res, OperatingHours>;
  @useResult
  $Res call({String? firstTrain, String? lastTrain});
}

/// @nodoc
class _$OperatingHoursCopyWithImpl<$Res, $Val extends OperatingHours>
    implements $OperatingHoursCopyWith<$Res> {
  _$OperatingHoursCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OperatingHours
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? firstTrain = freezed, Object? lastTrain = freezed}) {
    return _then(
      _value.copyWith(
            firstTrain: freezed == firstTrain
                ? _value.firstTrain
                : firstTrain // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastTrain: freezed == lastTrain
                ? _value.lastTrain
                : lastTrain // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OperatingHoursImplCopyWith<$Res>
    implements $OperatingHoursCopyWith<$Res> {
  factory _$$OperatingHoursImplCopyWith(
    _$OperatingHoursImpl value,
    $Res Function(_$OperatingHoursImpl) then,
  ) = __$$OperatingHoursImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? firstTrain, String? lastTrain});
}

/// @nodoc
class __$$OperatingHoursImplCopyWithImpl<$Res>
    extends _$OperatingHoursCopyWithImpl<$Res, _$OperatingHoursImpl>
    implements _$$OperatingHoursImplCopyWith<$Res> {
  __$$OperatingHoursImplCopyWithImpl(
    _$OperatingHoursImpl _value,
    $Res Function(_$OperatingHoursImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OperatingHours
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? firstTrain = freezed, Object? lastTrain = freezed}) {
    return _then(
      _$OperatingHoursImpl(
        firstTrain: freezed == firstTrain
            ? _value.firstTrain
            : firstTrain // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastTrain: freezed == lastTrain
            ? _value.lastTrain
            : lastTrain // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OperatingHoursImpl implements _OperatingHours {
  const _$OperatingHoursImpl({this.firstTrain, this.lastTrain});

  factory _$OperatingHoursImpl.fromJson(Map<String, dynamic> json) =>
      _$$OperatingHoursImplFromJson(json);

  @override
  final String? firstTrain;
  @override
  final String? lastTrain;

  @override
  String toString() {
    return 'OperatingHours(firstTrain: $firstTrain, lastTrain: $lastTrain)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OperatingHoursImpl &&
            (identical(other.firstTrain, firstTrain) ||
                other.firstTrain == firstTrain) &&
            (identical(other.lastTrain, lastTrain) ||
                other.lastTrain == lastTrain));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, firstTrain, lastTrain);

  /// Create a copy of OperatingHours
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OperatingHoursImplCopyWith<_$OperatingHoursImpl> get copyWith =>
      __$$OperatingHoursImplCopyWithImpl<_$OperatingHoursImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OperatingHoursImplToJson(this);
  }
}

abstract class _OperatingHours implements OperatingHours {
  const factory _OperatingHours({
    final String? firstTrain,
    final String? lastTrain,
  }) = _$OperatingHoursImpl;

  factory _OperatingHours.fromJson(Map<String, dynamic> json) =
      _$OperatingHoursImpl.fromJson;

  @override
  String? get firstTrain;
  @override
  String? get lastTrain;

  /// Create a copy of OperatingHours
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OperatingHoursImplCopyWith<_$OperatingHoursImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TransitLine _$TransitLineFromJson(Map<String, dynamic> json) {
  return _TransitLine.fromJson(json);
}

/// @nodoc
mixin _$TransitLine {
  String get id => throw _privateConstructorUsedError;
  Map<String, String> get name => throw _privateConstructorUsedError;
  String? get shortName => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  TransportType get transportType => throw _privateConstructorUsedError;
  List<String> get stationIds => throw _privateConstructorUsedError;
  OperatingHours? get operatingHours => throw _privateConstructorUsedError;

  /// Serializes this TransitLine to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransitLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransitLineCopyWith<TransitLine> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransitLineCopyWith<$Res> {
  factory $TransitLineCopyWith(
    TransitLine value,
    $Res Function(TransitLine) then,
  ) = _$TransitLineCopyWithImpl<$Res, TransitLine>;
  @useResult
  $Res call({
    String id,
    Map<String, String> name,
    String? shortName,
    String color,
    TransportType transportType,
    List<String> stationIds,
    OperatingHours? operatingHours,
  });

  $OperatingHoursCopyWith<$Res>? get operatingHours;
}

/// @nodoc
class _$TransitLineCopyWithImpl<$Res, $Val extends TransitLine>
    implements $TransitLineCopyWith<$Res> {
  _$TransitLineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransitLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? shortName = freezed,
    Object? color = null,
    Object? transportType = null,
    Object? stationIds = null,
    Object? operatingHours = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
            shortName: freezed == shortName
                ? _value.shortName
                : shortName // ignore: cast_nullable_to_non_nullable
                      as String?,
            color: null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String,
            transportType: null == transportType
                ? _value.transportType
                : transportType // ignore: cast_nullable_to_non_nullable
                      as TransportType,
            stationIds: null == stationIds
                ? _value.stationIds
                : stationIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            operatingHours: freezed == operatingHours
                ? _value.operatingHours
                : operatingHours // ignore: cast_nullable_to_non_nullable
                      as OperatingHours?,
          )
          as $Val,
    );
  }

  /// Create a copy of TransitLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OperatingHoursCopyWith<$Res>? get operatingHours {
    if (_value.operatingHours == null) {
      return null;
    }

    return $OperatingHoursCopyWith<$Res>(_value.operatingHours!, (value) {
      return _then(_value.copyWith(operatingHours: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TransitLineImplCopyWith<$Res>
    implements $TransitLineCopyWith<$Res> {
  factory _$$TransitLineImplCopyWith(
    _$TransitLineImpl value,
    $Res Function(_$TransitLineImpl) then,
  ) = __$$TransitLineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    Map<String, String> name,
    String? shortName,
    String color,
    TransportType transportType,
    List<String> stationIds,
    OperatingHours? operatingHours,
  });

  @override
  $OperatingHoursCopyWith<$Res>? get operatingHours;
}

/// @nodoc
class __$$TransitLineImplCopyWithImpl<$Res>
    extends _$TransitLineCopyWithImpl<$Res, _$TransitLineImpl>
    implements _$$TransitLineImplCopyWith<$Res> {
  __$$TransitLineImplCopyWithImpl(
    _$TransitLineImpl _value,
    $Res Function(_$TransitLineImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransitLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? shortName = freezed,
    Object? color = null,
    Object? transportType = null,
    Object? stationIds = null,
    Object? operatingHours = freezed,
  }) {
    return _then(
      _$TransitLineImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value._name
            : name // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
        shortName: freezed == shortName
            ? _value.shortName
            : shortName // ignore: cast_nullable_to_non_nullable
                  as String?,
        color: null == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String,
        transportType: null == transportType
            ? _value.transportType
            : transportType // ignore: cast_nullable_to_non_nullable
                  as TransportType,
        stationIds: null == stationIds
            ? _value._stationIds
            : stationIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        operatingHours: freezed == operatingHours
            ? _value.operatingHours
            : operatingHours // ignore: cast_nullable_to_non_nullable
                  as OperatingHours?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TransitLineImpl implements _TransitLine {
  const _$TransitLineImpl({
    required this.id,
    required final Map<String, String> name,
    this.shortName,
    required this.color,
    required this.transportType,
    required final List<String> stationIds,
    this.operatingHours,
  }) : _name = name,
       _stationIds = stationIds;

  factory _$TransitLineImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransitLineImplFromJson(json);

  @override
  final String id;
  final Map<String, String> _name;
  @override
  Map<String, String> get name {
    if (_name is EqualUnmodifiableMapView) return _name;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_name);
  }

  @override
  final String? shortName;
  @override
  final String color;
  @override
  final TransportType transportType;
  final List<String> _stationIds;
  @override
  List<String> get stationIds {
    if (_stationIds is EqualUnmodifiableListView) return _stationIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stationIds);
  }

  @override
  final OperatingHours? operatingHours;

  @override
  String toString() {
    return 'TransitLine(id: $id, name: $name, shortName: $shortName, color: $color, transportType: $transportType, stationIds: $stationIds, operatingHours: $operatingHours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransitLineImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._name, _name) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.transportType, transportType) ||
                other.transportType == transportType) &&
            const DeepCollectionEquality().equals(
              other._stationIds,
              _stationIds,
            ) &&
            (identical(other.operatingHours, operatingHours) ||
                other.operatingHours == operatingHours));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    const DeepCollectionEquality().hash(_name),
    shortName,
    color,
    transportType,
    const DeepCollectionEquality().hash(_stationIds),
    operatingHours,
  );

  /// Create a copy of TransitLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransitLineImplCopyWith<_$TransitLineImpl> get copyWith =>
      __$$TransitLineImplCopyWithImpl<_$TransitLineImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransitLineImplToJson(this);
  }
}

abstract class _TransitLine implements TransitLine {
  const factory _TransitLine({
    required final String id,
    required final Map<String, String> name,
    final String? shortName,
    required final String color,
    required final TransportType transportType,
    required final List<String> stationIds,
    final OperatingHours? operatingHours,
  }) = _$TransitLineImpl;

  factory _TransitLine.fromJson(Map<String, dynamic> json) =
      _$TransitLineImpl.fromJson;

  @override
  String get id;
  @override
  Map<String, String> get name;
  @override
  String? get shortName;
  @override
  String get color;
  @override
  TransportType get transportType;
  @override
  List<String> get stationIds;
  @override
  OperatingHours? get operatingHours;

  /// Create a copy of TransitLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransitLineImplCopyWith<_$TransitLineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
