part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class AddingNewCard extends PaymentState {}

final class NewCardAdded extends PaymentState {}

final class ErrorAddingNewCard extends PaymentState {
  final String message;

  ErrorAddingNewCard(this.message);
}

final class FetchingCards extends PaymentState {}

final class CardsFetched extends PaymentState {
  final List<NewCardModel> cards;

  CardsFetched({required this.cards});
}

final class ErrorFetchingCards extends PaymentState {
  final String message;

  ErrorFetchingCards(this.message);
}

final class ChooseCard extends PaymentState {
  final NewCardModel card;

  ChooseCard({required this.card});
}

final class ConfirmPaymentLoading extends PaymentState {}

final class PaymentConfirmed extends PaymentState {}

final class ErrorConfirmingPayment extends PaymentState {
  final String message;

  ErrorConfirmingPayment( this.message);
}
