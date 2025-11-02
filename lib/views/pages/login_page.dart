import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shopora_e_commerce/model_views/auth_cubit/auth_cubit.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';
import 'package:shopora_e_commerce/utils/app_routes.dart';
import 'package:shopora_e_commerce/views/widgets/custom_button.dart';
import 'package:shopora_e_commerce/views/widgets/social_media_row.dart';
import 'package:shopora_e_commerce/views/widgets/title_and_textField_component.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController usernameController;
  AuthFormat authFormat = AuthFormat.login;
  late GlobalKey<FormState> _formKey;
  bool isVisible = true;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    usernameController = TextEditingController();
    _formKey = GlobalKey<FormState>();
        FlutterNativeSplash.remove();

  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
          child: SingleChildScrollView(
            child: BlocBuilder<AuthCubit, AuthState>(
              bloc: authCubit,
              buildWhen: (previous, current) => current is ToggleAuth,
              builder: (context, state) {
                if (state is ToggleAuth) {
                  authFormat = state.authFormat;
                }

                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      authFormat == AuthFormat.login
                          ? Text(
                              "Login Account",
                              style: Theme.of(context).textTheme.headlineSmall!
                                  .copyWith(fontWeight: FontWeight.w600),
                            )
                          : Text(
                              "Create Account",
                              style: Theme.of(context).textTheme.headlineSmall!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                      SizedBox(height: size.height * 0.01),

                      authFormat == AuthFormat.login
                          ? Text(
                              "Please login with registered account",
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(color: AppColors.grey500),
                            )
                          : Text(
                              "Start shopping with create your account",
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(color: AppColors.grey500),
                            ),
                      SizedBox(height: size.height * 0.05),
                      if (authFormat == AuthFormat.register) ...[
                        TitleAndTextfieldComponent(
                          title: "Username",
                          hintText: "Enter your username",
                          prefixIcon: Icons.person_2_outlined,
                          controller: usernameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter username";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: size.height * 0.03),
                      ],
                      TitleAndTextfieldComponent(
                        title: "Email or Phone Number",
                        hintText: "Enter your email or phone number",
                        prefixIcon: Icons.email_outlined,
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter email or phone Number";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                      BlocBuilder<AuthCubit, AuthState>(
                        bloc: authCubit,
                        buildWhen: (previous, current) =>
                            current is ToggleVisibilty,
                        builder: (context, state) {
                          if (state is ToggleVisibilty) {
                            isVisible = state.isVisible;
                          }
                          return TitleAndTextfieldComponent(
                            title: "Password",
                            hintText: "Enter your password",
                            prefixIcon: Icons.password_outlined,
                            controller: passwordController,
                            isVisible: isVisible,
                            suffixIcon: InkWell(
                              onTap: () => authCubit.toggleVisibilty(isVisible),
                              child: Icon(
                                isVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter password";
                              } else {
                                return null;
                              }
                            },
                          );
                        },
                      ),
                      SizedBox(height: size.height * 0.005),
                      authFormat == AuthFormat.login
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text("Forgot Password?"),
                              ),
                            )
                          : SizedBox.shrink(),
                      SizedBox(height: size.height * 0.04),
                      CustomButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context).pushNamed(AppRoutes.root);
                          }
                        },
                        title: authFormat == AuthFormat.login
                            ? "Login"
                            : "Register",
                      ),
                      SizedBox(height: size.height * 0.005),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                if (authFormat == AuthFormat.login) {
                                  authCubit.toggleAuth(AuthFormat.login);
                                } else {
                                  authCubit.toggleAuth(AuthFormat.register);
                                }
                              },
                              child: Text(
                                authFormat == AuthFormat.login
                                    ? "or create new account"
                                    : "Already have an account?",
                                style: Theme.of(context).textTheme.titleSmall!
                                    .copyWith(color: AppColors.grey500),
                              ),
                            ),
                            SizedBox(height: size.height * 0.03),
                            Text(
                              "or using other methd",
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(color: AppColors.grey500),
                            ),
                            SizedBox(height: size.height * 0.03),
                            SocialMediaRow(
                              imgUrl:
                                  "https://pluspng.com/img-png/google-logo-png-open-2000.png",
                              title: "Sign in with Google",
                            ),
                            SizedBox(height: size.height * 0.015),
                            SocialMediaRow(
                              imgUrl:
                                  "https://starfinderfoundation.org/wp-content/uploads/2015/07/Facebook-logo-blue-circle-large-transparent-png.png",
                              title: "Sign in with Google",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
