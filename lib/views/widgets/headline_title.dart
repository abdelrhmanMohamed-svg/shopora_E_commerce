import 'package:flutter/material.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';

class HeadlineTitle extends StatelessWidget {
  const HeadlineTitle({
    super.key,
    required this.title,
    this.numOfItems,
    this.onTap,
  });
  final String title;
  final int? numOfItems;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(width: size.width * 0.01),
            if (numOfItems != null)
              Text(
                "($numOfItems)",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
              ),
          ],
        ),
        if (onTap != null)
          TextButton(
            onPressed: onTap,
            child: Text(
              "Edit",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }
}
