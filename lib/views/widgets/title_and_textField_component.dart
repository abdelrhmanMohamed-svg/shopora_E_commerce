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
   
  });
  final String title;
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  

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
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
