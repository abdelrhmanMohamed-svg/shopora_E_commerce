part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<AddToCartModel> cartItems;
  final double subtotal;

  CartLoaded({required this.cartItems, required this.subtotal});
}

final class CartError extends CartState {
  final String message;

  CartError({required this.message});
}

final class CounterUpdated extends CartState {
  final String productId;
  final int value;

  CounterUpdated({required this.value, required this.productId});
}
final class UpdateSubTotal extends CartState {
  final double subtotal;

  UpdateSubTotal({required this.subtotal});
}