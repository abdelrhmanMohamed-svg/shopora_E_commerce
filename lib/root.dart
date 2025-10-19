import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:shopora_e_commerce/views/pages/cart_page.dart';
import 'package:shopora_e_commerce/views/pages/favorite_page.dart';
import 'package:shopora_e_commerce/views/pages/home_page.dart';
import 'package:shopora_e_commerce/views/pages/profile_page.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: [
        PersistentTabConfig(
          screen: HomePage(),
          item: ItemConfig(
            icon: Icon(Icons.home),
            title: "Home",
            activeForegroundColor: Theme.of(context).primaryColor,
          ),
        ),
        PersistentTabConfig(
          screen: CartPage(),
          item: ItemConfig(
            icon: Icon(Icons.shopping_bag_outlined),
            title: "Cart",
            activeForegroundColor: Theme.of(context).primaryColor,
          ),
        ),
        PersistentTabConfig(
          screen: FavoritePage(),
          item: ItemConfig(
            icon: Icon(Icons.favorite_outline),
            title: "Favorite",
            activeForegroundColor: Theme.of(context).primaryColor,
          ),
        ),
        PersistentTabConfig(
          screen: ProfilePage(),
          item: ItemConfig(
            icon: Icon(Icons.person_2_outlined),
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
