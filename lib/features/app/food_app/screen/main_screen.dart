import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itc_food/data/repository/meal_repo.dart';
import 'package:itc_food/features/app/food_app/food_bloc/food_bloc.dart';
import 'package:itc_food/features/app/food_app/screen/favorite_screen.dart';
import 'package:itc_food/features/app/food_app/screen/home_store_screen.dart';
import 'package:itc_food/features/app/food_app/screen/history_orders_screen.dart';
import 'package:itc_food/features/app/food_app/screen/profile_screen.dart';
import 'package:itc_food/features/app/food_app/screen/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MealBloc(MealRepo()),
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const HomeStoreScreen(),
            const SearchScreen(),
            const HistoryOrdersScreen(),
            const FavoriteScreen(),
            const ProfileScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.amber[500],
          unselectedItemColor: Colors.grey[600],
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Tìm kiếm',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              label: 'Đơn hàng',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline),
              label: 'Yêu thích',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Cá nhân',
            ),
          ],
        ),
      ),
    );
  }
}