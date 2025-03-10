import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/meal_bloc/meal_bloc.dart';
import 'package:food_app/bloc/meal_bloc/meal_event.dart';
import 'package:food_app/bloc/meal_bloc/meal_state.dart';
import '../widgets/section_title.dart';
import '../widgets/video_item.dart';
import '../widgets/category_item.dart';
import '../widgets/recipe_item.dart';
import '../widgets/ingredient_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
void initState() {
  super.initState();
  Future.microtask(() {
    if (mounted) {
      context.read<MealBloc>().add(FetchAllMealsEvent());
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 70),

            // Thanh tìm kiếm
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Tìm kiếm sản phẩm",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Danh sách video nổi bật (Lấy từ Bloc)
            SectionTitle(title: "TP. Hồ Chí Minh", onViewAll: () {}),
            SizedBox(
              height: 270,
              child: BlocBuilder<MealBloc, MealState>(
                builder: (context, state) {
                  if (state is MealLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MealLoaded) {
                    final meals = state.meals.where((meal) => meal.strYoutube != null).toList();
                    if (meals.isEmpty) {
                      return const Center(child: Text("Không có video nào"));
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: 6,
                      itemBuilder: (context, index) => VideoItem(meal: meals[index]),
                    );
                  } else if (state is MealError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text("Tải dữ liệu..."));
                },
              ),
            ),

            const SizedBox(height: 10),

            // Danh mục món ăn
            SectionTitle(title: "Danh mục", onViewAll: () {}),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    4,
                    (index) => IngredientItem(item: (index + 1)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 213,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 4,
                itemBuilder: (context, index) => const CategoryItem(),
              ),
            ),
            const SizedBox(height: 10),

            // Công thức gần đây
            SectionTitle(title: "Công thức gần đây", onViewAll: () {}),
            SizedBox(
              height: 213,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 4,
                itemBuilder: (context, index) => const RecipeItem(),
              ),
            ),

            const SizedBox(height: 10),

            // Nguyên liệu
            SectionTitle(title: "Nguyên liệu", onViewAll: () {}),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SizedBox(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    4,
                    (index) => IngredientItem(item: (index + 1)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    4,
                    (index) => IngredientItem(item: (index + 1)),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}