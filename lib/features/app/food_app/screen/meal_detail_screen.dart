import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:itc_food/data/models/meal_model.dart';
import 'package:itc_food/features/app/food_app/cart_bloc/cart_bloc.dart';
import 'package:itc_food/features/app/food_app/cart_bloc/cart_event.dart';
import 'package:itc_food/features/app/food_app/favorite_bloc/favorite_bloc.dart';
import 'package:itc_food/features/app/food_app/favorite_bloc/favorite_event.dart';
import 'package:itc_food/features/app/food_app/favorite_bloc/favorite_state.dart';

class MealDetailScreen extends StatefulWidget {
  final Meal meal;

  const MealDetailScreen({super.key, required this.meal});

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  late Meal meal;
  int quantity = 1;
  String selectedSize = 'Personal';
  int basePrice = 140000;
  int originalPrice = 200000;
  List<String> selectedToppings = [];
  final TextEditingController _noteController = TextEditingController();
  
  final List<Map<String, dynamic>> portions = [
    {'name': 'Personal (4 Miếng)', 'price': 0},
    {'name': 'Medium (8 Miếng)', 'price': 30000},
    {'name': 'Familiar (10 Miếng)', 'price': 60000},
    {'name': 'Jumbo (12 Miếng)', 'price': 100000},
  ];

  final List<Map<String, dynamic>> toppings = [
    {'name': 'Thêm phô mai', 'price': 5000},
    {'name': 'Thêm trứng', 'price': 8000},
    {'name': 'Thêm thịt', 'price': 15000},
    {'name': 'Thêm rau', 'price': 3000},
  ];

  @override
  void initState() {
    super.initState();
    meal = widget.meal;
  }

  int get totalPrice {
    int portionPrice = portions.firstWhere((p) => p['name'].startsWith(selectedSize))['price'];
    int toppingsPrice = selectedToppings.fold(0, (sum, topping) {
      return sum + (toppings.firstWhere((t) => t['name'] == topping)['price'] as int);
    });
    return (basePrice + portionPrice + toppingsPrice) * quantity;
  }

  String formatPrice(int price) {
    return '${price.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (match) => '${match[1]},')}đ';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.amber),
            onPressed: () => context.pop(),
          ),
        ),
        actions: [
          // Nút yêu thích
          BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              bool isFavorite = false;
              if (state is FavoriteLoaded) {
                isFavorite = state.favorites.any((favorite) => favorite.idMeal == meal.idMeal);
              }

              return Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.amber,
                  ),
                  onPressed: () {
                    context.read<FavoriteBloc>().add(
                      ToggleFavoriteEvent(meal),
                    );
                    // Hiển thị thông báo
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isFavorite ? 'Đã xóa khỏi danh sách yêu thích' : 'Đã thêm vào danh sách yêu thích',
                        ),
                        duration: const Duration(seconds: 1),
                        backgroundColor: isFavorite ? Colors.grey : Colors.green,
                      ),
                    );
                  },
                ),
              );
            },
          ),
          // Nút chia sẻ
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.share, color: Colors.amber),
              onPressed: () {
                // TODO: Xử lý chia sẻ
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Đang chia sẻ món ăn...'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hình ảnh và badge giảm giá
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(meal.strMealThumb),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      '-30%',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Giá và tên món
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        formatPrice(basePrice),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        formatPrice(originalPrice),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                if (quantity > 1) {
                                  setState(() => quantity--);
                                }
                              },
                            ),
                            Text(
                              quantity.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => setState(() => quantity++),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    meal.strMeal,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            // Phần chọn size
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Khẩu phần',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...portions.map((portion) {
                    bool isSelected = portion['name'].startsWith(selectedSize);
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected ? Colors.amber : Colors.grey[300]!,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: RadioListTile<String>(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(portion['name']),
                            Text(
                              portion['price'] == 0 ? 'Miễn phí' : formatPrice(portion['price']),
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        value: portion['name'].split(' ')[0],
                        groupValue: selectedSize,
                        onChanged: (value) => setState(() => selectedSize = value!),
                        activeColor: Colors.amber,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Phần chọn topping
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Topping',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 3,
                    children: toppings.map((topping) {
                      final isSelected = selectedToppings.contains(topping['name']);
                      return Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.amber[100] : Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected ? Colors.amber : Colors.grey[300]!,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedToppings.remove(topping['name']);
                              } else {
                                selectedToppings.add(topping['name']);
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    topping['name'],
                                    style: TextStyle(
                                      color: isSelected ? Colors.amber[900] : Colors.grey[800],
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Text(
                                  '+${formatPrice(topping['price'])}',
                                  style: TextStyle(
                                    color: isSelected ? Colors.amber[900] : Colors.grey[600],
                                    fontSize: 12,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Phần ghi chú
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ghi chú đặc biệt',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _noteController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Nhập ghi chú của bạn (nếu có)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tổng tiền',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    formatPrice(totalPrice),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<CartBloc>().add(
                  AddToCartEvent(
                    meal: meal,
                    quantity: quantity,
                    selectedSize: selectedSize,
                    selectedToppings: selectedToppings,
                    note: _noteController.text,
                  ),
                );
                // Hiển thị thông báo
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Đã thêm món vào giỏ hàng'),
                    duration: Duration(seconds: 1),
                    backgroundColor: Colors.green,
                  ),
                );
                // Quay lại màn hình trước
                context.pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Thêm vào giỏ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}