import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/meal_bloc/meal_bloc.dart';
import 'package:food_app/screens/save_recipes_screen.dart';
import 'package:food_app/screens/home_screen.dart';
import 'package:food_app/screens/search_screen.dart';
import 'package:food_app/screens/add_screen.dart';
import 'package:food_app/screens/profile_screen.dart';
import 'package:food_app/services/meal_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    if (index == 2) return; // Không thay đổi selectedIndex khi bấm nút (+)
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAddButtonTapped() {
    // Chuyển sang trang AddScreen hoặc mở modal
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MealBloc(MealService()),
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            HomeScreen(),
            SearchScreen(),
            Container(), // Trang rỗng vì nút (+) không cần PageView
            RecipeScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: Stack(
          clipBehavior: Clip.none, // Cho phép nút (+) nhô lên trên BottomAppBar
          children: [
            BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 10, // Khoảng cách rãnh cho nút (+)
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, Icons.home, "Trang chủ"),
                  _buildNavItem(1, Icons.search, "Tìm kiếm"),
                  SizedBox(width: 48), // Chừa chỗ cho nút (+)
                  _buildNavItem(3, Icons.bookmark_outline, "Yêu thích"),
                  _buildNavItem(4, Icons.person_outline, "Cá nhân"),
                ],
              ),
            ),
            Positioned(
              bottom: 70, // Điều chỉnh để nút nổi lên trên
              left: MediaQuery.of(context).size.width / 2 - 30,
              child: FloatingActionButton(
                backgroundColor: Colors.amber,
                shape: CircleBorder(),
                child: Icon(Icons.add, size: 32, color: Colors.white),
                onPressed: _onAddButtonTapped,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget để tạo Item cho Bottom Navigation Bar
  Widget _buildNavItem(int index, IconData icon, String label) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _selectedIndex == index ? Colors.amber : Colors.grey, size: 24),
        ],
      ),
    );
  }
}