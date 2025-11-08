import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopora_e_commerce/model/category_item_mode.dart';
import 'package:shopora_e_commerce/model_views/category_cubit/category_cubit.dart';
import 'package:shopora_e_commerce/views/widgets/category_item.dart';

class CategoryTabView extends StatelessWidget {
  const CategoryTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryCubit = BlocProvider.of<CategoryCubit>(context);

    return BlocBuilder<CategoryCubit, CategoryState>(
      bloc: categoryCubit,
      buildWhen: (previous, current) =>
          current is CategoryLoaded ||
          current is CategoryError ||
          current is CategoryLoading,
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is CategoryError) {
          return Center(child: Text(state.message));
        } else if (state is CategoryLoaded) {
          final categories = state.category;
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) =>
                CategoryItem( category: categories[index]),
          );
        } else {
          return const Text("somthing went wrong");
        }
      },
    );
  }
}
