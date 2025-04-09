import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:itc_food/data/models/order_model.dart';
import 'package:itc_food/features/app/food_app/cart_bloc/cart_bloc.dart';
import 'package:itc_food/features/app/food_app/cart_bloc/cart_event.dart';
import 'package:itc_food/features/app/food_app/cart_bloc/cart_state.dart';
import 'package:itc_food/features/app/food_app/order_bloc/order_bloc.dart';
import 'package:itc_food/features/app/food_app/order_bloc/order_event.dart';
import 'package:itc_food/features/app/food_app/services/stripe_service.dart';
import 'package:itc_food/features/location/location_bloc/location_bloc.dart';
import 'package:itc_food/features/location/location_bloc/location_state.dart';
import 'package:itc_food/router/routers.dart';
import 'package:itc_food/share/widgets/food_item.dart';

class SelectedFoodsScreen extends StatelessWidget {
  const SelectedFoodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Giỏ hàng',
          style: TextStyle(
            color: Color(0xFF734C10),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CartError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is CartLoaded) {
            if (state.items.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Giỏ hàng trống',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            FoodItem(
                              meal: item.meal,
                              onFavoriteChanged: null,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Size: ${item.selectedSize}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (item.selectedToppings.isNotEmpty) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      'Topping: ${item.selectedToppings.join(", ")}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                  if (item.note != null && item.note!.isNotEmpty) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      'Ghi chú: ${item.note}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove_circle_outline),
                                            onPressed: () {
                                              if (item.quantity > 1) {
                                                context.read<CartBloc>().add(
                                                  UpdateCartItemEvent(
                                                    mealId: item.meal.idMeal,
                                                    quantity: item.quantity - 1,
                                                    selectedSize: item.selectedSize,
                                                    selectedToppings: item.selectedToppings,
                                                    note: item.note,
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                          Text(
                                            item.quantity.toString(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.add_circle_outline),
                                            onPressed: () {
                                              context.read<CartBloc>().add(
                                                UpdateCartItemEvent(
                                                  mealId: item.meal.idMeal,
                                                  quantity: item.quantity + 1,
                                                  selectedSize: item.selectedSize,
                                                  selectedToppings: item.selectedToppings,
                                                  note: item.note,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${(item.price * item.quantity).toInt().toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (match) => '${match[1]},')}đ',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.amber,
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete_outline),
                                            onPressed: () {
                                              context.read<CartBloc>().add(
                                                RemoveFromCartEvent(item.meal.idMeal),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Tổng số lượng:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            state.totalItems.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Tổng tiền:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${state.totalPrice.toInt().toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (match) => '${match[1]},')}đ',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              // Hiển thị loading
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );

                              // Thực hiện thanh toán
                              await StripeService.makePayment(
                                amount: state.totalPrice,
                                currency: 'vnd',
                                customerEmail: 'customer@example.com',
                              );

                              // Đóng loading
                              Navigator.pop(context);

                              // Tạo đơn hàng mới
                              final locationState = context.read<LocationBloc>().state;
                              if (locationState.status == LocationStatus.success) {
                                context.read<OrderBloc>().add(
                                  CreateOrderEvent(
                                    items: state.items.map((item) => OrderItem(
                                      meal: item.meal,
                                      quantity: item.quantity,
                                      selectedSize: item.selectedSize,
                                      selectedToppings: item.selectedToppings,
                                      price: item.price,
                                      note: item.note,
                                    )).toList(),
                                    totalPrice: state.totalPrice,
                                    address: locationState.currentAddress ?? '',
                                    phoneNumber: '0123456789',
                                    note: '''
                                    Địa chỉ giao hàng: ${locationState.currentAddress}
                                    Số điện thoại: 0123456789
                                    Thời gian giao hàng: ${DateTime.now().add(const Duration(minutes: 30)).toString().split('.')[0]}
                                    ''',
                                  ),
                                );

                                // Xóa giỏ hàng
                                context.read<CartBloc>().add(ClearCartEvent());

                                // Hiển thị thông báo thành công
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Đặt hàng thành công!',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Đơn hàng sẽ được giao đến: ${locationState.currentAddress}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      duration: const Duration(seconds: 3),
                                      backgroundColor: Colors.green,
                                    ),
                                  );

                                  // Chuyển đến màn hình đơn hàng
                                  context.push(RoutesPages.main);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Vui lòng chọn địa chỉ giao hàng'),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            } catch (e) {
                              // Đóng loading nếu có
                              if (context.mounted) {
                                Navigator.pop(context);
                              }

                              // Hiển thị thông báo lỗi
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Lỗi thanh toán: $e'),
                                    duration: const Duration(seconds: 2),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Đặt hàng',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const SizedBox(); // CartInitial state
        },
      ),
    );
  }
} 