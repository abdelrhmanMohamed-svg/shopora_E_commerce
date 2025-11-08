import 'package:shopora_e_commerce/model/category_item_mode.dart';
import 'package:shopora_e_commerce/services/firestore_services.dart';
import 'package:shopora_e_commerce/utils/api_paths.dart';

abstract class CategoryServices {
  Future<List<CategoryItemModel>> fetchCategories();
}

class CategoryServicesImpl implements CategoryServices {
  final _fireStoreServices = FirestoreServices.instance;
  @override
  Future<List<CategoryItemModel>> fetchCategories() async{
    final categories = await _fireStoreServices.getCollection<CategoryItemModel>(
      path: ApiPaths.category(),
      builder: (data, documentId) => CategoryItemModel.fromMap(data),
    );
    return categories;

    
  }
}
