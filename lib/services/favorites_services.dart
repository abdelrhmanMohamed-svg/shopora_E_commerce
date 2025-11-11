import 'package:shopora_e_commerce/model/product_item_model.dart';
import 'package:shopora_e_commerce/services/firestore_services.dart';
import 'package:shopora_e_commerce/utils/api_paths.dart';

abstract class FavoritesServices {
  Future<void> addProductToFavorites(ProductItemModel product, String userId);
  Future<void> removeProductFromFavorites(String productId, String uid);
  Future<List<ProductItemModel>> getFavoriteProducts(String uid);
}

class FavoritesServiceImple extends FavoritesServices {
  final _fireStoreServices = FirestoreServices.instance;
  @override
  Future<void> addProductToFavorites(
    ProductItemModel product,
    String userId,
  ) async {
    await _fireStoreServices.setData(
      path: ApiPaths.setFavorites(userId, product.id),
      data: product.toMap(),
    );
  }

  @override
  Future<List<ProductItemModel>> getFavoriteProducts(String uid) async {
    final favorites = await _fireStoreServices.getCollection<ProductItemModel>(
      path: ApiPaths.favorites(uid),
      builder: (data, documentId) => ProductItemModel.fromMap(data),
    );
    return favorites;
  }

  @override
  Future<void> removeProductFromFavorites(String productId, String uid) async {
    await _fireStoreServices.deleteData(
      path: ApiPaths.setFavorites(uid, productId),
    );
  }
}
