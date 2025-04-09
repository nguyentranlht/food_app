import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:itc_food/features/app/food_app/cart_bloc/cart_bloc.dart';
import 'package:itc_food/features/app/food_app/cart_bloc/cart_state.dart';
import 'package:itc_food/features/app/food_app/food_bloc/food_bloc.dart';
import 'package:itc_food/features/app/food_app/food_bloc/food_event.dart';
import 'package:itc_food/features/app/food_app/food_bloc/food_state.dart';
import 'package:itc_food/features/app/food_app/favorite_bloc/favorite_bloc.dart';
import 'package:itc_food/features/app/food_app/favorite_bloc/favorite_event.dart';
import 'package:itc_food/features/location/location_bloc/location_bloc.dart';
import 'package:itc_food/features/location/location_bloc/location_state.dart';
import 'package:itc_food/router/routers.dart';
import '../../../../share/widgets/widgets.dart';

class HomeStoreScreen extends StatefulWidget {
  const HomeStoreScreen({super.key});

  @override
  _HomeStoreScreenState createState() => _HomeStoreScreenState();
}

class _HomeStoreScreenState extends State<HomeStoreScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        // Chỉ lấy danh sách món ăn
        context.read<MealBloc>().add(FetchAllMealsEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Bar với địa chỉ
            Container(
              padding: const EdgeInsets.only(
                top: 50,
                left: 16,
                right: 16,
                bottom: 10,
              ),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: BlocBuilder<LocationBloc, LocationState>(
                          builder: (context, state) {
                            return InkWell(
                              onTap: () => context.push(RoutesPages.location),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Giao hàng đến',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                  if (state.status == LocationStatus.loading)
                                    const Text(
                                      'Đang lấy vị trí...',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  else if (state.status ==
                                          LocationStatus.failure ||
                                      state.status ==
                                          LocationStatus.permissionDenied ||
                                      state.status ==
                                          LocationStatus.serviceDisabled)
                                    Row(
                                      children: [
                                        const Text(
                                          'Chọn địa chỉ giao hàng',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Icon(
                                          Icons.error_outline,
                                          size: 16,
                                          color: Colors.red[400],
                                        ),
                                      ],
                                    )
                                  else
                                    Text(
                                      state.currentAddress ??
                                          'Chọn địa chỉ giao hàng',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: const Icon(Icons.person_outline),
                      ),
                      const SizedBox(width: 8),
                      Stack(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.shopping_cart_outlined),
                            onPressed: () => context.push(RoutesPages.selectedFoods),
                          ),
                          BlocBuilder<CartBloc, CartState>(
                            builder: (context, state) {
                              int itemCount = 0;
                              if (state is CartLoaded) {
                                itemCount = state.totalItems;
                              }
                              return itemCount > 0
                                  ? Positioned(
                                      right: 8,
                                      top: 8,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        constraints: const BoxConstraints(
                                          minWidth: 16,
                                          minHeight: 16,
                                        ),
                                        child: Text(
                                          itemCount.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  : const SizedBox();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Thanh tìm kiếm
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Tìm nhà hàng, món ăn",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                ],
              ),
            ),

            // Banner quảng cáo
            Container(
              height: 180,
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: PageView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage('assets/images/Image.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Video nổi bật
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Video nổi bật',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Xem tất cả'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 210,
              child: BlocBuilder<MealBloc, MealState>(
                builder: (context, state) {
                  if (state is MealLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MealLoaded) {
                    final meals = state.meals.toList();
                    if (meals.isEmpty) {
                      return const Center(child: Text("Không có video nào"));
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: meals.length > 6 ? 6 : meals.length,
                      itemBuilder:
                          (context, index) => VideoItem(meal: meals[index]),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),

            const SizedBox(height: 24),

            // Danh mục món ăn
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Text(
                      'Danh mục',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.9,
                    children: [
                      CategoryItem(icon: Icons.fastfood, label: 'Đồ ăn nhanh'),
                      CategoryItem(icon: Icons.local_pizza, label: 'Pizza'),
                      CategoryItem(icon: Icons.local_cafe, label: 'Đồ uống'),
                      CategoryItem(icon: Icons.icecream, label: 'Tráng miệng'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Đã xem gần đây',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Xem tất cả'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 213,
              child: BlocBuilder<MealBloc, MealState>(
                builder: (context, state) {
                  if (state is MealLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.amber),
                    );
                  }

                  if (state is MealError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (state is MealLoaded) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: state.meals.length,
                      itemBuilder:
                          (context, index) => RecipeItem(
                            meal: state.meals[index],
                            onTap: () {
                              context.push(RoutesPages.mealDetail, extra: state.meals[index]);
                            },
                            onFavoriteChanged: (isFavorite) {
                              context.read<FavoriteBloc>().add(
                                ToggleFavoriteEvent(state.meals[index])
                              );
                            },
                          ),
                    );
                  }

                  return const Center(child: Text('Không có dữ liệu'));
                },
              ),
            ),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Món ăn phổ biến',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Xem tất cả'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            BlocBuilder<MealBloc, MealState>(
              builder: (context, state) {
                if (state is MealLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MealLoaded) {
                  final meals = state.meals.toList();
                  if (meals.isEmpty) {
                    return const Center(child: Text("Không có nhà hàng nào"));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: meals.length > 5 ? 5 : meals.length,
                    itemBuilder: (context, index) {
                      return FoodItem(
                        meal: meals[index],
                        onFavoriteChanged: (isFavorite) {
                          context.read<FavoriteBloc>().add(
                            ToggleFavoriteEvent(meals[index])
                          );
                        },
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
