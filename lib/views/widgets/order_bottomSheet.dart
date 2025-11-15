import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopora_e_commerce/model_views/checkout/checkout_cubit.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';
import 'package:shopora_e_commerce/utils/app_routes.dart';
import 'package:shopora_e_commerce/views/widgets/custom_button.dart';
import 'package:shopora_e_commerce/views/widgets/custom_snack_bar.dart';

class OrderBottomsheet extends StatelessWidget {
  const OrderBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final chekoutCubit = BlocProvider.of<CheckoutCubit>(context);
    return Container(
      height: size.height * 0.6,
      width: size.width,
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/success.jpg",
              height: size.height * 0.25,
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              "Order Placed Successfully",
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              "Your order will be packed  by the clerk, will arrive at your house in 3 to 4 days",
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(color: AppColors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.02),

            BlocConsumer<CheckoutCubit, CheckoutState>(
              bloc: chekoutCubit,
              listenWhen: (previous, current) =>
                  current is PlacedOrder || current is PlacedOrderError,
              listener: (context, state) {
                if (state is PlacedOrder) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.root,
                    (route) => false,
                  );
                } else if (state is PlacedOrderError) {
                  showCustomSnackBar(context, state.message, isError: true);
                }
              },
              buildWhen: (previous, current) =>
                  current is PlacedOrder ||
                  current is PlacedOrderError ||
                  current is PlacingOrder,
              builder: (context, state) {
                if (state is PlacingOrder) {
                  return CustomButton(
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }

                return CustomButton(
                  onPressed: () => chekoutCubit.finishedOrder(),
                  title: "Done",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
