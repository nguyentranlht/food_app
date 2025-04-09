// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
mixin _$Order {
  String get id => throw _privateConstructorUsedError;
  List<OrderItem> get items => throw _privateConstructorUsedError;
  double get totalPrice => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this Order to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res, Order>;
  @useResult
  $Res call({
    String id,
    List<OrderItem> items,
    double totalPrice,
    String status,
    DateTime createdAt,
    String address,
    String phoneNumber,
    String? note,
  });
}

/// @nodoc
class _$OrderCopyWithImpl<$Res, $Val extends Order>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? items = null,
    Object? totalPrice = null,
    Object? status = null,
    Object? createdAt = null,
    Object? address = null,
    Object? phoneNumber = null,
    Object? note = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            items:
                null == items
                    ? _value.items
                    : items // ignore: cast_nullable_to_non_nullable
                        as List<OrderItem>,
            totalPrice:
                null == totalPrice
                    ? _value.totalPrice
                    : totalPrice // ignore: cast_nullable_to_non_nullable
                        as double,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            address:
                null == address
                    ? _value.address
                    : address // ignore: cast_nullable_to_non_nullable
                        as String,
            phoneNumber:
                null == phoneNumber
                    ? _value.phoneNumber
                    : phoneNumber // ignore: cast_nullable_to_non_nullable
                        as String,
            note:
                freezed == note
                    ? _value.note
                    : note // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderImplCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$$OrderImplCopyWith(
    _$OrderImpl value,
    $Res Function(_$OrderImpl) then,
  ) = __$$OrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    List<OrderItem> items,
    double totalPrice,
    String status,
    DateTime createdAt,
    String address,
    String phoneNumber,
    String? note,
  });
}

