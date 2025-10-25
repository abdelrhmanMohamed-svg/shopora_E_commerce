import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopora_e_commerce/model/product_item_model.dart';
import 'package:shopora_e_commerce/model_views/product_details_cubit/product_details_cubit.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';

class AddToCartRowWidget extends StatelessWidget {
  const AddToCartRowWidget({super.key, required this.selectedItem});
  final ProductItemModel selectedItem;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProductDetailsCubit>(context);
    return DecoratedBox(
      decoration: BoxDecoration(color: AppColors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                text: "\$",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
                children: [
                  TextSpan(
                    text: selectedItem.price.toString(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              bloc: cubit,
              buildWhen: (previous, current) =>
                  current is AddingToCart ||
                  current is CartAdded ||
                  current is ProductDetailsLoaded,
              builder: (context, state) {
                if (state is AddingToCart) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: null,
                    child: const CircularProgressIndicator.adaptive(),
                  );
                } else if (state is CartAdded) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: null,
                    child: Text(
                      "Added to cart",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  );
                }
                return ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () {
                    final size = cubit.size;

                    if (size != null) {
                      cubit.addToCart(selectedItem.id);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: const Text("Please select size")),
                      );
                    }
                  },
                  label: Text(
                    "Add to cart",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                  icon: Icon(Icons.shopping_cart, color: AppColors.white),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
