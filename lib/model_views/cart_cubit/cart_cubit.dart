import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopora_e_commerce/model/add_to_cart_model.dart';
import 'package:shopora_e_commerce/services/auth_service.dart';
import 'package:shopora_e_commerce/services/cart_services.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  int quantity = 1;
  final _cartServices = CartServicesImpl();
  final _authServices = AuthServiceImpl();

  Future<void> loadCartData() async {
    emit(CartLoading());
    try {
      final currentUser = _authServices.getCuurentUser();
      final cartItems = await _cartServices.fetchCartItems(currentUser!.uid);
      emit(CartLoaded(cartItems: cartItems, subtotal: _subtotal(cartItems)));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> incrementCounter(String productId, [int? initialValue]) async {
    emit(CounterLoading());
    try {
      if (initialValue != null) {
        quantity = initialValue;
      }
      quantity++;

      final currentUser = _authServices.getCuurentUser();
      final cartItems = await _cartServices.fetchCartItems(currentUser!.uid);
      final cartItem = cartItems.firstWhere(
        (item) => item.productId == productId,
      );
      final updatedCartrItem = cartItem.copyWith(quantity: quantity);
      await _cartServices.setCartItem(currentUser.uid, updatedCartrItem);

      emit(CounterUpdated(value: quantity, productId: productId));
      emit(UpdateSubTotal(subtotal: _subtotal(cartItems)));
    } catch (e) {
      emit(CounterError(e.toString()));
    }
  }

  Future<void> decrementCounter(String productId, [int? initialValue]) async {
    emit(CounterLoading());

    try {
      if (initialValue != null) {
        quantity = initialValue;
      }
      if (quantity > 1) {
        quantity--;
        final currentUser = _authServices.getCuurentUser();
        final cartItems = await _cartServices.fetchCartItems(currentUser!.uid);
        final cartItem = cartItems.firstWhere(
          (item) => item.productId == productId,
        );
        final updatedCartrItem = cartItem.copyWith(quantity: quantity);
        await _cartServices.setCartItem(currentUser.uid, updatedCartrItem);
        emit(CounterUpdated(value: quantity, productId: productId));

        emit(UpdateSubTotal(subtotal: _subtotal(cartItems)));
      }
    } catch (e) {
      emit(CounterError(e.toString()));
    }
  }

  double _subtotal(List<AddToCartModel> cartItems) => cartItems.fold(
    0,
    (previousValue, item) =>
        previousValue + (item.product.price * item.quantity),
  );
}
