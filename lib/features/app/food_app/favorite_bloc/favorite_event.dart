import 'package:equatable/equatable.dart';
import 'package:itc_food/data/models/meal_model.dart';

abstract class FavoriteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ToggleFavoriteEvent extends FavoriteEvent {
  final Meal meal;

  ToggleFavoriteEvent(this.meal);

  @override
  List<Object> get props => [meal];
}

class LoadFavoritesEvent extends FavoriteEvent {}

class RemoveFavoriteEvent extends FavoriteEvent {
  final String mealId;

  RemoveFavoriteEvent(this.mealId);

  @override
  List<Object> get props => [mealId];
} 