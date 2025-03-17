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

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SignInScreenBody();
  }
}

class SignInScreenBody extends StatelessWidget {
  const SignInScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SigninCubit>();

    return Scaffold(
      appBar: AuthCustomAppBar(
        onBack: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: cubit.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Enter your email and password to login",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),

                /// Email Field
                CustomTextField(
                  hintText: "Enter your email",
                  icon: Icons.email_outlined,
                  controller: cubit.emailController,
                  validator: (value) => AppRegex.isEmailValid(value!)
                      ? null
                      : "Invalid email format",
                ),
                const SizedBox(height: 16),

                /// Password Field
                CustomPasswordField(
                  controller: cubit.passwordController,
                  validator: (value) =>
                      value!.isEmpty ? "Password is required" : null,
                ),
                const SizedBox(height: 8),

                /// Forgot Password Button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {}, // Forgot password logic
                    child: const Text("Forgot Password?"),
                  ),
                ),
                const SizedBox(height: 16),

                /// Sign In Button with BlocConsumer
                BlocConsumer<SigninCubit, SigninState>(
                  listener: (context, state) {
                    if (state is Success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Login Successful!")),
                      );
                      Navigator.pushNamed(context, '/HomeScreen');
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
                            : () {
                                if (cubit.formKey.currentState!.validate()) {
                                  cubit.emitSigninStates();
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Sign In",
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                /// Sign Up Redirect
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: "New to fixIt? ",
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Sign up now",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
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

                /// Divider
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

                /// Social Login
                const Center(child: Text("Log in with")),
                const SizedBox(height: 16),
                Row(
                  children: [
                    /// Google Button
                    Flexible(
                      child: SocialButton(
                        icon: FontAwesomeIcons.google,
                        text: 'Google',
                        onPressed: () {}, // Google login
                      ),
                    ),
                    const SizedBox(width: 10),

                    /// Facebook Button
                    Flexible(
                      child: SocialButton(
                        icon: FontAwesomeIcons.facebook,
                        text: 'Facebook',
                        onPressed: () {}, // Facebook login
                      ),
                    ),
                  ],
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
