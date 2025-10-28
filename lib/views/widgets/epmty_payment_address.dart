import 'package:flutter/material.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';

class EpmtyPaymentAddress extends StatelessWidget {
  const EpmtyPaymentAddress({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.12,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, size: size.height * 0.03, color: AppColors.black),
          SizedBox(height: size.height * 0.001),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
