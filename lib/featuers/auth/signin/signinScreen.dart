import 'package:fix_it/core/themes/app_colors.dart';
import 'package:fix_it/featuers/auth/signin/cubit/cubit/signin_cubit.dart';
import 'package:fix_it/featuers/auth/signin/cubit/cubit/signin_state.dart';
import 'package:fix_it/featuers/auth/signin/widget/auth_custom_app_bar.dart';
import 'package:fix_it/featuers/auth/signin/widget/custom_password_field.dart';
import 'package:fix_it/featuers/auth/signin/widget/custom_text_field.dart';
import 'package:fix_it/featuers/auth/signin/widget/social_button.dart';
import 'package:fix_it/core/helpers/app_regex.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fix_it/featuers/BottomNavBar.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SigninCubit>();

    return Scaffold(
      appBar: AuthCustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: cubit.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text("Sign in to your account",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 20),

                CustomTextField(
                  hintText: "Email",
                  icon: Icons.email_outlined,
                  controller: cubit.emailController,
                  validator: (value) => AppRegex.isEmailValid(value!)
                      ? null
                      : "Invalid email format",
                ),
                const SizedBox(height: 16),

                CustomPasswordField(
                  controller: cubit.passwordController,
                  validator: (value) =>
                      value!.isEmpty ? "Password is required" : null,
                ),
                const SizedBox(height: 16),

                BlocConsumer<SigninCubit, SigninState>(
                  listener: (context, state) {
                    if (state is Success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login Successful!')),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => BottomNavBar()),
                      );
                    } else if (state is Error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state is Loading;
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () => cubit.emitSigninStates(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: AppColors.backgroundColor,
                              )
                            : const Text("Sign In",
                                style: TextStyle(color: AppColors.backgroundColor)),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Sign up now",
                          style: const TextStyle(
                              color: AppColors.primaryColor, fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/SignupScreen');
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  children: const [
                    Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Or"),
                    ),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),
                const SizedBox(height: 20),

                const Center(child: Text("Sign in with")),
                const SizedBox(height: 16),

                SocialButton(
                  icon: FontAwesomeIcons.google,
                  text: 'Google',
                  onPressed: () {},
                ),
                const SizedBox(height: 10),
                SocialButton(
                  icon: FontAwesomeIcons.facebook,
                  text: 'Facebook',
                  onPressed: () {},
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
