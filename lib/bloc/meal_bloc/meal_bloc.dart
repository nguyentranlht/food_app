import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/services/meal_service.dart';
import 'meal_event.dart';
import 'meal_state.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  final MealService mealService;

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