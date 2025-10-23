import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopora_e_commerce/model_views/home_cubit/home_cubit.dart';

import 'package:shopora_e_commerce/utils/app_colors.dart';
import 'package:shopora_e_commerce/views/widgets/category_tab_view.dart';

import 'package:shopora_e_commerce/views/widgets/home_tab_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) {
        final homeCubit = HomeCubit();
        homeCubit.loadHomeData();
        return homeCubit;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: size.height * 0.025,
                          backgroundImage: CachedNetworkImageProvider(
                            "https://cdn4.vectorstock.com/i/1000x1000/82/33/person-gray-photo-placeholder-woman-vector-24138233.jpg",
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hi,Abelrahman",
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Lets's go shopping!",
                              style: Theme.of(context).textTheme.titleSmall!
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.notifications),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                TabBar(
                  labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  controller: _tabController,
                  unselectedLabelColor: AppColors.gery,
                  tabs: [
                    Tab(text: "Home"),
                    Tab(text: "Category"),
                  ],
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [HomeTabView(), CategoryTabView()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
