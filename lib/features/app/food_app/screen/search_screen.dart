import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:itc_food/features/app/food_app/food_bloc/food_bloc.dart';
import 'package:itc_food/features/app/food_app/food_bloc/food_event.dart';
import 'package:itc_food/features/app/food_app/food_bloc/food_state.dart';
import 'package:itc_food/router/routers.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  void _searchMeals() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      context.read<MealBloc>().add(SearchMealEvent(query));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Đưa thanh tìm kiếm sát phần trên cùng
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 70, bottom: 10, left: 16, right: 16),
            child: TextField(
              controller: _searchController,
              onSubmitted: (_) => _searchMeals(),
              decoration: InputDecoration(
                hintText: "Tìm nhà hàng, món ăn",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Kết quả tìm kiếm ngay sát ô tìm kiếm
          Expanded(
            child: BlocBuilder<MealBloc, MealState>(
              builder: (context, state) {
                if (state is MealLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MealLoaded) {
                  if (state.meals.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Không tìm thấy món ăn',
                          style: TextStyle(fontSize: 16)),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.meals.length,
                    itemBuilder: (context, index) {
                      final meal = state.meals[index];
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            meal.strMealThumb,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(meal.strMeal,
                            style: TextStyle(fontSize: 16)),
                        subtitle: Text("${meal.strCategory} - ${meal.strArea}",
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        trailing: Icon(Icons.chevron_right, color: Colors.amber),
                        onTap: () => context.push(RoutesPages.mealDetail, extra: meal),
                      );
                    },
                  );
                } else if (state is MealError) {
                  return Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(state.message, style: TextStyle(fontSize: 16)),
                  );
                }
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Nhập từ khóa để tìm kiếm',
                      style: TextStyle(fontSize: 16)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}