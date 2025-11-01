import 'package:flutter/material.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';

void showCustomSnackBar(
  BuildContext context,
  String message, {
  SnackBarAction? action,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyle(color: Colors.white)),
      backgroundColor: AppColors.primary,
      duration: Duration(seconds: 2),
      action: action,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
    ),
  );
}
