import 'package:get_it/get_it.dart';
import 'package:itc_food/features/app/food_app/favorite_bloc/favorite_event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:itc_food/features/authentication/auth_bloc/auth_bloc.dart';
import 'package:itc_food/features/authentication/data/auth_repository.dart';
import 'package:itc_food/features/location/location_bloc/location_bloc.dart';
import 'package:itc_food/features/app/food_app/favorite_bloc/favorite_bloc.dart';
import 'package:itc_food/features/app/food_app/cart_bloc/cart_bloc.dart';
import 'package:itc_food/features/app/food_app/order_bloc/order_bloc.dart';
import 'package:itc_food/features/app/food_app/services/stripe_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  // Stripe Service
  await StripeService.init();

  // Load .env file
  await dotenv.load(fileName: ".env");

  // Repositories
  getIt.registerSingleton<AuthRepository>(AuthRepository());

  // Blocs
  getIt.registerFactory(() => AuthBloc(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => LocationBloc());
  getIt.registerFactory(() => FavoriteBloc(getIt<SharedPreferences>())..add(LoadFavoritesEvent()));
  getIt.registerFactory(() => CartBloc(prefs: getIt<SharedPreferences>()));
  getIt.registerFactory(() => OrderBloc(prefs: getIt<SharedPreferences>()));
}
