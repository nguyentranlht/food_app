import 'package:equatable/equatable.dart';
import 'package:itc_food/data/models/meal_model.dart';

abstract class FavoriteState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<Meal> favorites;
  
  FavoriteLoaded(this.favorites);

  @override
  List<Object> get props => [favorites];
}

class FavoriteError extends FavoriteState {
  final String message;
  
  FavoriteError(this.message);

  @override
  List<Object> get props => [message];
} 