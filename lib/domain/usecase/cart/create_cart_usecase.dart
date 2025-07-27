import 'package:demo_project_app/domain/entity/cart_entity.dart';
import 'package:demo_project_app/domain/repository/cart_repository.dart';
import 'package:demo_project_app/domain/usecase/usecase.dart';

class CreateCartUseCase implements UseCase<CartEntity, CreateCartParams> {
  final CartRepository repository;

  CreateCartUseCase(this.repository);

  @override
  Future<CartEntity> call(CreateCartParams params) async {
    // Validate cart items
    for (var item in params.items) {
      if (item.quantity < 1) {
        throw Exception('Item quantity cannot be less than 1');
      }
    }

    // Check for duplicate items
    final productIds = params.items.map((item) => item.product.id).toList();
    if (productIds.length != productIds.toSet().length) {
      throw Exception('Duplicate items are not allowed in cart');
    }

    return await repository.createCart(params.cart);
  }
}

class CreateCartParams {
  final CartEntity cart;
  final List<CartItemEntity> items;

  CreateCartParams({required this.cart, required this.items});
}
