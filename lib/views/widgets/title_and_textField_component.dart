import 'package:flutter/material.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';

class TitleAndTextfieldComponent extends StatelessWidget {
  const TitleAndTextfieldComponent({
    super.key,
    required this.title,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.suffixIcon,
    this.isVisible = false,
  });
  final String title;
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: size.height * 0.01),

        TextFormField(
          validator: validator,
          keyboardType: keyboardType,
          controller: controller,
          obscureText: isVisible,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: AppColors.red),
            ),
            filled: true,
            fillColor: AppColors.grey100,
            prefixIcon: Icon(prefixIcon),
            prefixIconColor: AppColors.grey500,

            suffixIcon: suffixIcon,

            suffixIconColor: AppColors.grey500,

            hintText: hintText,
            hintStyle: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(color: AppColors.grey500),
          ),
        ),
      ],
    );
  }
}
