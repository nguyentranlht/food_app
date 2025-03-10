import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/meal_bloc/meal_bloc.dart';
import 'package:food_app/bloc/meal_bloc/meal_event.dart';
import 'package:food_app/bloc/meal_bloc/meal_state.dart';
import '../models/meal_model.dart';

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
            padding: const EdgeInsets.only(
              top: 70,
              bottom: 10,
              left: 16,
              right: 16,
            ),
            child: TextField(
              controller: _searchController,
              onSubmitted: (_) => _searchMeals(),
              decoration: InputDecoration(
                hintText: "Tìm kiếm sản phẩm",
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
                      child: Text(
                        'Không tìm thấy món ăn',
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.meals.length,
                    itemBuilder: (context, index) {
                      final meal = state.meals[index];
                      return ListTile(
                        title: Text(
                          meal.strMeal,
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Colors.amber,
                        ),
                        onTap: () {
                          // Mở trang chi tiết món ăn
                        },
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
                  child: Text(
                    'Nhập từ khóa để tìm kiếm',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
