
import 'package:flutter/material.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({
    super.key,
    required this.value,
    required this.cubit,
    required this.productId,
   
  });
  final int value;
  final dynamic cubit;
  final String productId;
 

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.05,
      width: size.width * 0.27,

      decoration: BoxDecoration(
        color: AppColors.grey200,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              cubit.decrementCounter(productId);
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              child: Icon(
                Icons.remove,
                color: value == 1 ?AppColors.black12 : AppColors.black,
              ),
            ),
          ),
          const SizedBox(width: 3),
          Text(
            value.toString(),
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 3),

          InkWell(
            onTap: () {
              cubit.incrementCounter(productId);
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              child: Icon(Icons.add, color: AppColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
