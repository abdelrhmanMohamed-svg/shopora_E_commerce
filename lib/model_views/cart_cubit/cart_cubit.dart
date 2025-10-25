import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopora_e_commerce/model/add_to_cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  int quantity = 1;

  void loadCartData() {
    emit(CartLoading());
    Future.delayed(Duration(seconds: 1), () {
      emit(CartLoaded(cartItems: dummyCartItems));
    });
  }

  void incrementCounter(String productId, [int? initialValue]) {
    if (initialValue != null) {
      quantity = initialValue;
    }
    quantity++;
    emit(CounterUpdated(value: quantity, productId: productId));
  }

  void decrementCounter(String productId, [int? initialValue]) {
    if (initialValue != null) {
      quantity = initialValue;
    }
    if (quantity > 1) {
      quantity--;
      emit(CounterUpdated(value: quantity,productId: productId));
    }
  }
}
