import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:shopora_e_commerce/model_views/cart_cubit/cart_cubit.dart';
import 'package:shopora_e_commerce/views/pages/cart_page.dart';
import 'package:shopora_e_commerce/views/pages/favorite_page.dart';
import 'package:shopora_e_commerce/views/pages/home_page.dart';
import 'package:shopora_e_commerce/views/pages/profile_page.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      stateManagement: false,
      tabs: [
        PersistentTabConfig(
          screen: const HomePage(),
          item: ItemConfig(
            icon: const Icon(Icons.home),
            title: "Home",
            activeForegroundColor: Theme.of(context).primaryColor,
          ),
        ),
        PersistentTabConfig(
          screen: BlocProvider(
            create: (context) {
              final cartCubit = CartCubit();
              cartCubit.loadCartData();
              return cartCubit;
            },
            child: const CartPage(),
          ),
          item: ItemConfig(
            icon: const Icon(Icons.shopping_bag_outlined),
            title: "Cart",
            activeForegroundColor: Theme.of(context).primaryColor,
          ),
        ),
        PersistentTabConfig(
          screen: const FavoritePage(),
          item: ItemConfig(
            icon: const Icon(Icons.favorite_outline),
            title: "Favorite",
            activeForegroundColor: Theme.of(context).primaryColor,
          ),
        ),
        PersistentTabConfig(
          screen: const ProfilePage(),
          item: ItemConfig(
            icon: const Icon(Icons.person_2_outlined),
            title: "Profile",
            activeForegroundColor: Theme.of(context).primaryColor,
          ),
        ),
      ],
      navBarBuilder: (navBarConfig) =>
          Style6BottomNavBar(navBarConfig: navBarConfig),
    );
  }
}
