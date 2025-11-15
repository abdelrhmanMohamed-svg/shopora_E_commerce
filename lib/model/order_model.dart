

import 'package:shopora_e_commerce/model/add_to_cart_model.dart';
import 'package:shopora_e_commerce/model/location_item_model.dart';
import 'package:shopora_e_commerce/model/new_card_model.dart';

class OrderModel {
  final String orderId;
  final String userId;
  final LocationItemModel location;
  final NewCardModel paymentCard;
  final List<AddToCartModel> products;
  final double totalPrice;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.location,
    required this.paymentCard,
    required this.products,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'userId': userId,
      'location': location.toMap(),
      'paymentCard': paymentCard.toMap(),
      'products': products.map((x) => x.toMap()).toList(),
      'totalPrice': totalPrice,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] as String,
      userId: map['userId'] as String,
      location: LocationItemModel.fromMap(map['location'] as Map<String,dynamic>),
      paymentCard: NewCardModel.fromMap(map['paymentCard'] as Map<String,dynamic>),
      products: List<AddToCartModel>.from((map['products'] as List<int>).map<AddToCartModel>((x) => AddToCartModel.fromMap(x as Map<String,dynamic>),),),
      totalPrice: map['totalPrice'] as double,
    );
  }

}
