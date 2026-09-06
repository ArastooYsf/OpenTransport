// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CalendarException _$CalendarExceptionFromJson(Map<String, dynamic> json) {
  return _CalendarException.fromJson(json);
}

/// @nodoc
mixin _$CalendarException {
  String get date => throw _privateConstructorUsedError;
  CalendarExceptionType get type => throw _privateConstructorUsedError;

  /// Serializes this CalendarException to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CalendarException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CalendarExceptionCopyWith<CalendarException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarExceptionCopyWith<$Res> {
  factory $CalendarExceptionCopyWith(
    CalendarException value,
    $Res Function(CalendarException) then,
  ) = _$CalendarExceptionCopyWithImpl<$Res, CalendarException>;
  @useResult
  $Res call({String date, CalendarExceptionType type});
}

/// @nodoc
class _$CalendarExceptionCopyWithImpl<$Res, $Val extends CalendarException>
    implements $CalendarExceptionCopyWith<$Res> {
  _$CalendarExceptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CalendarException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null, Object? type = null}) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as CalendarExceptionType,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CalendarExceptionImplCopyWith<$Res>
    implements $CalendarExceptionCopyWith<$Res> {
  factory _$$CalendarExceptionImplCopyWith(
    _$CalendarExceptionImpl value,
    $Res Function(_$CalendarExceptionImpl) then,
  ) = __$$CalendarExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String date, CalendarExceptionType type});
}

