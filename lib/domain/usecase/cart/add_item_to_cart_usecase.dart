import 'package:demo_project_app/domain/entity/cart_entity.dart';

import '../../repository/cart_repository.dart';
import '../usecase.dart';

class AddItemToCartUseCase implements UseCase<void, AddItemToCartParams> {
  final CartRepository repository;

  AddItemToCartUseCase(this.repository);

  @override
  Future<void> call(AddItemToCartParams params) async {
    if (params.item.quantity < 1) {
      throw Exception('Item quantity cannot be less than 1');
    }
    return await repository.addItemToCart(params.cartId, params.item);
  }
}

class AddItemToCartParams {
  final String cartId;
  final CartItemEntity item;

  AddItemToCartParams({
    required this.cartId,
    required this.item,
  });
}
