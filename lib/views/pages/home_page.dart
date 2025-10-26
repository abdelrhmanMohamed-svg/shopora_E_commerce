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
    return BlocProvider(
      create: (context) {
        final homeCubit = HomeCubit();
        homeCubit.loadHomeData();
        return homeCubit;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          children: [
            TabBar(
              labelStyle: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
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
    );
  }
}
