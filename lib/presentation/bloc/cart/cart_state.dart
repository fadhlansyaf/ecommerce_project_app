import 'package:equatable/equatable.dart';
import '../../../core/data_state.dart';
import '../../../domain/entity/cart_entity.dart';

class CartState extends Equatable {
  final DataState<List<CartEntity>> cartListState;
  final DataState<CartEntity> currentCartState;

  const CartState({
    this.cartListState = const DataState.initial(),
    this.currentCartState = const DataState.initial(),
  });

  CartState copyWith({
    DataState<List<CartEntity>>? cartListState,
    DataState<CartEntity>? currentCartState,
  }) =>
      CartState(
        cartListState: cartListState ?? this.cartListState,
        currentCartState: currentCartState ?? this.currentCartState,
      );

  @override
  List<Object?> get props => [cartListState, currentCartState];
}