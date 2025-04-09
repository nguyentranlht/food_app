import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:itc_food/data/models/meal_model.dart';
import 'package:itc_food/features/app/food_app/favorite_bloc/favorite_bloc.dart';
import 'package:itc_food/features/app/food_app/favorite_bloc/favorite_state.dart';
import 'package:itc_food/router/routers.dart';

class FoodItem extends StatelessWidget {
  final Meal meal;
  final Function(bool)? onFavoriteChanged;

  const FoodItem({
    super.key,
    required this.meal,
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

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              context.push(RoutesPages.mealDetail, extra: meal);
            },
            borderRadius: BorderRadius.circular(12),
            child: Row(
              children: [
                // Hình ảnh bên trái
                ClipRRect(
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                  child: Image.network(
                    meal.strMealThumb,
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                // Thông tin bên phải
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tên nhà hàng và đánh giá
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                meal.strMeal,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.amber.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.star, color: Colors.amber, size: 14),
                                      const SizedBox(width: 2),
                                      Text(
                                        '4.5',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                InkWell(
                                  onTap: () {
                                    onFavoriteChanged?.call(!isFavorite);
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: isFavorite ? Colors.red.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Icon(
                                      isFavorite ? Icons.favorite : Icons.favorite_border,
                                      color: isFavorite ? Colors.red : Colors.grey,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Loại và khu vực
                        Row(
                          children: [
                            Icon(Icons.category, size: 14, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Text(
                              meal.strCategory,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                meal.strArea,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Thời gian và khoảng cách
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.timer, size: 12, color: Colors.green[700]),
                                  const SizedBox(width: 4),
                                  Text(
                                    '15-20\'',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.green[700],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.motorcycle, size: 12, color: Colors.blue[700]),
                                  const SizedBox(width: 4),
                                  Text(
                                    '2.1 km',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.blue[700],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.delivery_dining, size: 12, color: Colors.orange[700]),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Free',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.orange[700],
                                      fontWeight: FontWeight.bold,
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}