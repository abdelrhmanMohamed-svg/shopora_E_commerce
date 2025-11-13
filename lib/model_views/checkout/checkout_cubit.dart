import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopora_e_commerce/model/add_to_cart_model.dart';
import 'package:shopora_e_commerce/model/location_item_model.dart';
import 'package:shopora_e_commerce/model/new_card_model.dart';
import 'package:shopora_e_commerce/services/auth_service.dart';
import 'package:shopora_e_commerce/services/cart_services.dart';
import 'package:shopora_e_commerce/services/location_services.dart';
import 'package:shopora_e_commerce/services/paymentCard_services.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());
  final _cartServices = CartServicesImpl();
  final _authServices = AuthServiceImpl();
  final _paymentServices = PaymentServicesImpl();
  final _loccationServices = LocationServicesImpl();

  Future<void> loadCheckoutData() async {
    emit(CheckoutLoading());
    try {
      final currentUser = _authServices.getCuurentUser();

      final cartItems = await _cartServices.fetchCartItems(currentUser!.uid);
      final total = cartItems.fold<double>(
        0,
        (previousValue, item) =>
            previousValue + (item.product.price * item.quantity),
      );
      final numOfItems = cartItems.fold<int>(
        0,
        (previousValue, item) => previousValue + item.quantity,
      );
      final paymentCards = await _paymentServices.fetchPaymentCards(
        currentUser.uid,
      );
      final locations = await _loccationServices.fetchLocations(
        currentUser.uid,
      );
      final location = _fetchSelectedLocation(locations);
      final selectedCard = _fetchSelectedCard(paymentCards);

      emit(
        CheckoutLoaded(
          cartItems: cartItems,
          totalAmount: total + 10,
          numOfItems: numOfItems,
          selectedCard: selectedCard,
          newCards: paymentCards,
          chosenLocation: location,
        ),
      );
    } catch (e) {
      emit(CheckoutError(e.toString()));
    }
  }

  NewCardModel? _fetchSelectedCard(List<NewCardModel> paymentCards) {
    if (paymentCards.isEmpty) {
      return null;
    }
    try {
      return paymentCards.firstWhere((card) => card.isSelected == true);
    } catch (e) {
      return paymentCards.first;
    }
  }

  LocationItemModel? _fetchSelectedLocation(List<LocationItemModel> locations) {
    try {
      if (locations.isEmpty) {
        return null;
      }
      return locations.firstWhere(
        (location) => location.isChosen == true,
        orElse: () => locations.first,
      );
    } catch (_) {
      return null;
    }
  }
}
