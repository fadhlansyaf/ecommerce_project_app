import 'package:demo_project_app/data/datasources/cart_local_datasource.dart';
import 'package:demo_project_app/data/models/product_model.dart';

import '../../domain/entity/cart_entity.dart';
import '../../domain/repository/cart_repository.dart';
import '../models/cart_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDatasource remoteDatasource;

  CartRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<CartEntity>> getCarts(String userId) async {
    try {
      return await remoteDatasource.getCarts(userId);
    } catch (e) {
      throw Exception('Failed to get cart: $e');
    }
  }

  @override
  Future<CartEntity> createCart(CartEntity cart) async {
    try {
      final cartModel = CartModel(
        id: cart.userId, // Use userId as the cart id
        userId: cart.userId,
        items: cart.items
            .map((item) => CartItemModel(
                  product: item.product as ProductModel,
                  quantity: item.quantity,
                ))
            .toList(),
        createdAt: cart.createdAt,
      );
      return await remoteDatasource.createCart(cartModel);
    } catch (e) {
      throw Exception('Failed to create/update cart: $e');
    }
  }

  @override
  Future<void> addItemToCart(String userId, CartItemEntity item) async {
    try {
      final cartItemModel = CartItemModel(
        product: item.product as ProductModel,
        quantity: item.quantity,
      );
      await remoteDatasource.addItemToCart(userId, cartItemModel);
    } catch (e) {
      throw Exception('Failed to add item to cart: $e');
    }
  }

  @override
  Future<void> removeItemFromCart(String userId, String productId) async {
    try {
      await remoteDatasource.removeItemFromCart(userId, productId);
    } catch (e) {
      throw Exception('Failed to remove item from cart: $e');
    }
  }

  @override
  Future<void> deleteCart(String cartId) async {
    try {
      await remoteDatasource.deleteCart(cartId);
    } catch (e) {
      throw Exception('Failed to delete cart: $e');
    }
  }
}
