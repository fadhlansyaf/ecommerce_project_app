import 'package:demo_project_app/domain/entity/cart_entity.dart';

abstract class CartRepository {
  Future<List<CartEntity>> getCarts(String userId);
  Future<CartEntity> createCart(CartEntity cart);
  Future<void> addItemToCart(String cartId, CartItemEntity item);
  Future<void> removeItemFromCart(String cartId, String productId);
  Future<void> deleteCart(String cartId);
}
