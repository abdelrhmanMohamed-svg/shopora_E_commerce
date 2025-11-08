import 'package:shopora_e_commerce/model/product_item_model.dart';
import 'package:shopora_e_commerce/services/firestore_services.dart';
import 'package:shopora_e_commerce/utils/api_paths.dart';

abstract class HomeServices {
  Future<List<ProductItemModel>> fetchHomeProducts();
}

class HomeServicesImpl implements HomeServices {
  final _fireStoreServices = FirestoreServices.instance;
  @override
  Future<List<ProductItemModel>> fetchHomeProducts() async {
    final products = await _fireStoreServices.getCollection<ProductItemModel>(
      path: ApiPaths.products(),
      builder: (data, documentId) => ProductItemModel.fromMap(data),
    );
    return products;
  }
}
