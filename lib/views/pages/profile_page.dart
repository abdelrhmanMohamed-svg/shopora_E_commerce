import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopora_e_commerce/model_views/auth_cubit/auth_cubit.dart';
import 'package:shopora_e_commerce/utils/app_routes.dart';
import 'package:shopora_e_commerce/views/widgets/custom_button.dart';
import 'package:shopora_e_commerce/views/widgets/profile_info.dart';
import 'package:shopora_e_commerce/views/widgets/social_media_row.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<AuthCubit, AuthState>(
      bloc: authCubit,
      buildWhen: (previous, current) =>
          current is FetchUser ||
          current is FetchUserError ||
          current is FecthUserLoading,
      builder: (context, state) {
        if (state is FecthUserLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        else if(state is FetchUser){
          final user=state.userData;
          return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: size.height * 0.055,
                      backgroundImage: CachedNetworkImageProvider(
                        "https://cdn4.vectorstock.com/i/1000x1000/82/33/person-gray-photo-placeholder-woman-vector-24138233.jpg",
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  ProfileInfo(
                    icon: Icons.person_2_outlined,
                    title: "Username",
                    data: user.username,
                  ),
                  SizedBox(height: size.height * 0.04),
                  ProfileInfo(
                    icon: Icons.email_outlined,
                    title: "Email or Phone Number",
                    data: user.email,
                  ),
                  SizedBox(height: size.height * 0.04),
                  Text(
                    "Acoount Linked With",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: size.height * 0.016),
                  SocialMediaRow(
                    imgUrl:
                        "https://pluspng.com/img-png/google-logo-png-open-2000.png",
                    title: "Google",
                    isProfile: true,
                  ),
                  SizedBox(height: size.height * 0.1),

                  BlocConsumer<AuthCubit, AuthState>(
                    bloc: authCubit,
                    listenWhen: (previous, current) =>
                        current is SiginOutSuccess,
                    listener: (context, state) {
                      if (state is SiginOutSuccess) {
                        Navigator.of(
                          context,
                          rootNavigator: true,
                        ).pushNamedAndRemoveUntil(
                          AppRoutes.loginRoute,
                          (route) => false,
                        );
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
                ],
              ),
            ),
          ),
        );

        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: size.height * 0.055,
                      backgroundImage: CachedNetworkImageProvider(
                        "https://cdn4.vectorstock.com/i/1000x1000/82/33/person-gray-photo-placeholder-woman-vector-24138233.jpg",
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  ProfileInfo(
                    icon: Icons.person_2_outlined,
                    title: "Username",
                    data: "default username",
                  ),
                  SizedBox(height: size.height * 0.04),
                  ProfileInfo(
                    icon: Icons.email_outlined,
                    title: "Email or Phone Number",
                    data: "default email or phone number",
                  ),
                  SizedBox(height: size.height * 0.04),
                  Text(
                    "Acoount Linked With",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: size.height * 0.016),
                  SocialMediaRow(
                    imgUrl:
                        "https://pluspng.com/img-png/google-logo-png-open-2000.png",
                    title: "Google",
                    isProfile: true,
                  ),
                  SizedBox(height: size.height * 0.1),

                  BlocConsumer<AuthCubit, AuthState>(
                    bloc: authCubit,
                    listenWhen: (previous, current) =>
                        current is SiginOutSuccess,
                    listener: (context, state) {
                      if (state is SiginOutSuccess) {
                        Navigator.of(
                          context,
                          rootNavigator: true,
                        ).pushNamedAndRemoveUntil(
                          AppRoutes.loginRoute,
                          (route) => false,
                        );
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
