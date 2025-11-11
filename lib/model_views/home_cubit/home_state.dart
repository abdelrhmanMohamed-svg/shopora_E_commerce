part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<ProductItemModel> products;

  final List<HomeCarouselItemModel> announcements;
  

  HomeLoaded({required this.products, required this.announcements});
}

final class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}

final class FavoritesLoading extends HomeState {
  final String productId;
  FavoritesLoading(this.productId);
}

final class FvaoritesLoaded extends HomeState {
  final bool isFavorite;
  final String productId;
  FvaoritesLoaded(this.isFavorite, this.productId);
}

final class FavoritesError extends HomeState {
  final String message;
  final String productId;
  FavoritesError(this.message, this.productId);
}
