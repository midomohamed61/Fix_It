import 'package:fix_it/featuers/auth/signup/cubit/cubit/signup_cubit.dart';
import 'package:fix_it/featuers/auth/signup/cubit/cubit/signup_state.dart';
import 'package:fix_it/featuers/auth/signin/widget/auth_custom_app_bar.dart';
import 'package:fix_it/featuers/auth/signin/widget/custom_password_field.dart';
import 'package:fix_it/featuers/auth/signin/widget/custom_text_field.dart';
import 'package:fix_it/featuers/auth/signin/widget/social_button.dart';
import 'package:fix_it/core/helpers/app_regex.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();

    return Scaffold(
      appBar: AuthCustomAppBar(onBack: () => Navigator.pop(context)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: cubit.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text("Create your account",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 20),

                CustomTextField(
                  hintText: "Name",
                  icon: Icons.person_outline,
                  controller: cubit.nameController,
                  validator: (value) =>
                      value!.isEmpty ? "Name is required" : null,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  hintText: "Email",
                  icon: Icons.email_outlined,
                  controller: cubit.emailController,
                  validator: (value) => AppRegex.isEmailValid(value!)
                      ? null
                      : "Invalid email format",
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  hintText: "Phone",
                  icon: Icons.phone_outlined,
                  controller: cubit.phoneController,
                  validator: (value) =>
                      value!.isEmpty ? "Phone is required" : null,
                ),
                const SizedBox(height: 16),

                CustomPasswordField(
                  controller: cubit.passwordController,
                  validator: (value) =>
                      value!.isEmpty ? "Password is required" : null,
                ),
                const SizedBox(height: 16),

                CustomPasswordField(
                  controller: cubit.passwordConfirmationController,
                  validator: (value) => value != cubit.passwordController.text
                      ? "Passwords do not match"
                      : null,
                ),
                const SizedBox(height: 16),

                BlocConsumer<SignupCubit, SignupState>(
                  listener: (context, state) {
                    if (state is SignupSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Signup Successful!')),
                      );
                      Navigator.pushNamed(context, '/HomeScreen');
                    } else if (state is SignupError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state is SignupLoading;
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () => cubit.emitSignupStates(),
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
                            : const Text("Sign Up",
                                style: TextStyle(color: Colors.white)),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Sign in",
                          style: const TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/SigninScreen');
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

                const Center(child: Text("Sign up with")),
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
