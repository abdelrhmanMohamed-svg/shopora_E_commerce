import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopora_e_commerce/model/add_to_cart_model.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  void loadCheckoutData() {
    emit(CheckoutLoading());
    final total = dummyCartItems.fold<double>(
      0,
      (previousValue, item) =>
          previousValue + (item.product.price * item.quantity),
    );
    final numOfItems = dummyCartItems.fold<int>(
      0,
      (previousValue, item) => previousValue + item.quantity,
    );
    emit(
      CheckoutLoaded(
        cartItems: dummyCartItems,
        totalAmount: total + 10,
        numOfItems: numOfItems,
      ),
    );
  }
}
