import 'package:demo_project_app/data/models/product_model.dart';
import 'package:hive/hive.dart';
import '../models/cart_model.dart';

class CartLocalDatasource {
  static const String cartBoxName = 'carts';
  final Box<CartModel> cartBox;

  CartLocalDatasource({required this.cartBox});

  Future<List<CartModel>> getCarts(String userId) async {
    final carts = cartBox.values.where((cart) => cart.userId == userId).toList();
    // Sort by creation date, newest first
    carts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return carts;
  }

  Future<CartModel> createCart(CartModel cart) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final newCart = CartModel(
      id: timestamp,
      userId: cart.userId,
      items: cart.items,
      createdAt: DateTime.now(),
    );
    await cartBox.put(timestamp, newCart);
    return newCart;
  }

  Future<void> addItemToCart(String cartId, CartItemModel item) async {
    final cart = cartBox.get(cartId);
    if (cart == null) return;

    final updatedItems = <CartItemModel>[...cart.items, item];
    final updatedCart = CartModel(
      id: cart.id,
      userId: cart.userId,
      items: updatedItems,
      createdAt: cart.createdAt,
    );
    await cartBox.put(cartId, updatedCart);
  }

  Future<void> removeItemFromCart(String cartId, String productId) async {
    final cart = cartBox.get(cartId);
    if (cart == null) return;
    
    final updatedItems = cart.items
        .where((item) => (item.product as ProductModel).id != productId)
        .toList();
    final updatedCart = CartModel(
      id: cart.id,
      userId: cart.userId,
      items: updatedItems,
      createdAt: cart.createdAt,
    );
    await cartBox.put(cartId, updatedCart);
  }

  Future<void> deleteCart(String cartId) async {
    await cartBox.delete(cartId);
  }
}
