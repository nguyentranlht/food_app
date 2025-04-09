import 'package:itc_food/data/models/order_model.dart';

abstract class OrderEvent {}

class CreateOrderEvent extends OrderEvent {
  final List<OrderItem> items;
  final double totalPrice;
  final String address;
  final String phoneNumber;
  final String? note;

  CreateOrderEvent({
    required this.items,
    required this.totalPrice,
    required this.address,
    required this.phoneNumber,
    this.note,
  });
}

class FetchOrdersEvent extends OrderEvent {}

class UpdateOrderStatusEvent extends OrderEvent {
  final String orderId;
  final String status;

  UpdateOrderStatusEvent({
    required this.orderId,
    required this.status,
  });
} 