// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'station.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StationAccessibility _$StationAccessibilityFromJson(Map<String, dynamic> json) {
  return _StationAccessibility.fromJson(json);
}

/// @nodoc
mixin _$StationAccessibility {
  bool get elevator => throw _privateConstructorUsedError;
  bool get ramp => throw _privateConstructorUsedError;
  bool get tactilePaving => throw _privateConstructorUsedError;
  bool get accessibleRestroom => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this StationAccessibility to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StationAccessibility
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StationAccessibilityCopyWith<StationAccessibility> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StationAccessibilityCopyWith<$Res> {
  factory $StationAccessibilityCopyWith(
    StationAccessibility value,
    $Res Function(StationAccessibility) then,
  ) = _$StationAccessibilityCopyWithImpl<$Res, StationAccessibility>;
  @useResult
  $Res call({
    bool elevator,
    bool ramp,
    bool tactilePaving,
    bool accessibleRestroom,
    String? notes,
  });
}

/// @nodoc
class _$StationAccessibilityCopyWithImpl<
  $Res,
  $Val extends StationAccessibility
>
    implements $StationAccessibilityCopyWith<$Res> {
  _$StationAccessibilityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StationAccessibility
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? elevator = null,
    Object? ramp = null,
    Object? tactilePaving = null,
    Object? accessibleRestroom = null,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            elevator: null == elevator
                ? _value.elevator
                : elevator // ignore: cast_nullable_to_non_nullable
                      as bool,
            ramp: null == ramp
                ? _value.ramp
                : ramp // ignore: cast_nullable_to_non_nullable
                      as bool,
            tactilePaving: null == tactilePaving
                ? _value.tactilePaving
                : tactilePaving // ignore: cast_nullable_to_non_nullable
                      as bool,
            accessibleRestroom: null == accessibleRestroom
                ? _value.accessibleRestroom
                : accessibleRestroom // ignore: cast_nullable_to_non_nullable
                      as bool,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StationAccessibilityImplCopyWith<$Res>
    implements $StationAccessibilityCopyWith<$Res> {
  factory _$$StationAccessibilityImplCopyWith(
    _$StationAccessibilityImpl value,
    $Res Function(_$StationAccessibilityImpl) then,
  ) = __$$StationAccessibilityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool elevator,
    bool ramp,
    bool tactilePaving,
    bool accessibleRestroom,
    String? notes,
  });
}

