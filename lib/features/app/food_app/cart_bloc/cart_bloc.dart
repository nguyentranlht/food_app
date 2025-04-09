import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:itc_food/data/models/meal_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final SharedPreferences prefs;
  static const String _cartKey = 'cart_items';

  CartBloc({required this.prefs}) : super(CartInitial()) {
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<UpdateCartItemEvent>(_onUpdateCartItem);
    on<ClearCartEvent>(_onClearCart);

    // Load cart from SharedPreferences when bloc is created
    _loadCart();
  }

  void _loadCart() {
    try {
      final String? cartJson = prefs.getString(_cartKey);
      if (cartJson != null) {
        final List<dynamic> cartData = json.decode(cartJson);
        final List<CartItem> items = cartData.map((item) {
          return CartItem(
            meal: Meal.fromJson(item['meal']),
            quantity: item['quantity'],
            selectedSize: item['selectedSize'],
            selectedToppings: List<String>.from(item['selectedToppings']),
            note: item['note'],
            price: item['price'].toDouble(),
          );
        }).toList();

        _calculateAndEmitState(items);
      }
    } catch (e) {
      emit(CartError('Lỗi khi tải giỏ hàng: $e'));
    }
  }

  Future<void> _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    try {
      final String? cartJson = prefs.getString(_cartKey);
      List<CartItem> items = [];

      if (cartJson != null) {
        final List<dynamic> cartData = json.decode(cartJson);
        items = cartData.map((item) {
          return CartItem(
            meal: Meal.fromJson(item['meal']),
            quantity: item['quantity'],
            selectedSize: item['selectedSize'],
            selectedToppings: List<String>.from(item['selectedToppings']),
            note: item['note'],
            price: item['price'].toDouble(),
          );
        }).toList();
      }

      // Check if item already exists
      final existingIndex = items.indexWhere((item) => 
        item.meal.idMeal == event.meal.idMeal &&
        item.selectedSize == event.selectedSize &&
        listEquals(item.selectedToppings, event.selectedToppings)
      );

      if (existingIndex != -1) {
        // Update existing item
        items[existingIndex] = items[existingIndex].copyWith(
          quantity: items[existingIndex].quantity + event.quantity,
        );
      } else {
        // Add new item
        items.add(CartItem(
          meal: event.meal,
          quantity: event.quantity,
          selectedSize: event.selectedSize,
          selectedToppings: event.selectedToppings,
          note: event.note,
          price: _calculateItemPrice(event.meal, selectedSize: event.selectedSize, selectedToppings: event.selectedToppings),
        ));
      }

      await _saveCart(items);
      _calculateAndEmitState(items);
    } catch (e) {
      emit(CartError('Lỗi khi thêm vào giỏ hàng: $e'));
    }
  }

  Future<void> _onRemoveFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) async {
    try {
      final String? cartJson = prefs.getString(_cartKey);
      if (cartJson != null) {
        final List<dynamic> cartData = json.decode(cartJson);
        final List<CartItem> items = cartData.map((item) {
          return CartItem(
            meal: Meal.fromJson(item['meal']),
            quantity: item['quantity'],
            selectedSize: item['selectedSize'],
            selectedToppings: List<String>.from(item['selectedToppings']),
            note: item['note'],
            price: item['price'].toDouble(),
          );
        }).toList();

        items.removeWhere((item) => item.meal.idMeal == event.mealId);
        await _saveCart(items);
        _calculateAndEmitState(items);
      }
    } catch (e) {
      emit(CartError('Lỗi khi xóa khỏi giỏ hàng: $e'));
    }
  }

  Future<void> _onUpdateCartItem(UpdateCartItemEvent event, Emitter<CartState> emit) async {
    try {
      final String? cartJson = prefs.getString(_cartKey);
      if (cartJson != null) {
        final List<dynamic> cartData = json.decode(cartJson);
        final List<CartItem> items = cartData.map((item) {
          return CartItem(
            meal: Meal.fromJson(item['meal']),
            quantity: item['quantity'],
            selectedSize: item['selectedSize'],
            selectedToppings: List<String>.from(item['selectedToppings']),
            note: item['note'],
            price: item['price'].toDouble(),
          );
        }).toList();

        final index = items.indexWhere((item) => item.meal.idMeal == event.mealId);
        if (index != -1) {
          items[index] = CartItem(
            meal: items[index].meal,
            quantity: event.quantity,
            selectedSize: event.selectedSize,
            selectedToppings: event.selectedToppings,
            note: event.note,
            price: _calculateItemPrice(items[index].meal, selectedSize: event.selectedSize, selectedToppings: event.selectedToppings),
          );
          await _saveCart(items);
          _calculateAndEmitState(items);
        }
      }
    } catch (e) {
      emit(CartError('Lỗi khi cập nhật giỏ hàng: $e'));
    }
  }

  Future<void> _onClearCart(ClearCartEvent event, Emitter<CartState> emit) async {
    try {
      await prefs.remove(_cartKey);
      emit(CartLoaded(items: [], totalItems: 0, totalPrice: 0));
    } catch (e) {
      emit(CartError('Lỗi khi xóa giỏ hàng: $e'));
    }
  }

  Future<void> _saveCart(List<CartItem> items) async {
    final List<Map<String, dynamic>> cartData = items.map((item) {
      return {
        'meal': item.meal.toJson(),
        'quantity': item.quantity,
        'selectedSize': item.selectedSize,
        'selectedToppings': item.selectedToppings,
        'note': item.note,
        'price': item.price,
      };
    }).toList();

    await prefs.setString(_cartKey, json.encode(cartData));
  }

  void _calculateAndEmitState(List<CartItem> items) {
    final int totalItems = items.fold(0, (sum, item) => sum + item.quantity);
    final double totalPrice = items.fold(0, (sum, item) => sum + (item.price * item.quantity));
    emit(CartLoaded(items: items, totalItems: totalItems, totalPrice: totalPrice));
  }

  double _calculateItemPrice(Meal meal, {String? selectedSize, List<String>? selectedToppings}) {
    double basePrice = 140000; // Giá cơ bản
    double sizePrice = 0;
    double toppingsPrice = 0;

    // Tính giá theo size
    if (selectedSize != null) {
      switch (selectedSize) {
        case 'Medium':
          sizePrice = 30000;
          break;
        case 'Familiar':
          sizePrice = 60000;
          break;
        case 'Jumbo':
          sizePrice = 100000;
          break;
      }
    }

    // Tính giá topping
    if (selectedToppings != null) {
      for (var topping in selectedToppings) {
        switch (topping) {
          case 'Thêm phô mai':
            toppingsPrice += 5000;
            break;
          case 'Thêm trứng':
            toppingsPrice += 8000;
            break;
          case 'Thêm thịt':
            toppingsPrice += 15000;
            break;
          case 'Thêm rau':
            toppingsPrice += 3000;
            break;
        }
      }
    }

    return basePrice + sizePrice + toppingsPrice;
  }
}

bool listEquals<T>(List<T>? a, List<T>? b) {
  if (a == null) return b == null;
  if (b == null || a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
} 