// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OnboardingState {
  OnboardingStep get step => throw _privateConstructorUsedError;
  String? get countrySlug => throw _privateConstructorUsedError;
  String? get languageCode => throw _privateConstructorUsedError;

  /// Whether the user has ever explicitly picked a language themselves,
  /// as opposed to just receiving the country-derived pre-fill. Once
  /// true, selecting a different country no longer overwrites it.
  bool get languageTouchedByUser => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OnboardingStateCopyWith<OnboardingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingStateCopyWith<$Res> {
  factory $OnboardingStateCopyWith(
    OnboardingState value,
    $Res Function(OnboardingState) then,
  ) = _$OnboardingStateCopyWithImpl<$Res, OnboardingState>;
  @useResult
  $Res call({
    OnboardingStep step,
    String? countrySlug,
    String? languageCode,
    bool languageTouchedByUser,
    String username,
    String firstName,
    String lastName,
    String password,
  });
}

/// @nodoc
class _$OnboardingStateCopyWithImpl<$Res, $Val extends OnboardingState>
    implements $OnboardingStateCopyWith<$Res> {
  _$OnboardingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? step = null,
    Object? countrySlug = freezed,
    Object? languageCode = freezed,
    Object? languageTouchedByUser = null,
    Object? username = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? password = null,
  }) {
    return _then(
      _value.copyWith(
            step: null == step
                ? _value.step
                : step // ignore: cast_nullable_to_non_nullable
                      as OnboardingStep,
            countrySlug: freezed == countrySlug
                ? _value.countrySlug
                : countrySlug // ignore: cast_nullable_to_non_nullable
                      as String?,
            languageCode: freezed == languageCode
                ? _value.languageCode
                : languageCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            languageTouchedByUser: null == languageTouchedByUser
                ? _value.languageTouchedByUser
                : languageTouchedByUser // ignore: cast_nullable_to_non_nullable
                      as bool,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
            password: null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OnboardingStateImplCopyWith<$Res>
    implements $OnboardingStateCopyWith<$Res> {
  factory _$$OnboardingStateImplCopyWith(
    _$OnboardingStateImpl value,
    $Res Function(_$OnboardingStateImpl) then,
  ) = __$$OnboardingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    OnboardingStep step,
    String? countrySlug,
    String? languageCode,
    bool languageTouchedByUser,
    String username,
    String firstName,
    String lastName,
    String password,
  });
}

/// @nodoc
class __$$OnboardingStateImplCopyWithImpl<$Res>
    extends _$OnboardingStateCopyWithImpl<$Res, _$OnboardingStateImpl>
    implements _$$OnboardingStateImplCopyWith<$Res> {
  __$$OnboardingStateImplCopyWithImpl(
    _$OnboardingStateImpl _value,
    $Res Function(_$OnboardingStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? step = null,
    Object? countrySlug = freezed,
    Object? languageCode = freezed,
    Object? languageTouchedByUser = null,
    Object? username = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? password = null,
  }) {
    return _then(
      _$OnboardingStateImpl(
        step: null == step
            ? _value.step
            : step // ignore: cast_nullable_to_non_nullable
                  as OnboardingStep,
        countrySlug: freezed == countrySlug
            ? _value.countrySlug
            : countrySlug // ignore: cast_nullable_to_non_nullable
                  as String?,
        languageCode: freezed == languageCode
            ? _value.languageCode
            : languageCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        languageTouchedByUser: null == languageTouchedByUser
            ? _value.languageTouchedByUser
            : languageTouchedByUser // ignore: cast_nullable_to_non_nullable
                  as bool,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$OnboardingStateImpl implements _OnboardingState {
  const _$OnboardingStateImpl({
    this.step = OnboardingStep.country,
    this.countrySlug,
    this.languageCode,
    this.languageTouchedByUser = false,
    this.username = '',
    this.firstName = '',
    this.lastName = '',
    this.password = '',
  });

  @override
  @JsonKey()
  final OnboardingStep step;
  @override
  final String? countrySlug;
  @override
  final String? languageCode;

  /// Whether the user has ever explicitly picked a language themselves,
  /// as opposed to just receiving the country-derived pre-fill. Once
  /// true, selecting a different country no longer overwrites it.
  @override
  @JsonKey()
  final bool languageTouchedByUser;
  @override
  @JsonKey()
  final String username;
  @override
  @JsonKey()
  final String firstName;
  @override
  @JsonKey()
  final String lastName;
  @override
  @JsonKey()
  final String password;

  @override
  String toString() {
    return 'OnboardingState(step: $step, countrySlug: $countrySlug, languageCode: $languageCode, languageTouchedByUser: $languageTouchedByUser, username: $username, firstName: $firstName, lastName: $lastName, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingStateImpl &&
            (identical(other.step, step) || other.step == step) &&
            (identical(other.countrySlug, countrySlug) ||
                other.countrySlug == countrySlug) &&
            (identical(other.languageCode, languageCode) ||
                other.languageCode == languageCode) &&
            (identical(other.languageTouchedByUser, languageTouchedByUser) ||
                other.languageTouchedByUser == languageTouchedByUser) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    step,
    countrySlug,
    languageCode,
    languageTouchedByUser,
    username,
    firstName,
    lastName,
    password,
  );

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingStateImplCopyWith<_$OnboardingStateImpl> get copyWith =>
      __$$OnboardingStateImplCopyWithImpl<_$OnboardingStateImpl>(
        this,
        _$identity,
      );
}

abstract class _OnboardingState implements OnboardingState {
  const factory _OnboardingState({
    final OnboardingStep step,
    final String? countrySlug,
    final String? languageCode,
    final bool languageTouchedByUser,
    final String username,
    final String firstName,
    final String lastName,
    final String password,
  }) = _$OnboardingStateImpl;

  @override
  OnboardingStep get step;
  @override
  String? get countrySlug;
  @override
  String? get languageCode;

  /// Whether the user has ever explicitly picked a language themselves,
  /// as opposed to just receiving the country-derived pre-fill. Once
  /// true, selecting a different country no longer overwrites it.
  @override
  bool get languageTouchedByUser;
  @override
  String get username;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get password;

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnboardingStateImplCopyWith<_$OnboardingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
