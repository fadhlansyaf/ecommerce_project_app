import '../../entity/cart_entity.dart';
import '../../repository/cart_repository.dart';
import '../usecase.dart';

class GetCartByIdUseCase implements UseCase<List<CartEntity>, String> {
  final CartRepository repository;

  GetCartByIdUseCase(this.repository);

  @override
  Future<List<CartEntity>> call(String cartId) async {
    final cart = await repository.getCarts(cartId);
    
    return cart;
  }
}