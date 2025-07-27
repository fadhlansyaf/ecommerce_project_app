import '../../domain/entity/cart_entity.dart';
import 'product_model.dart';
import 'package:hive/hive.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 0)
class CartModel extends CartEntity {
  @HiveField(0)
  @override
  final String id;

  @HiveField(1)
  @override
  final String userId;

  @HiveField(2)
  @override
  final List<CartItemModel> items;

  @HiveField(3)
  @override
  final DateTime createdAt;

  CartModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.createdAt,
  }) : super(
          id: id,
          userId: userId,
          items: items,
          createdAt: createdAt,
        );

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      items: (json['items'] as List)
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((item) => (item as CartItemModel).toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

@HiveType(typeId: 1)
class CartItemModel extends CartItemEntity {
  @HiveField(0)
  @override
  final ProductModel product;

  @HiveField(1)
  @override
  final int quantity;

  CartItemModel({
    required this.product,
    required this.quantity,
  }) : super(
          product: product,
          quantity: quantity,
        );

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': (product as ProductModel).toJson(),
      'quantity': quantity,
    };
  }
}