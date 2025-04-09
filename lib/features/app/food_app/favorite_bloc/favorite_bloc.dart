import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'favorite_event.dart';
import 'favorite_state.dart';
import 'package:itc_food/data/models/meal_model.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final SharedPreferences prefs;
  static const String _favoritesKey = 'favorites';

  FavoriteBloc(this.prefs) : super(FavoriteInitial()) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<RemoveFavoriteEvent>(_onRemoveFavorite);
  }

  Future<void> _onLoadFavorites(LoadFavoritesEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoading());
    try {
      final String? favoritesJson = prefs.getString(_favoritesKey);
      if (favoritesJson != null) {
        final List<dynamic> decoded = json.decode(favoritesJson);
        final favorites = decoded.map((json) => Meal.fromJson(json)).toList();
        emit(FavoriteLoaded(favorites));
      } else {
        emit(FavoriteLoaded([]));
      }
    } catch (e) {
      emit(FavoriteError('Lỗi khi tải danh sách yêu thích'));
    }
  }

  Future<void> _onToggleFavorite(ToggleFavoriteEvent event, Emitter<FavoriteState> emit) async {
    try {
      final String? favoritesJson = prefs.getString(_favoritesKey);
      List<Meal> favorites = [];
      
      if (favoritesJson != null) {
        final List<dynamic> decoded = json.decode(favoritesJson);
        favorites = decoded.map((json) => Meal.fromJson(json)).toList();
      }

      final isFavorite = favorites.any((meal) => meal.idMeal == event.meal.idMeal);
      
      if (isFavorite) {
        favorites.removeWhere((meal) => meal.idMeal == event.meal.idMeal);
      } else {
        favorites.add(event.meal);
      }

      final encoded = json.encode(favorites.map((meal) => meal.toJson()).toList());
      await prefs.setString(_favoritesKey, encoded);
      
      emit(FavoriteLoaded(favorites));
    } catch (e) {
      emit(FavoriteError('Lỗi khi cập nhật danh sách yêu thích'));
    }
  }

  Future<void> _onRemoveFavorite(RemoveFavoriteEvent event, Emitter<FavoriteState> emit) async {
    try {
      final String? favoritesJson = prefs.getString(_favoritesKey);
      if (favoritesJson != null) {
        final List<dynamic> decoded = json.decode(favoritesJson);
        List<Meal> favorites = decoded.map((json) => Meal.fromJson(json)).toList();
        
        favorites.removeWhere((meal) => meal.idMeal == event.mealId);
        
        final encoded = json.encode(favorites.map((meal) => meal.toJson()).toList());
        await prefs.setString(_favoritesKey, encoded);
        
        emit(FavoriteLoaded(favorites));
      }
    } catch (e) {
      emit(FavoriteError('Lỗi khi xóa món ăn khỏi danh sách yêu thích'));
    }
  }
} 