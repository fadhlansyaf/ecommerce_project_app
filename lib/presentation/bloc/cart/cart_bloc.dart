import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/data_state.dart';
import '../../../domain/usecase/cart/create_cart_usecase.dart';
import '../../../domain/usecase/cart/add_item_to_cart_usecase.dart';
import '../../../domain/usecase/cart/remove_item_from_cart_usecase.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CreateCartUseCase createCartUseCase;
  final AddItemToCartUseCase addItemToCartUseCase;
  final RemoveItemFromCartUseCase removeItemFromCartUseCase;

  CartBloc({
    required this.createCartUseCase,
    required this.addItemToCartUseCase,
    required this.removeItemFromCartUseCase,
  }) : super(const CartState()) {
    on<LoadCartsEvent>(_onLoadCarts);
    on<CreateCartEvent>(_onCreateCart);
    on<AddItemToCartEvent>(_onAddItemToCart);
    on<RemoveItemFromCartEvent>(_onRemoveItemFromCart);
    on<DeleteCartEvent>(_onDeleteCart);
  }

  Future<void> _onLoadCarts(LoadCartsEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(cartListState: const DataState.loading()));
    try {
      final cart = await createCartUseCase.repository.getCarts(event.userId);
      emit(state.copyWith(cartListState: DataState.success(cart)));
    } catch (e) {
      emit(state.copyWith(cartListState: DataState.failure(e.toString())));
    }
  }

  Future<void> _onCreateCart(CreateCartEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(currentCartState: const DataState.loading()));
    try {
      final cart = await createCartUseCase(CreateCartParams(
        cart: event.cart,
        items: event.items,
      ));
      emit(state.copyWith(currentCartState: DataState.success(cart)));
      add(LoadCartsEvent(userId: event.cart.userId)); // Refresh cart list
    } catch (e) {
      emit(state.copyWith(currentCartState: DataState.failure(e.toString())));
    }
  }

  Future<void> _onAddItemToCart(AddItemToCartEvent event, Emitter<CartState> emit) async {
    try {
      await addItemToCartUseCase(AddItemToCartParams(
        cartId: event.cartId,
        item: event.item,
      ));
      // Refresh cart list after adding item
      if (state.cartListState.data != null && state.cartListState.data!.isNotEmpty) {
        add(LoadCartsEvent(userId: state.cartListState.data![0].userId));
      }
    } catch (e) {
      emit(state.copyWith(currentCartState: DataState.failure(e.toString())));
    }
  }

  Future<void> _onRemoveItemFromCart(RemoveItemFromCartEvent event, Emitter<CartState> emit) async {
    try {
      await removeItemFromCartUseCase(RemoveItemFromCartParams(
        cartId: event.cartId,
        productId: event.productId,
      ));
      // Refresh cart list after removing item
      if (state.cartListState.data != null && state.cartListState.data!.isNotEmpty) {
        add(LoadCartsEvent(userId: state.cartListState.data![0].userId));
      }
    } catch (e) {
      emit(state.copyWith(currentCartState: DataState.failure(e.toString())));
    }
  }

  Future<void> _onDeleteCart(DeleteCartEvent event, Emitter<CartState> emit) async {
    try {
      await createCartUseCase.repository.deleteCart(event.cartId);
      // Refresh cart list after deleting cart
      if (state.cartListState.data != null && state.cartListState.data!.isNotEmpty) {
        add(LoadCartsEvent(userId: state.cartListState.data![0].userId));
      }
    } catch (e) {
      emit(state.copyWith(currentCartState: DataState.failure(e.toString())));
    }
  }
}