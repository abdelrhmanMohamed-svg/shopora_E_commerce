import 'package:flutter/material.dart';
import 'package:shopora_e_commerce/root.dart';
import 'package:shopora_e_commerce/utils/app_routes.dart';
import 'package:shopora_e_commerce/views/pages/product_details_page.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.productDetails:
        final productId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => ProductDetailsPage(productId: productId),
        );
      case AppRoutes.root:
        return MaterialPageRoute(builder: (context) => const Root());
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(body: Text("Error")),
        );
    }
  }
}
