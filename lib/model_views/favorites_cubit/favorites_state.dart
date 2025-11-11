part of 'favorites_cubit.dart';

@immutable
sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesLoaded extends FavoritesState {
  final List<ProductItemModel> products;

  FavoritesLoaded(this.products);
}

final class FavoritesError extends FavoritesState {
  final String message;

  FavoritesError(this.message);
}

final class RemoveFavoriteLoading extends FavoritesState {
  final String productId;

  RemoveFavoriteLoading(this.productId);
}

final class RemoveFavoriteSucsess extends FavoritesState {
  final String productId;

  RemoveFavoriteSucsess(this.productId);
}

final class RemoveFavoriteError extends FavoritesState {
  final String productId;

  final String message;

  RemoveFavoriteError(this.message, this.productId);
}
