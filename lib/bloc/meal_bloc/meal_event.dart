import 'package:equatable/equatable.dart';

abstract class MealEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class FetchAllMealsEvent extends MealEvent {}
class SearchMealEvent extends MealEvent {
  final String query;
  
  SearchMealEvent(this.query);

  @override
  List<Object> get props => [query];
}