/// @nodoc
class __$$CalendarExceptionImplCopyWithImpl<$Res>
    extends _$CalendarExceptionCopyWithImpl<$Res, _$CalendarExceptionImpl>
    implements _$$CalendarExceptionImplCopyWith<$Res> {
  __$$CalendarExceptionImplCopyWithImpl(
    _$CalendarExceptionImpl _value,
    $Res Function(_$CalendarExceptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CalendarException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null, Object? type = null}) {
    return _then(
      _$CalendarExceptionImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as CalendarExceptionType,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CalendarExceptionImpl implements _CalendarException {
  const _$CalendarExceptionImpl({required this.date, required this.type});

  factory _$CalendarExceptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalendarExceptionImplFromJson(json);

  @override
  final String date;
  @override
  final CalendarExceptionType type;

  @override
  String toString() {
    return 'CalendarException(date: $date, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarExceptionImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, type);

  /// Create a copy of CalendarException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarExceptionImplCopyWith<_$CalendarExceptionImpl> get copyWith =>
      __$$CalendarExceptionImplCopyWithImpl<_$CalendarExceptionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CalendarExceptionImplToJson(this);
  }
}

abstract class _CalendarException implements CalendarException {
  const factory _CalendarException({
    required final String date,
    required final CalendarExceptionType type,
  }) = _$CalendarExceptionImpl;

  factory _CalendarException.fromJson(Map<String, dynamic> json) =
      _$CalendarExceptionImpl.fromJson;

  @override
  String get date;
  @override
  CalendarExceptionType get type;

  /// Create a copy of CalendarException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CalendarExceptionImplCopyWith<_$CalendarExceptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CalendarEntry _$CalendarEntryFromJson(Map<String, dynamic> json) {
  return _CalendarEntry.fromJson(json);
}

/// @nodoc
mixin _$CalendarEntry {
  String get id => throw _privateConstructorUsedError;
  List<DayOfWeek> get daysOfWeek => throw _privateConstructorUsedError;
  String? get startDate => throw _privateConstructorUsedError;
  String? get endDate => throw _privateConstructorUsedError;
  List<CalendarException>? get exceptions => throw _privateConstructorUsedError;

  /// Serializes this CalendarEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CalendarEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CalendarEntryCopyWith<CalendarEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarEntryCopyWith<$Res> {
  factory $CalendarEntryCopyWith(
    CalendarEntry value,
    $Res Function(CalendarEntry) then,
  ) = _$CalendarEntryCopyWithImpl<$Res, CalendarEntry>;
  @useResult
  $Res call({
    String id,
    List<DayOfWeek> daysOfWeek,
    String? startDate,
    String? endDate,
    List<CalendarException>? exceptions,
  });
}

/// @nodoc
class _$CalendarEntryCopyWithImpl<$Res, $Val extends CalendarEntry>
    implements $CalendarEntryCopyWith<$Res> {
  _$CalendarEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CalendarEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? daysOfWeek = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? exceptions = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            daysOfWeek: null == daysOfWeek
                ? _value.daysOfWeek
                : daysOfWeek // ignore: cast_nullable_to_non_nullable
                      as List<DayOfWeek>,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            exceptions: freezed == exceptions
                ? _value.exceptions
                : exceptions // ignore: cast_nullable_to_non_nullable
                      as List<CalendarException>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CalendarEntryImplCopyWith<$Res>
    implements $CalendarEntryCopyWith<$Res> {
  factory _$$CalendarEntryImplCopyWith(
    _$CalendarEntryImpl value,
    $Res Function(_$CalendarEntryImpl) then,
  ) = __$$CalendarEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    List<DayOfWeek> daysOfWeek,
    String? startDate,
    String? endDate,
    List<CalendarException>? exceptions,
  });
}

/// @nodoc
class __$$CalendarEntryImplCopyWithImpl<$Res>
    extends _$CalendarEntryCopyWithImpl<$Res, _$CalendarEntryImpl>
    implements _$$CalendarEntryImplCopyWith<$Res> {
  __$$CalendarEntryImplCopyWithImpl(
    _$CalendarEntryImpl _value,
    $Res Function(_$CalendarEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CalendarEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? daysOfWeek = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? exceptions = freezed,
  }) {
    return _then(
      _$CalendarEntryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        daysOfWeek: null == daysOfWeek
            ? _value._daysOfWeek
            : daysOfWeek // ignore: cast_nullable_to_non_nullable
                  as List<DayOfWeek>,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        exceptions: freezed == exceptions
            ? _value._exceptions
            : exceptions // ignore: cast_nullable_to_non_nullable
                  as List<CalendarException>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CalendarEntryImpl implements _CalendarEntry {
  const _$CalendarEntryImpl({
    required this.id,
    required final List<DayOfWeek> daysOfWeek,
    this.startDate,
    this.endDate,
    final List<CalendarException>? exceptions,
  }) : _daysOfWeek = daysOfWeek,
       _exceptions = exceptions;

  factory _$CalendarEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalendarEntryImplFromJson(json);

  @override
  final String id;
  final List<DayOfWeek> _daysOfWeek;
  @override
  List<DayOfWeek> get daysOfWeek {
    if (_daysOfWeek is EqualUnmodifiableListView) return _daysOfWeek;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_daysOfWeek);
  }

  @override
  final String? startDate;
  @override
  final String? endDate;
  final List<CalendarException>? _exceptions;
  @override
  List<CalendarException>? get exceptions {
    final value = _exceptions;
    if (value == null) return null;
    if (_exceptions is EqualUnmodifiableListView) return _exceptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CalendarEntry(id: $id, daysOfWeek: $daysOfWeek, startDate: $startDate, endDate: $endDate, exceptions: $exceptions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(
              other._daysOfWeek,
              _daysOfWeek,
            ) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality().equals(
              other._exceptions,
              _exceptions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    const DeepCollectionEquality().hash(_daysOfWeek),
    startDate,
    endDate,
    const DeepCollectionEquality().hash(_exceptions),
  );

  /// Create a copy of CalendarEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarEntryImplCopyWith<_$CalendarEntryImpl> get copyWith =>
      __$$CalendarEntryImplCopyWithImpl<_$CalendarEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CalendarEntryImplToJson(this);
  }
}

abstract class _CalendarEntry implements CalendarEntry {
  const factory _CalendarEntry({
    required final String id,
    required final List<DayOfWeek> daysOfWeek,
    final String? startDate,
    final String? endDate,
    final List<CalendarException>? exceptions,
  }) = _$CalendarEntryImpl;

  factory _CalendarEntry.fromJson(Map<String, dynamic> json) =
      _$CalendarEntryImpl.fromJson;

  @override
  String get id;
  @override
  List<DayOfWeek> get daysOfWeek;
  @override
  String? get startDate;
  @override
  String? get endDate;
  @override
  List<CalendarException>? get exceptions;

  /// Create a copy of CalendarEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CalendarEntryImplCopyWith<_$CalendarEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Trip _$TripFromJson(Map<String, dynamic> json) {
  return _Trip.fromJson(json);
}

/// @nodoc
mixin _$Trip {
  String get id => throw _privateConstructorUsedError;
  String get lineId => throw _privateConstructorUsedError;
  int get direction => throw _privateConstructorUsedError;
  String get calendarId => throw _privateConstructorUsedError;

  /// Serializes this Trip to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Trip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TripCopyWith<Trip> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripCopyWith<$Res> {
  factory $TripCopyWith(Trip value, $Res Function(Trip) then) =
      _$TripCopyWithImpl<$Res, Trip>;
  @useResult
  $Res call({String id, String lineId, int direction, String calendarId});
}

/// @nodoc
class _$TripCopyWithImpl<$Res, $Val extends Trip>
    implements $TripCopyWith<$Res> {
  _$TripCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Trip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lineId = null,
    Object? direction = null,
    Object? calendarId = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            lineId: null == lineId
                ? _value.lineId
                : lineId // ignore: cast_nullable_to_non_nullable
                      as String,
            direction: null == direction
                ? _value.direction
                : direction // ignore: cast_nullable_to_non_nullable
                      as int,
            calendarId: null == calendarId
                ? _value.calendarId
                : calendarId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TripImplCopyWith<$Res> implements $TripCopyWith<$Res> {
  factory _$$TripImplCopyWith(
    _$TripImpl value,
    $Res Function(_$TripImpl) then,
  ) = __$$TripImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String lineId, int direction, String calendarId});
}

/// @nodoc
class __$$TripImplCopyWithImpl<$Res>
    extends _$TripCopyWithImpl<$Res, _$TripImpl>
    implements _$$TripImplCopyWith<$Res> {
  __$$TripImplCopyWithImpl(_$TripImpl _value, $Res Function(_$TripImpl) _then)
    : super(_value, _then);

  /// Create a copy of Trip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lineId = null,
    Object? direction = null,
    Object? calendarId = null,
  }) {
    return _then(
      _$TripImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        lineId: null == lineId
            ? _value.lineId
            : lineId // ignore: cast_nullable_to_non_nullable
                  as String,
        direction: null == direction
            ? _value.direction
            : direction // ignore: cast_nullable_to_non_nullable
                  as int,
        calendarId: null == calendarId
            ? _value.calendarId
            : calendarId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TripImpl implements _Trip {
  const _$TripImpl({
    required this.id,
    required this.lineId,
    required this.direction,
    required this.calendarId,
  });

  factory _$TripImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripImplFromJson(json);

  @override
  final String id;
  @override
  final String lineId;
  @override
  final int direction;
  @override
  final String calendarId;

  @override
  String toString() {
    return 'Trip(id: $id, lineId: $lineId, direction: $direction, calendarId: $calendarId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.lineId, lineId) || other.lineId == lineId) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.calendarId, calendarId) ||
                other.calendarId == calendarId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, lineId, direction, calendarId);

  /// Create a copy of Trip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TripImplCopyWith<_$TripImpl> get copyWith =>
      __$$TripImplCopyWithImpl<_$TripImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TripImplToJson(this);
  }
}

abstract class _Trip implements Trip {
  const factory _Trip({
    required final String id,
    required final String lineId,
    required final int direction,
    required final String calendarId,
  }) = _$TripImpl;

  factory _Trip.fromJson(Map<String, dynamic> json) = _$TripImpl.fromJson;

  @override
  String get id;
  @override
  String get lineId;
  @override
  int get direction;
  @override
  String get calendarId;

  /// Create a copy of Trip
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TripImplCopyWith<_$TripImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StopTime _$StopTimeFromJson(Map<String, dynamic> json) {
  return _StopTime.fromJson(json);
}

/// @nodoc
mixin _$StopTime {
  String get tripId => throw _privateConstructorUsedError;
  String get stationId => throw _privateConstructorUsedError;
  String get arrivalTime => throw _privateConstructorUsedError;
  String? get departureTime => throw _privateConstructorUsedError;
  int get stopSequence => throw _privateConstructorUsedError;

  /// Serializes this StopTime to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StopTime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StopTimeCopyWith<StopTime> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StopTimeCopyWith<$Res> {
  factory $StopTimeCopyWith(StopTime value, $Res Function(StopTime) then) =
      _$StopTimeCopyWithImpl<$Res, StopTime>;
  @useResult
  $Res call({
    String tripId,
    String stationId,
    String arrivalTime,
    String? departureTime,
    int stopSequence,
  });
}

/// @nodoc
class _$StopTimeCopyWithImpl<$Res, $Val extends StopTime>
    implements $StopTimeCopyWith<$Res> {
  _$StopTimeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StopTime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripId = null,
    Object? stationId = null,
    Object? arrivalTime = null,
    Object? departureTime = freezed,
    Object? stopSequence = null,
  }) {
    return _then(
      _value.copyWith(
            tripId: null == tripId
                ? _value.tripId
                : tripId // ignore: cast_nullable_to_non_nullable
                      as String,
            stationId: null == stationId
                ? _value.stationId
                : stationId // ignore: cast_nullable_to_non_nullable
                      as String,
            arrivalTime: null == arrivalTime
                ? _value.arrivalTime
                : arrivalTime // ignore: cast_nullable_to_non_nullable
                      as String,
            departureTime: freezed == departureTime
                ? _value.departureTime
                : departureTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            stopSequence: null == stopSequence
                ? _value.stopSequence
                : stopSequence // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StopTimeImplCopyWith<$Res>
    implements $StopTimeCopyWith<$Res> {
  factory _$$StopTimeImplCopyWith(
    _$StopTimeImpl value,
    $Res Function(_$StopTimeImpl) then,
  ) = __$$StopTimeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String tripId,
    String stationId,
    String arrivalTime,
    String? departureTime,
    int stopSequence,
  });
}

/// @nodoc
class __$$StopTimeImplCopyWithImpl<$Res>
    extends _$StopTimeCopyWithImpl<$Res, _$StopTimeImpl>
    implements _$$StopTimeImplCopyWith<$Res> {
  __$$StopTimeImplCopyWithImpl(
    _$StopTimeImpl _value,
    $Res Function(_$StopTimeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StopTime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripId = null,
    Object? stationId = null,
    Object? arrivalTime = null,
    Object? departureTime = freezed,
    Object? stopSequence = null,
  }) {
    return _then(
      _$StopTimeImpl(
        tripId: null == tripId
            ? _value.tripId
            : tripId // ignore: cast_nullable_to_non_nullable
                  as String,
        stationId: null == stationId
            ? _value.stationId
            : stationId // ignore: cast_nullable_to_non_nullable
                  as String,
        arrivalTime: null == arrivalTime
            ? _value.arrivalTime
            : arrivalTime // ignore: cast_nullable_to_non_nullable
                  as String,
        departureTime: freezed == departureTime
            ? _value.departureTime
            : departureTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        stopSequence: null == stopSequence
            ? _value.stopSequence
            : stopSequence // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StopTimeImpl implements _StopTime {
  const _$StopTimeImpl({
    required this.tripId,
    required this.stationId,
    required this.arrivalTime,
    this.departureTime,
    required this.stopSequence,
  });

  factory _$StopTimeImpl.fromJson(Map<String, dynamic> json) =>
      _$$StopTimeImplFromJson(json);

  @override
  final String tripId;
  @override
  final String stationId;
  @override
  final String arrivalTime;
  @override
  final String? departureTime;
  @override
  final int stopSequence;

  @override
  String toString() {
    return 'StopTime(tripId: $tripId, stationId: $stationId, arrivalTime: $arrivalTime, departureTime: $departureTime, stopSequence: $stopSequence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StopTimeImpl &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.stationId, stationId) ||
                other.stationId == stationId) &&
            (identical(other.arrivalTime, arrivalTime) ||
                other.arrivalTime == arrivalTime) &&
            (identical(other.departureTime, departureTime) ||
                other.departureTime == departureTime) &&
            (identical(other.stopSequence, stopSequence) ||
                other.stopSequence == stopSequence));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    tripId,
    stationId,
    arrivalTime,
    departureTime,
    stopSequence,
  );

  /// Create a copy of StopTime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StopTimeImplCopyWith<_$StopTimeImpl> get copyWith =>
      __$$StopTimeImplCopyWithImpl<_$StopTimeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StopTimeImplToJson(this);
  }
}

abstract class _StopTime implements StopTime {
  const factory _StopTime({
    required final String tripId,
    required final String stationId,
    required final String arrivalTime,
    final String? departureTime,
    required final int stopSequence,
  }) = _$StopTimeImpl;

  factory _StopTime.fromJson(Map<String, dynamic> json) =
      _$StopTimeImpl.fromJson;

  @override
  String get tripId;
  @override
  String get stationId;
  @override
  String get arrivalTime;
  @override
  String? get departureTime;
  @override
  int get stopSequence;

  /// Create a copy of StopTime
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StopTimeImplCopyWith<_$StopTimeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
