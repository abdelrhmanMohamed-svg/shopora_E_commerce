import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopora_e_commerce/model/new_card_model.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());
  late NewCardModel chosenCard;
  void addToCard(
    String cardNumber,
    String cardHolderName,
    String expiryDate,
    String cvvCode,
  ) {
    emit(AddingNewCard());
    final newCard = NewCardModel(
      id: DateTime.now().toIso8601String(),
      cardNumber: cardNumber,
      cardHolderName: cardHolderName,
      expiryDate: expiryDate,
      cvvCode: cvvCode,
    );
    dummyNewCards.add(newCard);
    Future.delayed(const Duration(seconds: 1), () {
      emit(NewCardAdded());
    });
  }

  void fetchCards() {
    emit(FetchingCards());
    Future.delayed(const Duration(seconds: 1), () {
      emit(CardsFetched(cards: dummyNewCards));

      chosenCard = dummyNewCards.firstWhere(
        (card) => card.isSelected == true,
        orElse: () => dummyNewCards.first,
      );
      emit(ChooseCard(card: chosenCard));
    });
  }

  void chooseCard(String cardId) {
    chosenCard = dummyNewCards.firstWhere((card) => card.id == cardId);

    emit(ChooseCard(card: chosenCard));
  }

  void confirmPayment() {
    emit(ConfirmPaymentLoading());
    Future.delayed(const Duration(seconds: 1), () {
      final previousCard = dummyNewCards.firstWhere(
        (card) => card.isSelected == true,
        orElse: () => dummyNewCards.first,
      );
      if (previousCard.id == chosenCard.id) {
        emit(PaymentConfirmed());
        return;
      }
      final previousCardIndex = dummyNewCards.indexOf(previousCard);
      dummyNewCards[previousCardIndex] = previousCard.copyWith(
        isSelected: false,
      );
      final chosenCardIndex = dummyNewCards.indexOf(chosenCard);

      dummyNewCards[chosenCardIndex] = chosenCard.copyWith(isSelected: true);

      emit(PaymentConfirmed());
    });
  }
}
