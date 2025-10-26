import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopora_e_commerce/model_views/cart_cubit/cart_cubit.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';
import 'package:shopora_e_commerce/views/widgets/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  CartItem(item: state.cartItems[index]),
                              separatorBuilder: (context, index) =>
                                  Divider(color: AppColors.grey300),
                              itemCount: state.cartItems.length,
                            ),
                          ],
                        ),
                      );
              } else if (state is CartError) {
                return Scaffold(body: Center(child: Text(state.message)));
              } else {
                return Scaffold(
                  body: Center(child: Text("something went wrong")),
                );
              }
            },
          );
        },
      ),
    );
  }
}
