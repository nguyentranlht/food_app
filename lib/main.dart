import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itc_food/data/di/service_locator.dart';
import 'package:itc_food/features/app/food_app/cart_bloc/cart_bloc.dart';
import 'package:itc_food/features/app/food_app/favorite_bloc/favorite_bloc.dart';
import 'package:itc_food/features/app/food_app/order_bloc/order_bloc.dart';
import 'package:itc_food/features/authentication/auth_bloc/auth_bloc.dart';
import 'package:itc_food/features/location/location_bloc/location_bloc.dart';
import 'package:itc_food/features/location/location_bloc/location_event.dart';
import 'package:itc_food/router/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:itc_food/features/app/food_app/services/stripe_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupServiceLocator(); // Initialize dependencies
  RoutesPages();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize Stripe
  await StripeService.init();

  // Load .env file
  await dotenv.load(fileName: ".env");

  runApp(MyApp());
}

// Widget để khởi tạo vị trí khi app khởi động
class LocationInitializer extends StatefulWidget {
  final Widget child;

  const LocationInitializer({super.key, required this.child});

  @override
  State<LocationInitializer> createState() => _LocationInitializerState();
}

class _LocationInitializerState extends State<LocationInitializer> {
  @override
  void initState() {
    super.initState();
    // Khởi tạo vị trí khi app khởi động
    Future.microtask(() {
      final locationBloc = getIt<LocationBloc>();
      locationBloc.add(LocationCheckPermission());
      locationBloc.add(LocationGetCurrent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<AuthBloc>()),
            BlocProvider(create: (context) => getIt<LocationBloc>()),
            BlocProvider(
              create: (context) {
                final bloc = getIt<FavoriteBloc>();
                return bloc;
              },
            ),
            BlocProvider(create: (context) => getIt<CartBloc>()),
            BlocProvider(create: (context) => getIt<OrderBloc>()),
          ],
          child: LocationInitializer(
            child: MaterialApp.router(
              title: 'ITC Food',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
                useMaterial3: true,
              ),
              routerConfig: RoutesPages.router,
              builder: EasyLoading.init(),
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('vi', 'VN'),
                Locale('en', 'US'),
              ],
            ),
          ),
        );
      },
    );
  }
}
