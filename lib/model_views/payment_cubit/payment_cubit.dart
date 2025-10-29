import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopora_e_commerce/model/new_card_model.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());
  void addToCard(
    String cardNumber,
    String cardHolderName,
    String expiryDate,
    String cvvCode,
  ) {
    emit(AddingNewCard());
    final newCard = NewCardModel(
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

  
}
