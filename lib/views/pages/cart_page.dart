import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopora_e_commerce/model_views/cart_cubit/cart_cubit.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';
import 'package:shopora_e_commerce/views/widgets/cart_item.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:shopora_e_commerce/views/widgets/custom_button.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) {
        final cartCubit = CartCubit();
        cartCubit.loadCartData();
        return cartCubit;
      },
      child: Builder(
        builder: (context) {
          return BlocBuilder<CartCubit, CartState>(
            bloc: BlocProvider.of<CartCubit>(context),
            buildWhen: (previous, current) =>
                current is CartLoaded ||
                current is CartError ||
                current is CartLoading,
            builder: (context, state) {
              if (state is CartLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is CartLoaded) {
                return state.cartItems.isEmpty
                    ? Center(child: Text("Cart is empty"))
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                padding: EdgeInsets.zero,

                                itemBuilder: (context, index) =>
                                    CartItem(item: state.cartItems[index]),
                                separatorBuilder: (context, index) =>
                                    Divider(color: AppColors.grey300),
                                itemCount: state.cartItems.length,
                              ),
                            ),
                            BlocBuilder<CartCubit, CartState>(
                              bloc: BlocProvider.of<CartCubit>(context),
                              buildWhen: (previous, current) =>
                                  current is UpdateSubTotal ||
                                  current is CartLoaded,
                              builder: (context, subtotalState) {
                                if (subtotalState is UpdateSubTotal) {
                                  return Column(
                                    children: [
                                      totalAndSubtoal(
                                        context,
                                        title: "Subtotal",
                                        value: subtotalState.subtotal,
                                      ),
                                      totalAndSubtoal(
                                        context,
                                        title: "Shipping",
                                        value: 10,
                                      ),
                                      Dash(
                                        dashColor: AppColors.gery,
                                        direction: Axis.horizontal,
                                        length: size.width * 0.9,
                                      ),
                                      totalAndSubtoal(
                                        context,
                                        title: "Total Amount",
                                        value: subtotalState.subtotal + 10,
                                      ),
                                      SizedBox(height: size.height * 0.02),
                                      CustomButton(
                                        onPressed: () {},
                                        title: "Checkout",
                                      ),
                                      SizedBox(height: size.height * 0.01),
                                    ],
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      totalAndSubtoal(
                                        context,
                                        title: "Subtotal",
                                        value: state.subtotal,
                                      ),
                                      totalAndSubtoal(
                                        context,
                                        title: "Shipping",
                                        value: 10,
                                      ),
                                      Dash(
                                        dashColor: AppColors.gery,
                                        direction: Axis.horizontal,
                                        length: size.width * 0.9,
                                      ),
                                      totalAndSubtoal(
                                        context,
                                        title: "Total Amount",
                                        value: state.subtotal + 10,
                                      ),
                                      SizedBox(height: size.height * 0.02),
                                      CustomButton(
                                        onPressed: () {},
                                        title: "Checkout",
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      );
              } else if (state is CartError) {
                return Center(child: Text(state.message));
              } else {
                return Center(child: Text("something went wrong"));
              }
            },
          );
        },
      ),
    );
  }
}

Widget totalAndSubtoal(
  BuildContext context, {
  required String title,
  required double value,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 9.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$title:",
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
        ),
        Spacer(),
        Text(
          "\$$value",
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}
