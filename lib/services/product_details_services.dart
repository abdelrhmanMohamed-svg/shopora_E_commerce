import 'package:shopora_e_commerce/model/add_to_cart_model.dart';
import 'package:shopora_e_commerce/model/product_item_model.dart';
import 'package:shopora_e_commerce/services/firestore_services.dart';
import 'package:shopora_e_commerce/utils/api_paths.dart';

abstract class ProductDetailsServices {
  Future<ProductItemModel> fetchProductDetails(String productId);
  Future<void> addToCart(AddToCartModel cartItem, String uid);
}

class ProductDetailsServicesImpl implements ProductDetailsServices {
  final _fireStoreServices = FirestoreServices.instance;

  @override
  Future<ProductItemModel> fetchProductDetails(String productId) async {
    final product = await _fireStoreServices.getDocument<ProductItemModel>(
      path: ApiPaths.product(productId),
      builder: (data, documentID) => ProductItemModel.fromMap(data),
    );
    return product;
  }

  @override
  Future<void> addToCart(AddToCartModel cartItem, String uid) async {
    await _fireStoreServices.setData(
      path: ApiPaths.cartItem(uid, cartItem.productId),
      data: cartItem.toMap(),
    );
  }
}
