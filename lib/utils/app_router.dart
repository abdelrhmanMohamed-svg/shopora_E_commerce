import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopora_e_commerce/model_views/auth_cubit/auth_cubit.dart';
import 'package:shopora_e_commerce/model_views/location_cubit/loaction_cubit.dart';
import 'package:shopora_e_commerce/model_views/product_details_cubit/product_details_cubit.dart';
import 'package:shopora_e_commerce/root.dart';
import 'package:shopora_e_commerce/utils/app_routes.dart';
import 'package:shopora_e_commerce/views/pages/add_location_page.dart';
import 'package:shopora_e_commerce/views/pages/add_card_page.dart';
import 'package:shopora_e_commerce/views/pages/checkout_page.dart';
import 'package:shopora_e_commerce/views/pages/login_page.dart';
import 'package:shopora_e_commerce/views/pages/product_details_page.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.loginRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const LoginPage(),
          ),
        );

      case AppRoutes.addAddressRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) {
              final locationCubit = LoactionCubit();
              locationCubit.fetchLocations();
              return locationCubit;
            },
            child: const AddLocationPage(),
          ),
        );

      case AppRoutes.addCardRoute:
        return MaterialPageRoute(builder: (context) => const AddCardPage());

      case AppRoutes.checkoutRoute:
        return MaterialPageRoute(builder: (context) => const CheckoutPage());

      case AppRoutes.productDetailsRoute:
        final productId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) {
              final cubit = ProductDetailsCubit();
              cubit.loadProductDetails(productId);

              return cubit;
            },
            child: ProductDetailsPage(productId: productId),
          ),
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