/// @nodoc
class __$$StationAccessibilityImplCopyWithImpl<$Res>
    extends _$StationAccessibilityCopyWithImpl<$Res, _$StationAccessibilityImpl>
    implements _$$StationAccessibilityImplCopyWith<$Res> {
  __$$StationAccessibilityImplCopyWithImpl(
    _$StationAccessibilityImpl _value,
    $Res Function(_$StationAccessibilityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StationAccessibility
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? elevator = null,
    Object? ramp = null,
    Object? tactilePaving = null,
    Object? accessibleRestroom = null,
    Object? notes = freezed,
  }) {
    return _then(
      _$StationAccessibilityImpl(
        elevator: null == elevator
            ? _value.elevator
            : elevator // ignore: cast_nullable_to_non_nullable
                  as bool,
        ramp: null == ramp
            ? _value.ramp
            : ramp // ignore: cast_nullable_to_non_nullable
                  as bool,
        tactilePaving: null == tactilePaving
            ? _value.tactilePaving
            : tactilePaving // ignore: cast_nullable_to_non_nullable
                  as bool,
        accessibleRestroom: null == accessibleRestroom
            ? _value.accessibleRestroom
            : accessibleRestroom // ignore: cast_nullable_to_non_nullable
                  as bool,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StationAccessibilityImpl implements _StationAccessibility {
  const _$StationAccessibilityImpl({
    this.elevator = false,
    this.ramp = false,
    this.tactilePaving = false,
    this.accessibleRestroom = false,
    this.notes,
  });

  factory _$StationAccessibilityImpl.fromJson(Map<String, dynamic> json) =>
      _$$StationAccessibilityImplFromJson(json);

  @override
  @JsonKey()
  final bool elevator;
  @override
  @JsonKey()
  final bool ramp;
  @override
  @JsonKey()
  final bool tactilePaving;
  @override
  @JsonKey()
  final bool accessibleRestroom;
  @override
  final String? notes;

  @override
  String toString() {
    return 'StationAccessibility(elevator: $elevator, ramp: $ramp, tactilePaving: $tactilePaving, accessibleRestroom: $accessibleRestroom, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StationAccessibilityImpl &&
            (identical(other.elevator, elevator) ||
                other.elevator == elevator) &&
            (identical(other.ramp, ramp) || other.ramp == ramp) &&
            (identical(other.tactilePaving, tactilePaving) ||
                other.tactilePaving == tactilePaving) &&
            (identical(other.accessibleRestroom, accessibleRestroom) ||
                other.accessibleRestroom == accessibleRestroom) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    elevator,
    ramp,
    tactilePaving,
    accessibleRestroom,
    notes,
  );

  /// Create a copy of StationAccessibility
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StationAccessibilityImplCopyWith<_$StationAccessibilityImpl>
  get copyWith =>
      __$$StationAccessibilityImplCopyWithImpl<_$StationAccessibilityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StationAccessibilityImplToJson(this);
  }
}

abstract class _StationAccessibility implements StationAccessibility {
  const factory _StationAccessibility({
    final bool elevator,
    final bool ramp,
    final bool tactilePaving,
    final bool accessibleRestroom,
    final String? notes,
  }) = _$StationAccessibilityImpl;

  factory _StationAccessibility.fromJson(Map<String, dynamic> json) =
      _$StationAccessibilityImpl.fromJson;

  @override
  bool get elevator;
  @override
  bool get ramp;
  @override
  bool get tactilePaving;
  @override
  bool get accessibleRestroom;
  @override
  String? get notes;

  /// Create a copy of StationAccessibility
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StationAccessibilityImplCopyWith<_$StationAccessibilityImpl>
  get copyWith => throw _privateConstructorUsedError;
}

StationEntrance _$StationEntranceFromJson(Map<String, dynamic> json) {
  return _StationEntrance.fromJson(json);
}

/// @nodoc
mixin _$StationEntrance {
  Map<String, String>? get name => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;
  bool? get wheelchairAccessible => throw _privateConstructorUsedError;

  /// Serializes this StationEntrance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StationEntrance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StationEntranceCopyWith<StationEntrance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StationEntranceCopyWith<$Res> {
  factory $StationEntranceCopyWith(
    StationEntrance value,
    $Res Function(StationEntrance) then,
  ) = _$StationEntranceCopyWithImpl<$Res, StationEntrance>;
  @useResult
  $Res call({
    Map<String, String>? name,
    double lat,
    double lng,
    bool? wheelchairAccessible,
  });
}

/// @nodoc
class _$StationEntranceCopyWithImpl<$Res, $Val extends StationEntrance>
    implements $StationEntranceCopyWith<$Res> {
  _$StationEntranceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StationEntrance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? lat = null,
    Object? lng = null,
    Object? wheelchairAccessible = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>?,
            lat: null == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                      as double,
            lng: null == lng
                ? _value.lng
                : lng // ignore: cast_nullable_to_non_nullable
                      as double,
            wheelchairAccessible: freezed == wheelchairAccessible
                ? _value.wheelchairAccessible
                : wheelchairAccessible // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StationEntranceImplCopyWith<$Res>
    implements $StationEntranceCopyWith<$Res> {
  factory _$$StationEntranceImplCopyWith(
    _$StationEntranceImpl value,
    $Res Function(_$StationEntranceImpl) then,
  ) = __$$StationEntranceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Map<String, String>? name,
    double lat,
    double lng,
    bool? wheelchairAccessible,
  });
}

/// @nodoc
class __$$StationEntranceImplCopyWithImpl<$Res>
    extends _$StationEntranceCopyWithImpl<$Res, _$StationEntranceImpl>
    implements _$$StationEntranceImplCopyWith<$Res> {
  __$$StationEntranceImplCopyWithImpl(
    _$StationEntranceImpl _value,
    $Res Function(_$StationEntranceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StationEntrance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? lat = null,
    Object? lng = null,
    Object? wheelchairAccessible = freezed,
  }) {
    return _then(
      _$StationEntranceImpl(
        name: freezed == name
            ? _value._name
            : name // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>?,
        lat: null == lat
            ? _value.lat
            : lat // ignore: cast_nullable_to_non_nullable
                  as double,
        lng: null == lng
            ? _value.lng
            : lng // ignore: cast_nullable_to_non_nullable
                  as double,
        wheelchairAccessible: freezed == wheelchairAccessible
            ? _value.wheelchairAccessible
            : wheelchairAccessible // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StationEntranceImpl implements _StationEntrance {
  const _$StationEntranceImpl({
    final Map<String, String>? name,
    required this.lat,
    required this.lng,
    this.wheelchairAccessible,
  }) : _name = name;

  factory _$StationEntranceImpl.fromJson(Map<String, dynamic> json) =>
      _$$StationEntranceImplFromJson(json);

  final Map<String, String>? _name;
  @override
  Map<String, String>? get name {
    final value = _name;
    if (value == null) return null;
    if (_name is EqualUnmodifiableMapView) return _name;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final double lat;
  @override
  final double lng;
  @override
  final bool? wheelchairAccessible;

  @override
  String toString() {
    return 'StationEntrance(name: $name, lat: $lat, lng: $lng, wheelchairAccessible: $wheelchairAccessible)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StationEntranceImpl &&
            const DeepCollectionEquality().equals(other._name, _name) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.wheelchairAccessible, wheelchairAccessible) ||
                other.wheelchairAccessible == wheelchairAccessible));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_name),
    lat,
    lng,
    wheelchairAccessible,
  );

  /// Create a copy of StationEntrance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StationEntranceImplCopyWith<_$StationEntranceImpl> get copyWith =>
      __$$StationEntranceImplCopyWithImpl<_$StationEntranceImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StationEntranceImplToJson(this);
  }
}

abstract class _StationEntrance implements StationEntrance {
  const factory _StationEntrance({
    final Map<String, String>? name,
    required final double lat,
    required final double lng,
    final bool? wheelchairAccessible,
  }) = _$StationEntranceImpl;

  factory _StationEntrance.fromJson(Map<String, dynamic> json) =
      _$StationEntranceImpl.fromJson;

  @override
  Map<String, String>? get name;
  @override
  double get lat;
  @override
  double get lng;
  @override
  bool? get wheelchairAccessible;

  /// Create a copy of StationEntrance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StationEntranceImplCopyWith<_$StationEntranceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Station _$StationFromJson(Map<String, dynamic> json) {
  return _Station.fromJson(json);
}

/// @nodoc
mixin _$Station {
  String get id => throw _privateConstructorUsedError;
  Map<String, String> get name => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;
  List<String> get lineIds => throw _privateConstructorUsedError;
  StationAccessibility? get accessibility => throw _privateConstructorUsedError;
  List<StationEntrance>? get entrances => throw _privateConstructorUsedError;

  /// Serializes this Station to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Station
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StationCopyWith<Station> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StationCopyWith<$Res> {
  factory $StationCopyWith(Station value, $Res Function(Station) then) =
      _$StationCopyWithImpl<$Res, Station>;
  @useResult
  $Res call({
    String id,
    Map<String, String> name,
    double lat,
    double lng,
    List<String> lineIds,
    StationAccessibility? accessibility,
    List<StationEntrance>? entrances,
  });

  $StationAccessibilityCopyWith<$Res>? get accessibility;
}

/// @nodoc
class _$StationCopyWithImpl<$Res, $Val extends Station>
    implements $StationCopyWith<$Res> {
  _$StationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Station
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? lat = null,
    Object? lng = null,
    Object? lineIds = null,
    Object? accessibility = freezed,
    Object? entrances = freezed,
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
            lat: null == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                      as double,
            lng: null == lng
                ? _value.lng
                : lng // ignore: cast_nullable_to_non_nullable
                      as double,
            lineIds: null == lineIds
                ? _value.lineIds
                : lineIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            accessibility: freezed == accessibility
                ? _value.accessibility
                : accessibility // ignore: cast_nullable_to_non_nullable
                      as StationAccessibility?,
            entrances: freezed == entrances
                ? _value.entrances
                : entrances // ignore: cast_nullable_to_non_nullable
                      as List<StationEntrance>?,
          )
          as $Val,
    );
  }

  /// Create a copy of Station
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StationAccessibilityCopyWith<$Res>? get accessibility {
    if (_value.accessibility == null) {
      return null;
    }

    return $StationAccessibilityCopyWith<$Res>(_value.accessibility!, (value) {
      return _then(_value.copyWith(accessibility: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StationImplCopyWith<$Res> implements $StationCopyWith<$Res> {
  factory _$$StationImplCopyWith(
    _$StationImpl value,
    $Res Function(_$StationImpl) then,
  ) = __$$StationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    Map<String, String> name,
    double lat,
    double lng,
    List<String> lineIds,
    StationAccessibility? accessibility,
    List<StationEntrance>? entrances,
  });

  @override
  $StationAccessibilityCopyWith<$Res>? get accessibility;
}

/// @nodoc
class __$$StationImplCopyWithImpl<$Res>
    extends _$StationCopyWithImpl<$Res, _$StationImpl>
    implements _$$StationImplCopyWith<$Res> {
  __$$StationImplCopyWithImpl(
    _$StationImpl _value,
    $Res Function(_$StationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Station
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? lat = null,
    Object? lng = null,
    Object? lineIds = null,
    Object? accessibility = freezed,
    Object? entrances = freezed,
  }) {
    return _then(
      _$StationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value._name
            : name // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
        lat: null == lat
            ? _value.lat
            : lat // ignore: cast_nullable_to_non_nullable
                  as double,
        lng: null == lng
            ? _value.lng
            : lng // ignore: cast_nullable_to_non_nullable
                  as double,
        lineIds: null == lineIds
            ? _value._lineIds
            : lineIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        accessibility: freezed == accessibility
            ? _value.accessibility
            : accessibility // ignore: cast_nullable_to_non_nullable
                  as StationAccessibility?,
        entrances: freezed == entrances
            ? _value._entrances
            : entrances // ignore: cast_nullable_to_non_nullable
                  as List<StationEntrance>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StationImpl implements _Station {
  const _$StationImpl({
    required this.id,
    required final Map<String, String> name,
    required this.lat,
    required this.lng,
    required final List<String> lineIds,
    this.accessibility,
    final List<StationEntrance>? entrances,
  }) : _name = name,
       _lineIds = lineIds,
       _entrances = entrances;

  factory _$StationImpl.fromJson(Map<String, dynamic> json) =>
      _$$StationImplFromJson(json);

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
  final double lat;
  @override
  final double lng;
  final List<String> _lineIds;
  @override
  List<String> get lineIds {
    if (_lineIds is EqualUnmodifiableListView) return _lineIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lineIds);
  }

  @override
  final StationAccessibility? accessibility;
  final List<StationEntrance>? _entrances;
  @override
  List<StationEntrance>? get entrances {
    final value = _entrances;
    if (value == null) return null;
    if (_entrances is EqualUnmodifiableListView) return _entrances;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Station(id: $id, name: $name, lat: $lat, lng: $lng, lineIds: $lineIds, accessibility: $accessibility, entrances: $entrances)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StationImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._name, _name) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            const DeepCollectionEquality().equals(other._lineIds, _lineIds) &&
            (identical(other.accessibility, accessibility) ||
                other.accessibility == accessibility) &&
            const DeepCollectionEquality().equals(
              other._entrances,
              _entrances,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    const DeepCollectionEquality().hash(_name),
    lat,
    lng,
    const DeepCollectionEquality().hash(_lineIds),
    accessibility,
    const DeepCollectionEquality().hash(_entrances),
  );

  /// Create a copy of Station
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StationImplCopyWith<_$StationImpl> get copyWith =>
      __$$StationImplCopyWithImpl<_$StationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StationImplToJson(this);
  }
}

abstract class _Station implements Station {
  const factory _Station({
    required final String id,
    required final Map<String, String> name,
    required final double lat,
    required final double lng,
    required final List<String> lineIds,
    final StationAccessibility? accessibility,
    final List<StationEntrance>? entrances,
  }) = _$StationImpl;

  factory _Station.fromJson(Map<String, dynamic> json) = _$StationImpl.fromJson;

  @override
  String get id;
  @override
  Map<String, String> get name;
  @override
  double get lat;
  @override
  double get lng;
  @override
  List<String> get lineIds;
  @override
  StationAccessibility? get accessibility;
  @override
  List<StationEntrance>? get entrances;

  /// Create a copy of Station
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StationImplCopyWith<_$StationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
