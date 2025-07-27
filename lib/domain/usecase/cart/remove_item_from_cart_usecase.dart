import '../../repository/cart_repository.dart';
import '../usecase.dart';

class RemoveItemFromCartUseCase implements UseCase<void, RemoveItemFromCartParams> {
  final CartRepository repository;

  RemoveItemFromCartUseCase(this.repository);

  @override
  Future<void> call(RemoveItemFromCartParams params) async {
    return await repository.removeItemFromCart(params.cartId, params.productId);
  }
}

class RemoveItemFromCartParams {
  final String cartId;
  final String productId;

  RemoveItemFromCartParams({
    required this.cartId,
    required this.productId,
  });
}