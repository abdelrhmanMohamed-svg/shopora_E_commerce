import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopora_e_commerce/model/new_card_model.dart';
import 'package:shopora_e_commerce/services/auth_service.dart';
import 'package:shopora_e_commerce/services/paymentCard_services.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());
  NewCardModel? chosenCard;
  final _paymentServices = PaymentServicesImpl();
  final _authServices = AuthServiceImpl();

  Future<void> addToCard(
    String cardNumber,
    String cardHolderName,
    String expiryDate,
    String cvvCode,
  ) async {
    emit(AddingNewCard());
    try {
      final newCard = NewCardModel(
        id: DateTime.now().toIso8601String(),
        cardNumber: cardNumber,
        cardHolderName: cardHolderName,
        expiryDate: expiryDate,
        cvvCode: cvvCode,
      );
      final currentUser = _authServices.getCuurentUser();
      await _paymentServices.addNewPaymentCard(currentUser!.uid, newCard);
      emit(NewCardAdded());
    } catch (e) {
      emit(ErrorAddingNewCard(e.toString()));
    }
  }

  Future<void> fetchCards() async {
    emit(FetchingCards());

    try {
      final currentUser = _authServices.getCuurentUser();

      final paymentCards = await _paymentServices.fetchPaymentCards(
        currentUser!.uid,
      );
      emit(CardsFetched(cards: paymentCards));

      final isSelctedCards = await _paymentServices.fetchPaymentCards(
        currentUser.uid,
        true,
      );
      if (isSelctedCards.isNotEmpty) {
        chosenCard = isSelctedCards.first;
      }

      emit(ChooseCard(card: chosenCard!));
    } catch (e) {
      emit(ErrorFetchingCards(e.toString()));
    }
  }

  Future<void> chooseCard(String cardId) async {
    final currentUser = _authServices.getCuurentUser();

    chosenCard = await _paymentServices.fetchPaymentCard(
      currentUser!.uid,
      cardId,
    );

    emit(ChooseCard(card: chosenCard!));
  }

  Future<void> confirmPayment() async {
    emit(ConfirmPaymentLoading());
    try {
      final currentUser = _authServices.getCuurentUser();

      final isSelctedPreviousCards = await _paymentServices.fetchPaymentCards(
        currentUser!.uid,
        true,
      );
      if (isSelctedPreviousCards.isNotEmpty) {
        var previousCard = isSelctedPreviousCards.first;
        previousCard = previousCard.copyWith(isSelected: false);

        await _paymentServices.addNewPaymentCard(currentUser.uid, previousCard);
      }
      chosenCard = chosenCard!.copyWith(isSelected: true);
      await _paymentServices.addNewPaymentCard(currentUser.uid, chosenCard!);
      emit(PaymentConfirmed());
    } catch (e) {
      emit(ErrorConfirmingPayment(e.toString()));
    }

    // Future.delayed(const Duration(seconds: 1), () {
    //   final previousCard = dummyNewCards.firstWhere(
    //     (card) => card.isSelected == true,
    //     orElse: () => dummyNewCards.first,
    //   );
    //   if (previousCard.id == chosenCard.id) {
    //     emit(PaymentConfirmed());
    //     return;
    //   }
    //   final previousCardIndex = dummyNewCards.indexOf(previousCard);
    //   dummyNewCards[previousCardIndex] = previousCard.copyWith(
    //     isSelected: false,
    //   );
    //   final chosenCardIndex = dummyNewCards.indexOf(chosenCard);

    //   dummyNewCards[chosenCardIndex] = chosenCard.copyWith(isSelected: true);

    //   emit(PaymentConfirmed());
    // });
  }
}
