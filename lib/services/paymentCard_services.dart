import 'package:shopora_e_commerce/model/new_card_model.dart';
import 'package:shopora_e_commerce/services/firestore_services.dart';
import 'package:shopora_e_commerce/utils/api_paths.dart';

abstract class PaymentCardServices {
  Future<void> fetchPaymentCards(String userId, [bool isChosen = false]);
  Future<void> addNewPaymentCard(String userId, NewCardModel newCard);
  Future<NewCardModel> fetchPaymentCard(String userId, String cardId);
}

class PaymentServicesImpl implements PaymentCardServices {
  final _fireStoreServices = FirestoreServices.instance;

  @override
  Future<List<NewCardModel>> fetchPaymentCards(
    String userId, [
    bool isChosen = false,
  ]) async => await _fireStoreServices.getCollection(
    path: ApiPaths.paymentCards(userId),
    builder: (data, documentId) => NewCardModel.fromMap(data),
    queryBuilder: isChosen
        ? (query) => query.where('isSelected', isEqualTo: true)
        : null,
  );

  @override
  Future<void> addNewPaymentCard(String userId, NewCardModel newCard) async =>
      await _fireStoreServices.setData(
        path: ApiPaths.paymentCard(userId, newCard.id),

        data: newCard.toMap(),
      );

  @override
  Future<NewCardModel> fetchPaymentCard(String userId, String cardId) async =>
      await _fireStoreServices.getDocument(
        path: ApiPaths.paymentCard(userId, cardId),
        builder: (data, documentID) => NewCardModel.fromMap(data),
      );
}
