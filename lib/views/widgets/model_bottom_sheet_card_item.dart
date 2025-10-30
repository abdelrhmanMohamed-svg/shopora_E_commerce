import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopora_e_commerce/model/new_card_model.dart';
import 'package:shopora_e_commerce/model_views/payment_cubit/payment_cubit.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';

class ModelBottomSheetCardItem extends StatelessWidget {
  const ModelBottomSheetCardItem({super.key, required this.card});
  final NewCardModel card;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final paymentCubit = BlocProvider.of<PaymentCubit>(context);

    return InkWell(
      onTap: () {
          paymentCubit.chooseCard(card.id);
      },
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
              color: AppColors.grey200,
            ),
            child: CachedNetworkImage(
              height: size.height * 0.11,
              width: size.width * 0.11,
              imageUrl:
                  "https://pngimg.com/uploads/mastercard/mastercard_PNG16.png",
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator.adaptive()),
            ),
          ),

          title: Text(
            "Master Card",
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            card.cardNumber,
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(color: AppColors.gery),
          ),
          trailing: BlocBuilder<PaymentCubit, PaymentState>(
            bloc: paymentCubit,
            buildWhen: (previous, current) => current is ChooseCard,
            builder: (context, state) {
              if (state is ChooseCard) {
                return Radio<String>(
                  value: card.id,
                  groupValue: state.card.id,
                  onChanged: (value) {
                    paymentCubit.chooseCard(value!);
                  },
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