/// @nodoc
class __$$OrderImplCopyWithImpl<$Res>
    extends _$OrderCopyWithImpl<$Res, _$OrderImpl>
    implements _$$OrderImplCopyWith<$Res> {
  __$$OrderImplCopyWithImpl(
    _$OrderImpl _value,
    $Res Function(_$OrderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? items = null,
    Object? totalPrice = null,
    Object? status = null,
    Object? createdAt = null,
    Object? address = null,
    Object? phoneNumber = null,
    Object? note = freezed,
  }) {
    return _then(
      _$OrderImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        items:
            null == items
                ? _value._items
                : items // ignore: cast_nullable_to_non_nullable
                    as List<OrderItem>,
        totalPrice:
            null == totalPrice
                ? _value.totalPrice
                : totalPrice // ignore: cast_nullable_to_non_nullable
                    as double,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        address:
            null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                    as String,
        phoneNumber:
            null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                    as String,
        note:
            freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderImpl implements _Order {
  const _$OrderImpl({
    required this.id,
    required final List<OrderItem> items,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    required this.address,
    required this.phoneNumber,
    this.note,
  }) : _items = items;

  factory _$OrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderImplFromJson(json);

  @override
  final String id;
  final List<OrderItem> _items;
  @override
  List<OrderItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final double totalPrice;
  @override
  final String status;
  @override
  final DateTime createdAt;
  @override
  final String address;
  @override
  final String phoneNumber;
  @override
  final String? note;

  @override
  String toString() {
    return 'Order(id: $id, items: $items, totalPrice: $totalPrice, status: $status, createdAt: $createdAt, address: $address, phoneNumber: $phoneNumber, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    const DeepCollectionEquality().hash(_items),
    totalPrice,
    status,
    createdAt,
    address,
    phoneNumber,
    note,
  );

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      __$$OrderImplCopyWithImpl<_$OrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderImplToJson(this);
  }
}

abstract class _Order implements Order {
  const factory _Order({
    required final String id,
    required final List<OrderItem> items,
    required final double totalPrice,
    required final String status,
    required final DateTime createdAt,
    required final String address,
    required final String phoneNumber,
    final String? note,
  }) = _$OrderImpl;

  factory _Order.fromJson(Map<String, dynamic> json) = _$OrderImpl.fromJson;

  @override
  String get id;
  @override
  List<OrderItem> get items;
  @override
  double get totalPrice;
  @override
  String get status;
  @override
  DateTime get createdAt;
  @override
  String get address;
  @override
  String get phoneNumber;
  @override
  String? get note;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) {
  return _OrderItem.fromJson(json);
}

/// @nodoc
mixin _$OrderItem {
  Meal get meal => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String get selectedSize => throw _privateConstructorUsedError;
  List<String> get selectedToppings => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this OrderItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderItemCopyWith<OrderItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderItemCopyWith<$Res> {
  factory $OrderItemCopyWith(OrderItem value, $Res Function(OrderItem) then) =
      _$OrderItemCopyWithImpl<$Res, OrderItem>;
  @useResult
  $Res call({
    Meal meal,
    int quantity,
    String selectedSize,
    List<String> selectedToppings,
    double price,
    String? note,
  });

  $MealCopyWith<$Res> get meal;
}

/// @nodoc
class _$OrderItemCopyWithImpl<$Res, $Val extends OrderItem>
    implements $OrderItemCopyWith<$Res> {
  _$OrderItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meal = null,
    Object? quantity = null,
    Object? selectedSize = null,
    Object? selectedToppings = null,
    Object? price = null,
    Object? note = freezed,
  }) {
    return _then(
      _value.copyWith(
            meal:
                null == meal
                    ? _value.meal
                    : meal // ignore: cast_nullable_to_non_nullable
                        as Meal,
            quantity:
                null == quantity
                    ? _value.quantity
                    : quantity // ignore: cast_nullable_to_non_nullable
                        as int,
            selectedSize:
                null == selectedSize
                    ? _value.selectedSize
                    : selectedSize // ignore: cast_nullable_to_non_nullable
                        as String,
            selectedToppings:
                null == selectedToppings
                    ? _value.selectedToppings
                    : selectedToppings // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            price:
                null == price
                    ? _value.price
                    : price // ignore: cast_nullable_to_non_nullable
                        as double,
            note:
                freezed == note
                    ? _value.note
                    : note // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MealCopyWith<$Res> get meal {
    return $MealCopyWith<$Res>(_value.meal, (value) {
      return _then(_value.copyWith(meal: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderItemImplCopyWith<$Res>
    implements $OrderItemCopyWith<$Res> {
  factory _$$OrderItemImplCopyWith(
    _$OrderItemImpl value,
    $Res Function(_$OrderItemImpl) then,
  ) = __$$OrderItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Meal meal,
    int quantity,
    String selectedSize,
    List<String> selectedToppings,
    double price,
    String? note,
  });

  @override
  $MealCopyWith<$Res> get meal;
}

/// @nodoc
class __$$OrderItemImplCopyWithImpl<$Res>
    extends _$OrderItemCopyWithImpl<$Res, _$OrderItemImpl>
    implements _$$OrderItemImplCopyWith<$Res> {
  __$$OrderItemImplCopyWithImpl(
    _$OrderItemImpl _value,
    $Res Function(_$OrderItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meal = null,
    Object? quantity = null,
    Object? selectedSize = null,
    Object? selectedToppings = null,
    Object? price = null,
    Object? note = freezed,
  }) {
    return _then(
      _$OrderItemImpl(
        meal:
            null == meal
                ? _value.meal
                : meal // ignore: cast_nullable_to_non_nullable
                    as Meal,
        quantity:
            null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                    as int,
        selectedSize:
            null == selectedSize
                ? _value.selectedSize
                : selectedSize // ignore: cast_nullable_to_non_nullable
                    as String,
        selectedToppings:
            null == selectedToppings
                ? _value._selectedToppings
                : selectedToppings // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        price:
            null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                    as double,
        note:
            freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderItemImpl implements _OrderItem {
  const _$OrderItemImpl({
    required this.meal,
    required this.quantity,
    required this.selectedSize,
    required final List<String> selectedToppings,
    required this.price,
    this.note,
  }) : _selectedToppings = selectedToppings;

  factory _$OrderItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderItemImplFromJson(json);

  @override
  final Meal meal;
  @override
  final int quantity;
  @override
  final String selectedSize;
  final List<String> _selectedToppings;
  @override
  List<String> get selectedToppings {
    if (_selectedToppings is EqualUnmodifiableListView)
      return _selectedToppings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedToppings);
  }

  @override
  final double price;
  @override
  final String? note;

  @override
  String toString() {
    return 'OrderItem(meal: $meal, quantity: $quantity, selectedSize: $selectedSize, selectedToppings: $selectedToppings, price: $price, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderItemImpl &&
            (identical(other.meal, meal) || other.meal == meal) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.selectedSize, selectedSize) ||
                other.selectedSize == selectedSize) &&
            const DeepCollectionEquality().equals(
              other._selectedToppings,
              _selectedToppings,
            ) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    meal,
    quantity,
    selectedSize,
    const DeepCollectionEquality().hash(_selectedToppings),
    price,
    note,
  );

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderItemImplCopyWith<_$OrderItemImpl> get copyWith =>
      __$$OrderItemImplCopyWithImpl<_$OrderItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderItemImplToJson(this);
  }
}

abstract class _OrderItem implements OrderItem {
  const factory _OrderItem({
    required final Meal meal,
    required final int quantity,
    required final String selectedSize,
    required final List<String> selectedToppings,
    required final double price,
    final String? note,
  }) = _$OrderItemImpl;

  factory _OrderItem.fromJson(Map<String, dynamic> json) =
      _$OrderItemImpl.fromJson;

  @override
  Meal get meal;
  @override
  int get quantity;
  @override
  String get selectedSize;
  @override
  List<String> get selectedToppings;
  @override
  double get price;
  @override
  String? get note;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderItemImplCopyWith<_$OrderItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
