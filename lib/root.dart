import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:shopora_e_commerce/model_views/cart_cubit/cart_cubit.dart';
import 'package:shopora_e_commerce/model_views/home_cubit/home_cubit.dart';
import 'package:shopora_e_commerce/views/pages/cart_page.dart';
import 'package:shopora_e_commerce/views/pages/favorite_page.dart';
import 'package:shopora_e_commerce/views/pages/home_page.dart';
import 'package:shopora_e_commerce/views/pages/profile_page.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: CircleAvatar(
            radius: size.height * 0.025,
            backgroundImage: CachedNetworkImageProvider(
              "https://cdn4.vectorstock.com/i/1000x1000/82/33/person-gray-photo-placeholder-woman-vector-24138233.jpg",
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi,Abelrahman",
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              "Lets's go shopping!",
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
      ),
      body: PersistentTabView(
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
            screen: const CartPage(),
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
      ),
    );
  }
}
