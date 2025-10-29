part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class AddingNewCard extends PaymentState {}

final class NewCardAdded extends PaymentState {}

final class ErrorAddingNewCard extends PaymentState {
  final String message;

  ErrorAddingNewCard({required this.message});
}

