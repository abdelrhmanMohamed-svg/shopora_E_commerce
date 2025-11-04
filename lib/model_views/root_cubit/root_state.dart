part of 'root_cubit.dart';

@immutable
sealed class RootState {
  const RootState();
}

final class RootInitial extends RootState {}

final class UpdateSelcetedIndex extends RootState {
  final int index;

  const UpdateSelcetedIndex({required this.index});
}
