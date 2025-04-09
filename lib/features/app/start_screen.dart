import 'package:itc_food/router/routers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void login() {
    context.push(RoutesPages.login);
  }

  void signUp() {
    context.push(RoutesPages.signup);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff89B646),
      body: Stack(
        children: [
          // Ảnh nền đảm bảo phủ kín 100% màn hình
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Home.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),

          // Lớp overlay làm tối nền
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.3),
          ),

          // Nội dung chính
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Bắt đầu với những món ăn",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Nút bấm
              _buildButton(title: "Đăng ký", onPressed: signUp),
              const SizedBox(height: 20),

              // Nút bấm
              _buildButton(title: "Đăng nhập", onPressed: login),
              const SizedBox(height: 50),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton({required String title, VoidCallback? onPressed}) {
    return SizedBox(
      width: 200,
      child: OutlinedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: TextStyle(fontSize: 18, color: Colors.black)),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
