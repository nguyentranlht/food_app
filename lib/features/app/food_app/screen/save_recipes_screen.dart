import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:itc_food/features/app/food_app/food_bloc/food_bloc.dart';
import 'package:itc_food/features/app/food_app/food_bloc/food_state.dart';
import 'package:itc_food/share/widgets/video_item.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.brown),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          "Công thức",
          style: TextStyle(
            color: Colors.brown,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Thanh chọn "Video" - "Công thức"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Video",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Công thức",
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          
          // Danh sách công thức lấy từ Bloc
          Expanded(
            child: BlocBuilder<MealBloc, MealState>(
              builder: (context, state) {
                if (state is MealLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MealLoaded) {
                  final meals = state.meals.toList();
                  if (meals.isEmpty) {
                    return const Center(child: Text("Không có video nào"));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: meals.length,
                    itemBuilder: (context, index) => VideoItem(meal: meals[index]),
                  );
                } else if (state is MealError) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: Text("Tải dữ liệu..."));
              },
            ),
          ),
        ],
      ),
    );
  }
}