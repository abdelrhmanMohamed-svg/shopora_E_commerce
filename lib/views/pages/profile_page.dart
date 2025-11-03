import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopora_e_commerce/model_views/auth_cubit/auth_cubit.dart';
import 'package:shopora_e_commerce/utils/app_routes.dart';
import 'package:shopora_e_commerce/views/widgets/custom_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Center(
        child: BlocConsumer<AuthCubit, AuthState>(
          bloc: authCubit,
          listenWhen: (previous, current) => current is SiginOutSuccess,
          listener: (context, state) {
            if (state is SiginOutSuccess) {
              Navigator.of(
                context,rootNavigator: true
              ).pushNamedAndRemoveUntil(AppRoutes.loginRoute, (route) => false,);
            }
          },
          buildWhen: (previous, current) => current is SignOutLoading,
          builder: (context, state) {
            if (state is SignOutLoading) {
              return CustomButton(
                child: const CircularProgressIndicator.adaptive(),
              );
            }
            return CustomButton(
              title: "Sign Out",
              onPressed: () => authCubit.signOut(),
            );
          },
        ),
      ),
    );
  }
}
