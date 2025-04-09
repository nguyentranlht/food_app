import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_model.freezed.dart';
part 'meal_model.g.dart';

@freezed
class Meal with _$Meal {
  const factory Meal({
    required String idMeal,
    required String strMeal,
    required String strCategory,
    required String strArea,
    required String strMealThumb,
    required String strInstructions,
    required String strYoutube,
  }) = _Meal;

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);
}