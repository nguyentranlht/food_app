// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Meal _$MealFromJson(Map<String, dynamic> json) {
  return _Meal.fromJson(json);
}

/// @nodoc
mixin _$Meal {
  String get idMeal => throw _privateConstructorUsedError;
  String get strMeal => throw _privateConstructorUsedError;
  String get strCategory => throw _privateConstructorUsedError;
  String get strArea => throw _privateConstructorUsedError;
  String get strMealThumb => throw _privateConstructorUsedError;
  String get strInstructions => throw _privateConstructorUsedError;
  String get strYoutube => throw _privateConstructorUsedError;

  /// Serializes this Meal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Meal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealCopyWith<Meal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealCopyWith<$Res> {
  factory $MealCopyWith(Meal value, $Res Function(Meal) then) =
      _$MealCopyWithImpl<$Res, Meal>;
  @useResult
  $Res call({
    String idMeal,
    String strMeal,
    String strCategory,
    String strArea,
    String strMealThumb,
    String strInstructions,
    String strYoutube,
  });
}

/// @nodoc
class _$MealCopyWithImpl<$Res, $Val extends Meal>
    implements $MealCopyWith<$Res> {
  _$MealCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Meal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idMeal = null,
    Object? strMeal = null,
    Object? strCategory = null,
    Object? strArea = null,
    Object? strMealThumb = null,
    Object? strInstructions = null,
    Object? strYoutube = null,
  }) {
    return _then(
      _value.copyWith(
            idMeal:
                null == idMeal
                    ? _value.idMeal
                    : idMeal // ignore: cast_nullable_to_non_nullable
                        as String,
            strMeal:
                null == strMeal
                    ? _value.strMeal
                    : strMeal // ignore: cast_nullable_to_non_nullable
                        as String,
            strCategory:
                null == strCategory
                    ? _value.strCategory
                    : strCategory // ignore: cast_nullable_to_non_nullable
                        as String,
            strArea:
                null == strArea
                    ? _value.strArea
                    : strArea // ignore: cast_nullable_to_non_nullable
                        as String,
            strMealThumb:
                null == strMealThumb
                    ? _value.strMealThumb
                    : strMealThumb // ignore: cast_nullable_to_non_nullable
                        as String,
            strInstructions:
                null == strInstructions
                    ? _value.strInstructions
                    : strInstructions // ignore: cast_nullable_to_non_nullable
                        as String,
            strYoutube:
                null == strYoutube
                    ? _value.strYoutube
                    : strYoutube // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MealImplCopyWith<$Res> implements $MealCopyWith<$Res> {
  factory _$$MealImplCopyWith(
    _$MealImpl value,
    $Res Function(_$MealImpl) then,
  ) = __$$MealImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String idMeal,
    String strMeal,
    String strCategory,
    String strArea,
    String strMealThumb,
    String strInstructions,
    String strYoutube,
  });
}

/// @nodoc
class __$$MealImplCopyWithImpl<$Res>
    extends _$MealCopyWithImpl<$Res, _$MealImpl>
    implements _$$MealImplCopyWith<$Res> {
  __$$MealImplCopyWithImpl(_$MealImpl _value, $Res Function(_$MealImpl) _then)
    : super(_value, _then);

  /// Create a copy of Meal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idMeal = null,
    Object? strMeal = null,
    Object? strCategory = null,
    Object? strArea = null,
    Object? strMealThumb = null,
    Object? strInstructions = null,
    Object? strYoutube = null,
  }) {
    return _then(
      _$MealImpl(
        idMeal:
            null == idMeal
                ? _value.idMeal
                : idMeal // ignore: cast_nullable_to_non_nullable
                    as String,
        strMeal:
            null == strMeal
                ? _value.strMeal
                : strMeal // ignore: cast_nullable_to_non_nullable
                    as String,
        strCategory:
            null == strCategory
                ? _value.strCategory
                : strCategory // ignore: cast_nullable_to_non_nullable
                    as String,
        strArea:
            null == strArea
                ? _value.strArea
                : strArea // ignore: cast_nullable_to_non_nullable
                    as String,
        strMealThumb:
            null == strMealThumb
                ? _value.strMealThumb
                : strMealThumb // ignore: cast_nullable_to_non_nullable
                    as String,
        strInstructions:
            null == strInstructions
                ? _value.strInstructions
                : strInstructions // ignore: cast_nullable_to_non_nullable
                    as String,
        strYoutube:
            null == strYoutube
                ? _value.strYoutube
                : strYoutube // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MealImpl implements _Meal {
  const _$MealImpl({
    required this.idMeal,
    required this.strMeal,
    required this.strCategory,
    required this.strArea,
    required this.strMealThumb,
    required this.strInstructions,
    required this.strYoutube,
  });

  factory _$MealImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealImplFromJson(json);

  @override
  final String idMeal;
  @override
  final String strMeal;
  @override
  final String strCategory;
  @override
  final String strArea;
  @override
  final String strMealThumb;
  @override
  final String strInstructions;
  @override
  final String strYoutube;

  @override
  String toString() {
    return 'Meal(idMeal: $idMeal, strMeal: $strMeal, strCategory: $strCategory, strArea: $strArea, strMealThumb: $strMealThumb, strInstructions: $strInstructions, strYoutube: $strYoutube)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealImpl &&
            (identical(other.idMeal, idMeal) || other.idMeal == idMeal) &&
            (identical(other.strMeal, strMeal) || other.strMeal == strMeal) &&
            (identical(other.strCategory, strCategory) ||
                other.strCategory == strCategory) &&
            (identical(other.strArea, strArea) || other.strArea == strArea) &&
            (identical(other.strMealThumb, strMealThumb) ||
                other.strMealThumb == strMealThumb) &&
            (identical(other.strInstructions, strInstructions) ||
                other.strInstructions == strInstructions) &&
            (identical(other.strYoutube, strYoutube) ||
                other.strYoutube == strYoutube));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    idMeal,
    strMeal,
    strCategory,
    strArea,
    strMealThumb,
    strInstructions,
    strYoutube,
  );

  /// Create a copy of Meal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealImplCopyWith<_$MealImpl> get copyWith =>
      __$$MealImplCopyWithImpl<_$MealImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealImplToJson(this);
  }
}

abstract class _Meal implements Meal {
  const factory _Meal({
    required final String idMeal,
    required final String strMeal,
    required final String strCategory,
    required final String strArea,
    required final String strMealThumb,
    required final String strInstructions,
    required final String strYoutube,
  }) = _$MealImpl;

  factory _Meal.fromJson(Map<String, dynamic> json) = _$MealImpl.fromJson;

  @override
  String get idMeal;
  @override
  String get strMeal;
  @override
  String get strCategory;
  @override
  String get strArea;
  @override
  String get strMealThumb;
  @override
  String get strInstructions;
  @override
  String get strYoutube;

  /// Create a copy of Meal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealImplCopyWith<_$MealImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
