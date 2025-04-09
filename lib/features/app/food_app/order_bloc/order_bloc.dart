import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:itc_food/data/models/order_model.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final SharedPreferences prefs;
  static const String _ordersKey = 'orders';

  OrderBloc({required this.prefs}) : super(OrderInitial()) {
    on<CreateOrderEvent>(_onCreateOrder);
    on<FetchOrdersEvent>(_onFetchOrders);
    on<UpdateOrderStatusEvent>(_onUpdateOrderStatus);
  }

  Future<void> _onCreateOrder(CreateOrderEvent event, Emitter<OrderState> emit) async {
    try {
      emit(OrderLoading());
      
      // Tạo ID mới cho đơn hàng
      final String orderId = const Uuid().v4();
      
      // Tạo đơn hàng mới
      final Order newOrder = Order(
        id: orderId,
        items: event.items,
        totalPrice: event.totalPrice,
        status: 'pending',
        createdAt: DateTime.now(),
        address: event.address,
        phoneNumber: event.phoneNumber,
        note: event.note,
      );

      // Lấy danh sách đơn hàng hiện tại
      final String? ordersJson = prefs.getString(_ordersKey);
      List<Order> orders = [];

      if (ordersJson != null) {
        final List<dynamic> ordersData = json.decode(ordersJson);
        orders = ordersData.map((order) => Order.fromJson(order)).toList();
      }

      // Thêm đơn hàng mới vào danh sách
      orders.add(newOrder);

      // Lưu danh sách đơn hàng mới
      await _saveOrders(orders);

      emit(OrderLoaded(orders));
    } catch (e) {
      emit(OrderError('Lỗi khi tạo đơn hàng: $e'));
    }
  }

  Future<void> _onFetchOrders(FetchOrdersEvent event, Emitter<OrderState> emit) async {
    try {
      emit(OrderLoading());
      
      final String? ordersJson = prefs.getString(_ordersKey);
      if (ordersJson != null) {
        final List<dynamic> ordersData = json.decode(ordersJson);
        final List<Order> orders = ordersData.map((order) => Order.fromJson(order)).toList();
        emit(OrderLoaded(orders));
      } else {
        emit(OrderLoaded([]));
      }
    } catch (e) {
      emit(OrderError('Lỗi khi lấy danh sách đơn hàng: $e'));
    }
  }

  Future<void> _onUpdateOrderStatus(UpdateOrderStatusEvent event, Emitter<OrderState> emit) async {
    try {
      emit(OrderLoading());
      
      final String? ordersJson = prefs.getString(_ordersKey);
      if (ordersJson != null) {
        final List<dynamic> ordersData = json.decode(ordersJson);
        List<Order> orders = ordersData.map((order) => Order.fromJson(order)).toList();

        // Cập nhật trạng thái đơn hàng
        orders = orders.map((order) {
          if (order.id == event.orderId) {
            return order.copyWith(status: event.status);
          }
          return order;
        }).toList();

        // Lưu danh sách đơn hàng đã cập nhật
        await _saveOrders(orders);

        emit(OrderLoaded(orders));
      }
    } catch (e) {
      emit(OrderError('Lỗi khi cập nhật trạng thái đơn hàng: $e'));
    }
  }

  Future<void> _saveOrders(List<Order> orders) async {
    final List<Map<String, dynamic>> ordersData = orders.map((order) => order.toJson()).toList();
    await prefs.setString(_ordersKey, json.encode(ordersData));
  }
} 