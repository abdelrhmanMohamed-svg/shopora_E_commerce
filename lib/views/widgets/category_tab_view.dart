import 'package:flutter/material.dart';
import 'package:shopora_e_commerce/model/category_item_mode.dart';
import 'package:shopora_e_commerce/views/widgets/category_item.dart';
class CategoryTabView extends StatelessWidget {
  const CategoryTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyCategories.length,
      itemBuilder: (context, index) => CategoryItem(itemIndex:index),
    );
  }
}