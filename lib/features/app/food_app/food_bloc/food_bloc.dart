import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itc_food/data/repository/meal_repo.dart';
import 'food_event.dart';
import 'food_state.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  final MealRepo mealService;

  MealBloc(this.mealService) : super(MealInitial()) {
    on<FetchAllMealsEvent>((event, emit) async {
      emit(MealLoading());
      try {
        final meals = await mealService.fetchAllMeals();
        emit(MealLoaded(meals));
      } catch (e) {
        emit(MealError("Lỗi tải danh sách món ăn"));
      }
    });
    on<SearchMealEvent>((event, emit) async {
      emit(MealLoading());
      try {
        final meals = await mealService.searchMeals(event.query);
        emit(MealLoaded(meals));
      } catch (e) {
        emit(MealError("Lỗi khi tải dữ liệu"));
      }
    });
  }
}