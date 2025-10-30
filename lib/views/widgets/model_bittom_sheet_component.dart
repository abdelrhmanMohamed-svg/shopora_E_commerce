import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopora_e_commerce/model_views/payment_cubit/payment_cubit.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';
import 'package:shopora_e_commerce/utils/app_routes.dart';
import 'package:shopora_e_commerce/views/widgets/custom_button.dart';
import 'package:shopora_e_commerce/views/widgets/model_bottom_sheet_card_item.dart';

class ModelBittomSheetComponent extends StatelessWidget {
  const ModelBittomSheetComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final paymentCubit = BlocProvider.of<PaymentCubit>(context);

    return Container(
      height: size.height * 0.6,
      width: size.width,
      color: AppColors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "Payment Methods",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: size.height * 0.01),
                BlocBuilder<PaymentCubit, PaymentState>(
                  bloc: paymentCubit,
                  buildWhen: (previous, current) =>
                      current is CardsFetched ||
                      current is FetchingCards ||
                      current is ErrorFetchingCards,
                  builder: (context, state) {
                    if (state is FetchingCards) {
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (state is ErrorFetchingCards) {
                      return Center(child: Text(state.message));
                    } else if (state is CardsFetched) {
                      final cards = state.cards;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: cards.length,
                        itemBuilder: (context, index) {
                          final card = cards[index];
                          return ModelBottomSheetCardItem(card: card);
                        },
                      );
                    } else {
                      return Center(child: Text("something went wrong"));
                    }
                  },
                ),

                SizedBox(height: size.height * 0.01),

                InkWell(
                  onTap: () => Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pushNamed(AppRoutes.addCardRoute),
                  child: Card(
                    elevation: 1.5,
                    color: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ListTile(
                      leading: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.grey100,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Icon(
                            Icons.add_circle_outline_outlined,
                            size: size.height * 0.03,
                          ),
                        ),
                      ),
                      title: Text(
                        "Add Payment Method",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                BlocConsumer<PaymentCubit, PaymentState>(
                  listenWhen: (previous, current) =>
                      current is PaymentConfirmed,
                  listener: (context, state) {
                    if (state is PaymentConfirmed) {
                      Navigator.of(context).pop();
                    }
                  },
                  bloc: paymentCubit,
                  buildWhen: (previous, current) =>
                      current is ConfirmPaymentLoading ||
                      current is PaymentConfirmed,
                  builder: (context, state) {
                    if (state is ConfirmPaymentLoading) {
                      return CustomButton(
                        child: const CircularProgressIndicator.adaptive(),
                      );
                    } else {
                      return CustomButton(
                        onPressed: () => paymentCubit.confirmPayment(),
                        title: "Confirm Payment",
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
