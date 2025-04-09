import 'package:itc_food/data/models/meal_model.dart';

abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final Meal meal;
  final int quantity;
  final String selectedSize;
  final List<String> selectedToppings;
  final String? note;

  AddToCartEvent({
    required this.meal,
    required this.quantity,
    required this.selectedSize,
    required this.selectedToppings,
    this.note,
  });
}

class RemoveFromCartEvent extends CartEvent {
  final String mealId;

  RemoveFromCartEvent(this.mealId);
}

class UpdateCartItemEvent extends CartEvent {
  final String mealId;
  final int quantity;
  final String selectedSize;
  final List<String> selectedToppings;
  final String? note;

  UpdateCartItemEvent({
    required this.mealId,
    required this.quantity,
    required this.selectedSize,
    required this.selectedToppings,
    this.note,
  });
}

class ClearCartEvent extends CartEvent {} 