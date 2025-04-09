import 'package:flutter/material.dart';
import 'package:itc_food/features/app/food_app/screen/main_screen.dart';
import 'package:itc_food/features/authentication/screen/login_screen.dart';

class RootScreen extends StatelessWidget {
  final bool isLoggedIn;

  const RootScreen({
    super.key,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? const MainScreen() : const LoginScreen();
  }
} 