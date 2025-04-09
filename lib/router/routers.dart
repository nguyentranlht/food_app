import 'package:geolocator/geolocator.dart';
import 'package:itc_food/data/models/meal_model.dart';
import 'package:itc_food/features/app/food_app/screen/main_screen.dart';
import 'package:itc_food/features/app/food_app/screen/history_orders_screen.dart';
import 'package:itc_food/features/app/food_app/screen/meal_detail_screen.dart';
import 'package:itc_food/features/app/food_app/screen/root_screen.dart';
import 'package:itc_food/features/app/food_app/screen/selected_foods_screen.dart';
import 'package:itc_food/features/app/food_app/screen/settings_screen.dart';
import 'package:itc_food/features/app/food_app/screen/update_profile_screen.dart';
import 'package:itc_food/features/location/screens/location_screen.dart';
import 'package:itc_food/features/location/screens/location_picker_screen.dart';
import 'package:itc_food/features/app/food_app/screen/order_tracking_screen.dart';
import 'package:itc_food/features/app/food_app/screen/profile_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:itc_food/features/features.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoutesPages {
  RoutesPages._();
  factory RoutesPages() {
    if (!_i._isInitial) {
      _i._isInitial = true;
      _i._getRoutes();
    }
    return _i;
  }
  static final RoutesPages _i = RoutesPages._();
  bool _isInitial = false;

  static const root = '/';
  static const splash = '/splash';
  static const start = '/start';
  static const login = '/login';
  static const signup = '/signup';
  static const main = '/main';
  static const location = '/location';
  static const tracking = '/tracking';
  static const orders = '/orders';
  static const profile = '/profile';
  static const selectedFoods = '/selectedFoods';
  static const mealDetail = '/mealDetail';
  static const settings = '/settings';
  static const locationPicker = '/locationPicker';
  static const updateProfile = '/update-profile';

  late final GoRouter _router;
  static GoRouter get router => _i._router;

  late final List<GoRoute> _routesList;

  Future<void> _getRoutes() async {
    _routesList = [
      GoRoute(path: root, builder: (context, state) => const RootScreen(isLoggedIn: false)),
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: start, builder: (context, state) => const StartScreen()),
      GoRoute(path: login, builder: (context, state) => const LoginScreen()),
      GoRoute(path: signup, builder: (context, state) => const SignUpScreen()),
      GoRoute(path: main, builder: (context, state) => const MainScreen()),
      GoRoute(path: location, builder: (context, state) => const LocationScreen()),
      GoRoute(path: tracking, builder: (context, state) => const OrderTrackingScreen()),
      GoRoute(path: orders, builder: (context, state) => const HistoryOrdersScreen()),
      GoRoute(path: profile, builder: (context, state) => const ProfileScreen()),
      GoRoute(path: selectedFoods, builder: (context, state) => const SelectedFoodsScreen()),
      GoRoute(path: mealDetail, builder: (context, state) {
        final meal = state.extra as Meal; // nhận dữ liệu qua extra
        return MealDetailScreen(meal: meal);
      },),
      GoRoute(path: settings, builder: (context, state) => const SettingScreen()),
      GoRoute(path: locationPicker, builder: (context, state){
        final initialPosition = state.extra as Position?;
        return LocationPickerScreen(initialPosition: initialPosition);
      }),
      GoRoute(
        path: updateProfile,
        builder: (context, state) => const UpdateProfileScreen(),
      ),
    ];

    final prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    _router = GoRouter(
      initialLocation: isLoggedIn ? main : splash,
      routes: _routesList,
    );
  }
}
