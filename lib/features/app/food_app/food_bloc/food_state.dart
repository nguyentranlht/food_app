import 'package:equatable/equatable.dart';
import 'package:itc_food/data/models/meal_model.dart';

abstract class MealState extends Equatable {
  @override
  List<Object> get props => [];
}

class MealInitial extends MealState {}

class MealLoading extends MealState {}

class MealLoaded extends MealState {
  final List<Meal> meals;
  
  MealLoaded(this.meals);

  @override
  List<Object> get props => [meals];
}

class MealError extends MealState {
  final String message;
  
  MealError(this.message);

  @override
  List<Object> get props => [message];
}