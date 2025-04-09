// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderImpl _$$OrderImplFromJson(Map<String, dynamic> json) => _$OrderImpl(
  id: json['id'] as String,
  items:
      (json['items'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
  totalPrice: (json['totalPrice'] as num).toDouble(),
  status: json['status'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  address: json['address'] as String,
  phoneNumber: json['phoneNumber'] as String,
  note: json['note'] as String?,
);

Map<String, dynamic> _$$OrderImplToJson(_$OrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'items': instance.items,
      'totalPrice': instance.totalPrice,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'note': instance.note,
    };

_$OrderItemImpl _$$OrderItemImplFromJson(Map<String, dynamic> json) =>
    _$OrderItemImpl(
      meal: Meal.fromJson(json['meal'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num).toInt(),
      selectedSize: json['selectedSize'] as String,
      selectedToppings:
          (json['selectedToppings'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      price: (json['price'] as num).toDouble(),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$OrderItemImplToJson(_$OrderItemImpl instance) =>
    <String, dynamic>{
      'meal': instance.meal,
      'quantity': instance.quantity,
      'selectedSize': instance.selectedSize,
      'selectedToppings': instance.selectedToppings,
      'price': instance.price,
      'note': instance.note,
    };
