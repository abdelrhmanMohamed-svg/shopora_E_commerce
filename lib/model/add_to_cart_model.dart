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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'quantity': quantity,
      'size': size.name,
      'product': product.toMap(),
    };
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map) {
    return AddToCartModel(
      productId: map['productId'] as String,
      quantity: map['quantity'] as int,
      size: ProductSize.fromString(map['size']),
      product: ProductItemModel.fromMap(map['product'] as Map<String, dynamic>),
    );
  }
}

List<AddToCartModel> dummyCartItems = [];
