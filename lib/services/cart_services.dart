import 'package:shopora_e_commerce/model/add_to_cart_model.dart';
import 'package:shopora_e_commerce/services/firestore_services.dart';
import 'package:shopora_e_commerce/utils/api_paths.dart';

abstract class CartServices {
  Future<List<AddToCartModel>> fetchCartItems(String userId);
  Future<void> setCartItem(String userId, AddToCartModel cartItem);
}

class CartServicesImpl implements CartServices {
  final _fireStoreServices = FirestoreServices.instance;
  @override
  Future<List<AddToCartModel>> fetchCartItems(String userId) async =>
      await _fireStoreServices.getCollection<AddToCartModel>(
        path: ApiPaths.cartItems(userId),
        builder: (data, documentId) => AddToCartModel.fromMap(data),
      );

  @override
  Future<void> setCartItem(String userId, AddToCartModel cartItem) async =>
      await _fireStoreServices.setData(
        path: ApiPaths.cartItem(userId, cartItem.productId),
        data: cartItem.toMap(),
      );
}
