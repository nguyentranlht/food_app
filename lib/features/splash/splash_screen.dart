import 'package:itc_food/router/routers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  SplashScreenState() : super();

  @override
  initState() {
    super.initState();
    initResource();
  }

  Future<void> initResource() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.go(RoutesPages.start);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0xffffffff),
        image: DecorationImage(
          image: AssetImage("assets/images/Home.png"),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
