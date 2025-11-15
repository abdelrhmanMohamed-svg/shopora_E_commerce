part of 'checkout_cubit.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLoading extends CheckoutState {}

final class CheckoutLoaded extends CheckoutState {
  final List<AddToCartModel> cartItems;
  final double totalAmount;
  final int numOfItems;
  final NewCardModel? selectedCard;
  final List<NewCardModel> newCards;
  final LocationItemModel? chosenLocation;
  final double shippingAmount;
  final double subtotal;

  CheckoutLoaded({
    required this.cartItems,
    required this.totalAmount,
    required this.numOfItems,
    this.selectedCard,
    required this.newCards,
    this.chosenLocation,
    required this.shippingAmount,
    required this.subtotal,
  });
}

final class CheckoutError extends CheckoutState {
  final String message;

  CheckoutError(this.message);
}

final class PlacingOrder extends CheckoutState {}

final class PlacedOrder extends CheckoutState {}

final class PlacedOrderError extends CheckoutState {
  final String message;

  PlacedOrderError(this.message);
}

final class FinishedOrderLoading extends CheckoutState {}

final class FinishedOrder extends CheckoutState {}

final class FinishedOrderError extends CheckoutState {
  final String message;

  FinishedOrderError(this.message);
}
