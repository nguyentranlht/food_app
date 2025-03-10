import 'package:flutter/material.dart';
import 'screens/start_screen.dart';  // Import màn hình mới

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const StartScreen(),  // Màn hình đầu tiên
    );
  }
}