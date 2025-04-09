import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:itc_food/data/models/meal_model.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
class Order with _$Order {
  const factory Order({
    required String id,
    required List<OrderItem> items,
    required double totalPrice,
    required String status,
    required DateTime createdAt,
    required String address,
    required String phoneNumber,
    String? note,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}

@freezed
class OrderItem with _$OrderItem {
  const factory OrderItem({
    required Meal meal,
    required int quantity,
    required String selectedSize,
    required List<String> selectedToppings,
    required double price,
    String? note,
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);
} 