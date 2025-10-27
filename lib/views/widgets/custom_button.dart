import 'package:flutter/material.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onPressed, this.child, this.title})
    : assert(child != null || title != null);
  final VoidCallback? onPressed;
  final Widget? child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.06,
      width: size.width,

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onPressed: onPressed,
        child: title != null ? Text(title!) : child!,
      ),
    );
  }
}
