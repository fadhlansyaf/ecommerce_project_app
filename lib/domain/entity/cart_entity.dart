import 'package:demo_project_app/domain/entity/product_entity.dart';

class CartEntity {
  final String id;
  final String userId;
  final List<CartItemEntity> items;
  final DateTime createdAt;

  CartEntity({
    required this.id,
    required this.userId,
    required this.items,
    required this.createdAt,
  });

  double get totalAmount => items.fold(
        0,
        (sum, item) => sum + (item.product.price * item.quantity),
      );
}

class CartItemEntity {
  final ProductEntity product;
  final int quantity;

  CartItemEntity({
    required this.product,
    required this.quantity,
  });
}
