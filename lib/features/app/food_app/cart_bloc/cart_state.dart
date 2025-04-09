import 'package:itc_food/data/models/meal_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}

class CartLoaded extends CartState {
  final List<CartItem> items;
  final int totalItems;
  final double totalPrice;

  CartLoaded({
    required this.items,
    required this.totalItems,
    required this.totalPrice,
  });
}

class CartItem {
  final Meal meal;
  final int quantity;
  final String selectedSize;
  final List<String> selectedToppings;
  final String? note;
  final double price;

  CartItem({
    required this.meal,
    required this.quantity,
    required this.selectedSize,
    required this.selectedToppings,
    this.note,
    required this.price,
  });

  CartItem copyWith({
    Meal? meal,
    int? quantity,
    String? selectedSize,
    List<String>? selectedToppings,
    String? note,
    double? price,
  }) {
    return CartItem(
      meal: meal ?? this.meal,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedToppings: selectedToppings ?? this.selectedToppings,
      note: note ?? this.note,
      price: price ?? this.price,
    );
  }
} 