import 'package:shopora_e_commerce/model/product_item_model.dart';

class AddToCartModel {
  final String productId;
  final int quantity;
  final ProductSize size;
  final ProductItemModel product;


  AddToCartModel({
    required this.productId,
    required this.quantity,
    required this.size,
    required this.product,
  });

  
}
List<AddToCartModel> dummyCartItems = [];