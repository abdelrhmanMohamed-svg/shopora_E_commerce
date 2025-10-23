import 'package:flutter/material.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key, required this.value});
  final int value;

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
            onTap: () {},
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              child: Icon(Icons.remove, color: AppColors.black),
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
            onTap: () {},
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
