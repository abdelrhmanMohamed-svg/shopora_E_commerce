// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  

  AddToCartModel copyWith({
    String? productId,
    int? quantity,
    ProductSize? size,
    ProductItemModel? product,
  }) {
    return AddToCartModel(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      product: product ?? this.product,
    );
  }

}
List<AddToCartModel> dummyCartItems = [];