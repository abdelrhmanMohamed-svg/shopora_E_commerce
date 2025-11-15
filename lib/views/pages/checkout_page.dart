import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:shopora_e_commerce/model/location_item_model.dart';
import 'package:shopora_e_commerce/model/new_card_model.dart';
import 'package:shopora_e_commerce/model_views/checkout/checkout_cubit.dart';
import 'package:shopora_e_commerce/model_views/payment_cubit/payment_cubit.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';
import 'package:shopora_e_commerce/utils/app_routes.dart';
import 'package:shopora_e_commerce/views/pages/cart_page.dart';
import 'package:shopora_e_commerce/views/widgets/custom_button.dart';
import 'package:shopora_e_commerce/views/widgets/custom_snack_bar.dart';
import 'package:shopora_e_commerce/views/widgets/default_location.dart';
import 'package:shopora_e_commerce/views/widgets/epmty_payment_address.dart';
import 'package:shopora_e_commerce/views/widgets/headline_title.dart';
import 'package:shopora_e_commerce/views/widgets/model_bittom_sheet_component.dart';
import 'package:shopora_e_commerce/views/widgets/order_bottomSheet.dart';
import 'package:shopora_e_commerce/views/widgets/payment_card_item.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final checkoutCubit = CheckoutCubit();
            checkoutCubit.loadCheckoutData();
            return checkoutCubit;
          },
        ),
        BlocProvider(
          create: (context) {
            final paymentCubit = PaymentCubit();
            paymentCubit.fetchCards();
            return paymentCubit;
          },
        ),
      ],
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
            final checkOutcubit = BlocProvider.of<CheckoutCubit>(context);
            final paymentCubit = BlocProvider.of<PaymentCubit>(context);

            return BlocBuilder<CheckoutCubit, CheckoutState>(
              bloc: checkOutcubit,
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
                            HeadlineTitle(
                              title: "Address",
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed(AppRoutes.addAddressRoute)
                                    .then((value) {
                                      checkOutcubit.loadCheckoutData();
                                    });
                              },
                            ),
                            SizedBox(height: size.height * 0.006),
                            buildLocationcomponent(
                              context,
                              state.chosenLocation,
                            ),

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
                            SizedBox(height: size.height * 0.02),
                            buildPaymentComponent(context, state.selectedCard),

                            SizedBox(height: size.height * 0.03),
                            Column(
                              children: [
                                totalAndSubtoal(
                                  context,
                                  title: "Subtotal",
                                  value: state.subtotal,
                                ),
                                totalAndSubtoal(
                                  context,
                                  title: "Shipping",
                                  value: state.shippingAmount,
                                ),
                                Dash(
                                  dashColor: AppColors.gery,
                                  direction: Axis.horizontal,
                                  length: size.width * 0.9,
                                ),
                                totalAndSubtoal(
                                  context,
                                  title: "Total Amount",
                                  value: state.totalAmount,
                                ),
                                SizedBox(height: size.height * 0.02),
                              ],
                            ),
                            BlocConsumer<CheckoutCubit, CheckoutState>(
                              bloc: checkOutcubit,
                              listenWhen: (previous, current) =>
                                  current is PlacedOrderError ||
                                  current is PlacedOrder,
                              listener: (context, state) {
                                if (state is PlacedOrder) {
                                  finishOrderBottomSheet(context);
                                } else if (state is PlacedOrderError) {
                                  showCustomSnackBar(
                                    context,
                                    "Something went wrong",
                                    isError: true,
                                  );
                                }
                              },
                              buildWhen: (previous, current) =>
                                  current is PlacedOrder ||
                                  current is PlacingOrder ||
                                  current is PlacedOrderError,

                              builder: (context, state) {
                                if (state is PlacingOrder) {
                                  return CustomButton(
                                    child:
                                        const CircularProgressIndicator.adaptive(),
                                  );
                                }
                                return CustomButton(
                                  onPressed: () async =>
                                      await checkOutcubit.placeOrder(),
                                  title: "Proceed to pay",
                                );
                              },
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

  void showModelBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColors.white,
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: true,
      clipBehavior: Clip.hardEdge,
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) {
            final paymentCubit = PaymentCubit();
            paymentCubit.fetchCards();
            return paymentCubit;
          },
          child: ModelBittomSheetComponent(),
        );
      },
    ).then((value) {
      BlocProvider.of<CheckoutCubit>(context).loadCheckoutData();
    });
  }

  void finishOrderBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColors.white,
      useSafeArea: true,
      clipBehavior: Clip.hardEdge,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) {
            return CheckoutCubit();
          },
          child: OrderBottomsheet(),
        );
      },
    );
  }

  Widget buildLocationcomponent(
    BuildContext context,
    LocationItemModel? chosenLocation,
  ) {
    return chosenLocation != null
        ? SelectedLocation(location: chosenLocation)
        : EpmtyPaymentAddress(
            title: "add new location",
            onTap: () {
              Navigator.of(
                context,
                rootNavigator: true,
              ).pushNamed(AppRoutes.addAddressRoute).then((value) {
                BlocProvider.of<CheckoutCubit>(context).loadCheckoutData();
              });
            },
          );
  }

  Widget buildPaymentComponent(
    BuildContext context,
    NewCardModel? selectedCard,
  ) {
    return selectedCard != null
        ? PaymentCardItem(
            card: selectedCard,
            onTap: () {
              showModelBottomSheet(context);
            },
          )
        : EpmtyPaymentAddress(
            title: "Add new payment method",
            onTap: () => Navigator.of(context, rootNavigator: true)
                .pushNamed(AppRoutes.addCardRoute)
                .then((value) {
                  BlocProvider.of<CheckoutCubit>(context).loadCheckoutData();
                }),
          );
  }
}
