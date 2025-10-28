part of 'checkout_cubit.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLoading extends CheckoutState {}

final class CheckoutLoaded extends CheckoutState {
  final List<AddToCartModel> cartItems;
  final double totalAmount;
  final int numOfItems;

  CheckoutLoaded({
    required this.cartItems,
    required this.totalAmount,
    required this.numOfItems,
  });
}

final class CheckoutError extends CheckoutState {
  final String message;

  CheckoutError(this.message);
}
