import 'package:shopora_e_commerce/model/order_model.dart';
import 'package:shopora_e_commerce/services/firestore_services.dart';
import 'package:shopora_e_commerce/utils/api_paths.dart';

abstract class CheckoutServices {
  Future<void> placeOrder(OrderModel order);
}

class CheckoutServicesImpl implements CheckoutServices {
  final _fireStoreServices = FirestoreServices.instance;

  @override
  Future<void> placeOrder(OrderModel order) async =>
      await _fireStoreServices.setData(
        path: ApiPaths.order(order.userId, order.orderId),
        data: order.toMap(),
      );
}
