import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shopora_e_commerce/firebase_options.dart';
import 'package:shopora_e_commerce/model_views/auth_cubit/auth_cubit.dart';
import 'package:shopora_e_commerce/model_views/favorites_cubit/favorites_cubit.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';
import 'package:shopora_e_commerce/utils/app_router.dart';
import 'package:shopora_e_commerce/utils/app_routes.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final authCubit = AuthCubit();
            authCubit.authCheck();
            return authCubit;
          },
        ),
        BlocProvider(
          create: (context) {
            final favoritesCubit = FavoritesCubit();
            favoritesCubit.fetchFavorites();
            return favoritesCubit;
          },
        ),
      ],
      child: Builder(
        builder: (context) {
          final authCubit = BlocProvider.of<AuthCubit>(context);
          return BlocBuilder<AuthCubit, AuthState>(
            bloc: authCubit,
            buildWhen: (previous, current) =>
                current is AuthSuccess || current is AuthInitial,
            builder: (context, state) {
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
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.deepPurple,
                  ),
                ),
                initialRoute: state is AuthSuccess
                    ? AppRoutes.root
                    : AppRoutes.loginRoute,
                onGenerateRoute: AppRouter.onGenerateRoute,
              );
            },
          );
        },
      ),
    );
  }
}
