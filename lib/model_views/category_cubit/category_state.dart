part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryLoaded extends CategoryState {
  final List<CategoryItemModel> category;

  CategoryLoaded({required this.category});
}

final class CategoryError extends CategoryState {
  final String message;

  CategoryError({required this.message});
}
