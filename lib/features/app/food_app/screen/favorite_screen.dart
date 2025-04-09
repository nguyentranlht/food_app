import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itc_food/features/app/food_app/favorite_bloc/favorite_bloc.dart';
import 'package:itc_food/features/app/food_app/favorite_bloc/favorite_event.dart';
import 'package:itc_food/features/app/food_app/favorite_bloc/favorite_state.dart';
import 'package:itc_food/share/widgets/food_item.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Món ăn yêu thích',
          style: TextStyle(
            color: Color(0xFF734C10),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
          if (state is FavoriteError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          
          if (state is FavoriteLoaded) {
            if (state.favorites.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Chưa có món ăn yêu thích',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final meal = state.favorites[index];
                return FoodItem(
                  meal: meal,
                  onFavoriteChanged: (isFavorite) {
                    if (!isFavorite) {
                      context.read<FavoriteBloc>().add(
                        RemoveFavoriteEvent(meal.idMeal),
                      );
                    }
                  },
                );
              },
            );
          }

          return const SizedBox(); // FavoriteInitial state
        },
      ),
    );
  }
}