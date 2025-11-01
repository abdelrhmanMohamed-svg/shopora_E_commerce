import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopora_e_commerce/model/add_to_cart_model.dart';
import 'package:shopora_e_commerce/model/location_item_model.dart';
import 'package:shopora_e_commerce/model/new_card_model.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  void loadCheckoutData() {
    emit(CheckoutLoading());
    final total = dummyCartItems.fold<double>(
      0,
      (previousValue, item) =>
          previousValue + (item.product.price * item.quantity),
    );
    final numOfItems = dummyCartItems.fold<int>(
      0,
      (previousValue, item) => previousValue + item.quantity,
    );
    final card = _fetchSelectedCard();
    final location = _fetchSelectedLocation();
    emit(
      CheckoutLoaded(
        cartItems: dummyCartItems,
        totalAmount: total + 10,
        numOfItems: numOfItems,
        selectedCard: card,
        newCards: dummyNewCards,
        chosenLocation: location,
      ),
    );
  }

  NewCardModel? _fetchSelectedCard() {
    return dummyNewCards.firstWhere(
      (card) => card.isSelected == true,
      orElse: () => dummyNewCards.first,
    );
  }

  LocationItemModel? _fetchSelectedLocation() {
    try {
      return dummyLocations.firstWhere((location) => location.isChosen == true);
    } catch (e) {
      return null;
    }
  }
}
