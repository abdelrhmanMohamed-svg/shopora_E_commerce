import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopora_e_commerce/model/add_to_cart_model.dart';
import 'package:shopora_e_commerce/model_views/cart_cubit/cart_cubit.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';
import 'package:shopora_e_commerce/views/widgets/counter_widget.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.item});
  final AddToCartModel item;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<CartCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.grey200,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: CachedNetworkImage(
              imageUrl: item.product.imgUrl,
              height: size.height * 0.16,
              width: size.width * 0.33,
            ),
          ),
          SizedBox(width: size.width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  item.product.name,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                ),
                Text.rich(
                  TextSpan(
                    text: "Size:",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.gery,
                    ),
                    children: [
                      TextSpan(
                        text: item.size.name,
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                BlocBuilder<CartCubit, CartState>(
                  bloc: cubit,
                  buildWhen: (previous, current) =>
                      current is CounterUpdated &&
                          current.productId == item.productId ||
                      current is CartLoaded,
                  builder: (context, state) {
                    if (state is CounterUpdated) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CounterWidget(
                            value: state.value,
                            cubit: cubit,
                            productId: item.productId,
                          ),
                          Text(
                            "\$${item.product.price * state.value}",
                            style: Theme.of(context).textTheme.headlineSmall!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CounterWidget(
                          initialValue: item.quantity,
                          value: item.quantity,
                          cubit: cubit,
                          productId: item.productId,
                        ),
                        Text(
                          "\$${item.product.price * item.quantity}",
                          style: Theme.of(context).textTheme.headlineSmall!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
