part of 'product_details_cubit.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsLoaded extends ProductDetailsState {
  final ProductItemModel product;

  ProductDetailsLoaded(this.product);
}

final class ProductDetailsError extends ProductDetailsState {
  final String message;

  ProductDetailsError(this.message);
}

final class CounterUpdated extends ProductDetailsState {
  final int value;

  CounterUpdated({required this.value});
}

final class SizeSelected extends ProductDetailsState {
  final ProductSize size;

  SizeSelected({required this.size});
}

final class AddingToCart extends ProductDetailsState {

}

final class CartAdded extends ProductDetailsState {
  final String productId;

  CartAdded(this.productId);
}
final class AddToCartError extends ProductDetailsState {
  final String message;

  AddToCartError(this.message);


}
