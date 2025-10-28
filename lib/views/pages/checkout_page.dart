import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopora_e_commerce/model_views/checkout/checkout_cubit.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';
import 'package:shopora_e_commerce/views/widgets/custom_button.dart';
import 'package:shopora_e_commerce/views/widgets/epmty_payment_address.dart';
import 'package:shopora_e_commerce/views/widgets/headline_title.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) {
        final checkoutCubit = CheckoutCubit();
        checkoutCubit.loadCheckoutData();
        return checkoutCubit;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.white,
          scrolledUnderElevation: 0.0,
          centerTitle: true,
          title: Text("Checkout"),
        ),
        body: Builder(
          builder: (context) {
            final cubit = BlocProvider.of<CheckoutCubit>(context);
            return BlocBuilder<CheckoutCubit, CheckoutState>(
              bloc: cubit,
              buildWhen: (previous, current) =>
                  current is CheckoutLoaded ||
                  current is CheckoutError ||
                  current is CheckoutLoading,
              builder: (context, state) {
                if (state is CheckoutLoading) {
                  return Center(child: CircularProgressIndicator.adaptive());
                } else if (state is CheckoutError) {
                  return Center(child: Text(state.message));
                } else if (state is CheckoutLoaded) {
                  final cartItems = state.cartItems;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 10.0,
                      ),
                      child: SafeArea(
                        child: Column(
                          children: [
                            HeadlineTitle(title: "Address", onTap: () {}),
                            SizedBox(height: size.height * 0.006),
                            EpmtyPaymentAddress(title: "Add new address"),
                            SizedBox(height: size.height * 0.03),

                            HeadlineTitle(
                              title: "Products",
                              numOfItems: state.numOfItems,
                            ),
                            SizedBox(height: size.height * 0.03),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                final item = cartItems[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: AppColors.grey200,
                                          borderRadius: BorderRadius.circular(
                                            20.0,
                                          ),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,

                                          children: [
                                            Text(
                                              item.product.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                text: "Size:",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColors.gery,
                                                    ),
                                                children: [
                                                  TextSpan(
                                                    text: item.size.name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              AppColors.black,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: size.height * 0.05,
                                            ),

                                            Text(
                                              "\$${item.product.price * item.quantity}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  Divider(color: AppColors.grey300),
                              itemCount: cartItems.length,
                            ),

                            SizedBox(height: size.height * 0.03),
                            HeadlineTitle(title: "Payment Method"),
                            SizedBox(height: size.height * 0.006),
                            EpmtyPaymentAddress(
                              title: "Add new payment method",
                            ),
                            SizedBox(height: size.height * 0.03),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Amount:",
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(
                                        color: AppColors.black45,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Text(
                                  "\$${state.totalAmount}",
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.03),
                            CustomButton(
                              onPressed: () {},
                              title: "Proceed to pay",
                            ),
                            SizedBox(height: size.height * 0.04),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(child: Text("something went wrong"));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
