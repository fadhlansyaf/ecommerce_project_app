import 'package:equatable/equatable.dart';
import '../../../domain/entity/cart_entity.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCartsEvent extends CartEvent {
  final String userId;
  final DateTime? startDate;
  final DateTime? endDate;

  LoadCartsEvent({
    required this.userId,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [userId, startDate, endDate];
}

class CreateCartEvent extends CartEvent {
  final CartEntity cart;
  final List<CartItemEntity> items;

  CreateCartEvent({required this.cart, required this.items});

  @override
  List<Object?> get props => [cart, items];
}

class AddItemToCartEvent extends CartEvent {
  final String cartId;
  final CartItemEntity item;

  AddItemToCartEvent({required this.cartId, required this.item});

  @override
  List<Object?> get props => [cartId, item];
}

class RemoveItemFromCartEvent extends CartEvent {
  final String cartId;
  final String productId;

  RemoveItemFromCartEvent({required this.cartId, required this.productId});

  @override
  List<Object?> get props => [cartId, productId];
}

class DeleteCartEvent extends CartEvent {
  final String cartId;

  DeleteCartEvent({required this.cartId});

  @override
  List<Object?> get props => [cartId];
}
