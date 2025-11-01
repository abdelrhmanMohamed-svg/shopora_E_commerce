import 'package:flutter/material.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';
import 'package:shopora_e_commerce/utils/app_router.dart';
import 'package:shopora_e_commerce/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'shopora_e_commerce',

      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          backgroundColor: AppColors.white,
          scrolledUnderElevation: 0.0,
        ),
        scaffoldBackgroundColor: AppColors.white,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.root,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
