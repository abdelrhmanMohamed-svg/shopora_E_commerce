import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopora_e_commerce/model/product_item_model.dart';
import 'package:shopora_e_commerce/model_views/product_details_cubit/product_details_cubit.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';

class SizeWidget extends StatelessWidget {
  const SizeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      bloc: BlocProvider.of<ProductDetailsCubit>(context),
      buildWhen: (previous, current) =>
          current is SizeSelected || current is ProductDetailsLoaded,
      builder: (context, state) {
        return Row(
          children: ProductSize.values
              .map(
                (size) => Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<ProductDetailsCubit>(context)
                          .selectSize(size);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: state is SizeSelected && state.size == size
                            ? AppColors.primary
                            : AppColors.grey200,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          size.name,
                          style: state is SizeSelected && state.size == size
                              ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: AppColors.white,
                                )
                              : Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
