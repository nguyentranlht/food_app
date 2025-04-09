import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itc_food/data/models/meal_model.dart';
import 'package:itc_food/features/app/food_app/favorite_bloc/favorite_bloc.dart';
import 'package:itc_food/features/app/food_app/favorite_bloc/favorite_state.dart';

class RecipeItem extends StatelessWidget {
  final Meal meal;
  final VoidCallback? onTap;
  final Function(bool)? onFavoriteChanged;

  const RecipeItem({
    super.key,
    required this.meal,
    this.onTap,
    this.onFavoriteChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        bool isFavorite = false;
        if (state is FavoriteLoaded) {
          isFavorite = state.favorites.any((favorite) => favorite.idMeal == meal.idMeal);
        }

        return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 153,
                      height: 133,
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(
                        meal.strMealThumb,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.error),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 24,
                      child: GestureDetector(
                        onTap: () {
                          onFavoriteChanged?.call(!isFavorite);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  meal.strMeal,
                  style: const TextStyle(
                    color: Color(0xFF734C10),
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 1.33,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEEE5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.local_offer,
                            color: Color(0xFFE26A2C),
                            size: 12,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Giảm ${25}%',
                            style: const TextStyle(
                              color: Color(0xFFE26A2C),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
