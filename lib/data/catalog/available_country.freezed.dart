// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'available_country.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AvailableCountry {
  /// The `data/<slug>/` folder name, e.g. `'iran'`.
  String get slug => throw _privateConstructorUsedError;

  /// ISO 3166-1 alpha-2 code, e.g. `'IR'` — matches each city file's
  /// `meta.country`.
  String get isoCode => throw _privateConstructorUsedError;

  /// Locale code → display name, e.g. `{ 'fa': 'ایران', 'en': 'Iran' }`.
  Map<String, String> get name => throw _privateConstructorUsedError;

  /// The country's official language, as an app locale code (e.g.
  /// `'fa'`). Used to pre-select a language in onboarding — falls back
  /// to English if the app doesn't support this language yet.
  String get officialLanguageCode => throw _privateConstructorUsedError;

  /// Create a copy of AvailableCountry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AvailableCountryCopyWith<AvailableCountry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvailableCountryCopyWith<$Res> {
  factory $AvailableCountryCopyWith(
    AvailableCountry value,
    $Res Function(AvailableCountry) then,
  ) = _$AvailableCountryCopyWithImpl<$Res, AvailableCountry>;
  @useResult
  $Res call({
    String slug,
    String isoCode,
    Map<String, String> name,
    String officialLanguageCode,
  });
}

/// @nodoc
class _$AvailableCountryCopyWithImpl<$Res, $Val extends AvailableCountry>
    implements $AvailableCountryCopyWith<$Res> {
  _$AvailableCountryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AvailableCountry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slug = null,
    Object? isoCode = null,
    Object? name = null,
    Object? officialLanguageCode = null,
  }) {
    return _then(
      _value.copyWith(
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            isoCode: null == isoCode
                ? _value.isoCode
                : isoCode // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
            officialLanguageCode: null == officialLanguageCode
                ? _value.officialLanguageCode
                : officialLanguageCode // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AvailableCountryImplCopyWith<$Res>
    implements $AvailableCountryCopyWith<$Res> {
  factory _$$AvailableCountryImplCopyWith(
    _$AvailableCountryImpl value,
    $Res Function(_$AvailableCountryImpl) then,
  ) = __$$AvailableCountryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String slug,
    String isoCode,
    Map<String, String> name,
    String officialLanguageCode,
  });
}

/// @nodoc
class __$$AvailableCountryImplCopyWithImpl<$Res>
    extends _$AvailableCountryCopyWithImpl<$Res, _$AvailableCountryImpl>
    implements _$$AvailableCountryImplCopyWith<$Res> {
  __$$AvailableCountryImplCopyWithImpl(
    _$AvailableCountryImpl _value,
    $Res Function(_$AvailableCountryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AvailableCountry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slug = null,
    Object? isoCode = null,
    Object? name = null,
    Object? officialLanguageCode = null,
  }) {
    return _then(
      _$AvailableCountryImpl(
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        isoCode: null == isoCode
            ? _value.isoCode
            : isoCode // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value._name
            : name // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
        officialLanguageCode: null == officialLanguageCode
            ? _value.officialLanguageCode
            : officialLanguageCode // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AvailableCountryImpl implements _AvailableCountry {
  const _$AvailableCountryImpl({
    required this.slug,
    required this.isoCode,
    required final Map<String, String> name,
    required this.officialLanguageCode,
  }) : _name = name;

  /// The `data/<slug>/` folder name, e.g. `'iran'`.
  @override
  final String slug;

  /// ISO 3166-1 alpha-2 code, e.g. `'IR'` — matches each city file's
  /// `meta.country`.
  @override
  final String isoCode;

  /// Locale code → display name, e.g. `{ 'fa': 'ایران', 'en': 'Iran' }`.
  final Map<String, String> _name;

  /// Locale code → display name, e.g. `{ 'fa': 'ایران', 'en': 'Iran' }`.
  @override
  Map<String, String> get name {
    if (_name is EqualUnmodifiableMapView) return _name;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_name);
  }

  /// The country's official language, as an app locale code (e.g.
  /// `'fa'`). Used to pre-select a language in onboarding — falls back
  /// to English if the app doesn't support this language yet.
  @override
  final String officialLanguageCode;

  @override
  String toString() {
    return 'AvailableCountry(slug: $slug, isoCode: $isoCode, name: $name, officialLanguageCode: $officialLanguageCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AvailableCountryImpl &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.isoCode, isoCode) || other.isoCode == isoCode) &&
            const DeepCollectionEquality().equals(other._name, _name) &&
            (identical(other.officialLanguageCode, officialLanguageCode) ||
                other.officialLanguageCode == officialLanguageCode));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    slug,
    isoCode,
    const DeepCollectionEquality().hash(_name),
    officialLanguageCode,
  );

  /// Create a copy of AvailableCountry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AvailableCountryImplCopyWith<_$AvailableCountryImpl> get copyWith =>
      __$$AvailableCountryImplCopyWithImpl<_$AvailableCountryImpl>(
        this,
        _$identity,
      );
}

abstract class _AvailableCountry implements AvailableCountry {
  const factory _AvailableCountry({
    required final String slug,
    required final String isoCode,
    required final Map<String, String> name,
    required final String officialLanguageCode,
  }) = _$AvailableCountryImpl;

  /// The `data/<slug>/` folder name, e.g. `'iran'`.
  @override
  String get slug;

  /// ISO 3166-1 alpha-2 code, e.g. `'IR'` — matches each city file's
  /// `meta.country`.
  @override
  String get isoCode;

  /// Locale code → display name, e.g. `{ 'fa': 'ایران', 'en': 'Iran' }`.
  @override
  Map<String, String> get name;

  /// The country's official language, as an app locale code (e.g.
  /// `'fa'`). Used to pre-select a language in onboarding — falls back
  /// to English if the app doesn't support this language yet.
  @override
  String get officialLanguageCode;

  /// Create a copy of AvailableCountry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AvailableCountryImplCopyWith<_$AvailableCountryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
