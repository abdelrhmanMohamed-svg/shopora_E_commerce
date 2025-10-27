import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopora_e_commerce/model/add_to_cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  int quantity = 1;

  void loadCartData() {
    emit(CartLoading());

    emit(CartLoaded(cartItems: dummyCartItems, subtotal: _subtotal()));
  }

  void incrementCounter(String productId, [int? initialValue]) {
    if (initialValue != null) {
      quantity = initialValue;
    }
    quantity++;
      final index = dummyCartItems.indexWhere(
        (item) => item.productId == productId,
      );
      dummyCartItems[index] = dummyCartItems[index].copyWith(
        quantity: quantity,
      );
    emit(CounterUpdated(value: quantity, productId: productId));
    emit(UpdateSubTotal(subtotal: _subtotal()));
  }

  void decrementCounter(String productId, [int? initialValue]) {
    if (initialValue != null) {
      quantity = initialValue;
    }
    if (quantity > 1) {
      quantity--;
      final index = dummyCartItems.indexWhere(
        (item) => item.productId == productId,
      );
      dummyCartItems[index] = dummyCartItems[index].copyWith(
        quantity: quantity,
      );
      emit(CounterUpdated(value: quantity, productId: productId));

      emit(UpdateSubTotal(subtotal: _subtotal()));
    }
  }

  double _subtotal() => dummyCartItems.fold(
    0,
    (previousValue, item) =>
        previousValue + (item.product.price * item.quantity),
  );
}
