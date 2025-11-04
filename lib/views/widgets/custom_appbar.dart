import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopora_e_commerce/model_views/root_cubit/root_cubit.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    int selectedIndex = 0;
    final rootCubit = BlocProvider.of<RootCubit>(context);
    return BlocBuilder<RootCubit, RootState>(
      buildWhen: (previous, current) => current is UpdateSelcetedIndex,
      bloc: rootCubit,

      builder: (context, state) {
        if (state is UpdateSelcetedIndex) {
          selectedIndex = state.index;
        }
        if (selectedIndex == 0) {
          return AppBar(
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
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
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
          );
        } else if (selectedIndex == 1) {
          return AppBar(title: Text("My Cart"), centerTitle: true);
        } else if (selectedIndex == 2) {
          return AppBar(title: Text("My Favorite"), centerTitle: true);
        } else {
          return AppBar(
            title: Text("My Profile"),
            centerTitle: true,
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
            ],
          );
        }
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
