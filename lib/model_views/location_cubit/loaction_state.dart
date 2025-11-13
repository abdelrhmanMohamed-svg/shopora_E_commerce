part of 'loaction_cubit.dart';

@immutable
sealed class LoactionState {}

final class LoactionInitial extends LoactionState {}

final class LoactionLoading extends LoactionState {}

final class LoactionsLoaded extends LoactionState {
  final List<LocationItemModel> locations;

  LoactionsLoaded({required this.locations});
}

final class LoactionError extends LoactionState {
  final String message;

  LoactionError(this.message);
}

final class LocationAdding extends LoactionState {}

final class LoactionAdded extends LoactionState {}

final class LocationErrorAdding extends LoactionState {
  final String message;

  LocationErrorAdding(this.message);
}

final class ChosenLocation extends LoactionState {
  final String id;

  ChosenLocation({required this.id});
}

final class ConfirmLocationLoading extends LoactionState {}

final class ConfirmLocationSuccess extends LoactionState {
  final LocationItemModel location;

  ConfirmLocationSuccess({required this.location});
}

final class ConfirmLocationError extends LoactionState {
  final String message;

  ConfirmLocationError(this.message);
}
