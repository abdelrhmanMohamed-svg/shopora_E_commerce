import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopora_e_commerce/model/add_to_cart_model.dart';
import 'package:shopora_e_commerce/model/location_item_model.dart';
import 'package:shopora_e_commerce/model/new_card_model.dart';
import 'package:shopora_e_commerce/model/order_model.dart';
import 'package:shopora_e_commerce/services/auth_service.dart';
import 'package:shopora_e_commerce/services/cart_services.dart';
import 'package:shopora_e_commerce/services/checkout_services.dart';
import 'package:shopora_e_commerce/services/location_services.dart';
import 'package:shopora_e_commerce/services/paymentCard_services.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());
  final _cartServices = CartServicesImpl();
  final _authServices = AuthServiceImpl();
  final _paymentServices = PaymentServicesImpl();
  final _loccationServices = LocationServicesImpl();
  final _checkoutServices = CheckoutServicesImpl();
  final double shippingAmount = 10;

  Future<void> loadCheckoutData() async {
    emit(CheckoutLoading());
    try {
      final currentUser = _authServices.getCuurentUser();

      final cartItems = await _cartServices.fetchCartItems(currentUser!.uid);
      final subtotal = cartItems.fold<double>(
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
          totalAmount: subtotal + shippingAmount,
          numOfItems: numOfItems,
          selectedCard: selectedCard,
          newCards: paymentCards,
          chosenLocation: location,
          shippingAmount: shippingAmount,
          subtotal: subtotal,
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

  Future<void> placeOrder() async {
    emit(PlacingOrder());
    try {
      final currentUser = _authServices.getCuurentUser();
      final paymentCards = await _paymentServices.fetchPaymentCards(
        currentUser!.uid,
      );
      final locations = await _loccationServices.fetchLocations(
        currentUser.uid,
      );
      final location = _fetchSelectedLocation(locations);
      final selectedCard = _fetchSelectedCard(paymentCards);
      final cartItems = await _cartServices.fetchCartItems(currentUser.uid);
      final subtotal = cartItems.fold<double>(
        0,
        (previousValue, item) =>
            previousValue + (item.product.price * item.quantity),
      );
      final newOrder = OrderModel(
        orderId: DateTime.now().toIso8601String(),
        userId: currentUser.uid,
        location: location!,
        paymentCard: selectedCard!,
        products: cartItems,
        totalPrice: subtotal + shippingAmount,
      );

      await _checkoutServices.placeOrder(newOrder);

      emit(PlacedOrder());
    } catch (e) {
      emit(PlacedOrderError(e.toString()));
    }
  }

  Future<void> finishedOrder() async {
    emit(PlacingOrder());
    try {
      final currentUser = _authServices.getCuurentUser();
      final cartItems = await _cartServices.fetchCartItems(currentUser!.uid);
      for (var item in cartItems) {
        await _cartServices.deleteCartItem(currentUser.uid, item.productId);
      }
      emit(PlacedOrder());
    } catch (e) {
      emit(PlacedOrderError(e.toString()));
    }
  }
}
