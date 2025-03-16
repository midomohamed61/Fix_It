import 'package:fix_it/core/helpers/app_regex.dart';
import 'package:fix_it/featuers/auth/signin/widget/auth_custom_app_bar.dart';
import 'package:fix_it/featuers/auth/signin/widget/custom_password_field.dart' show CustomPasswordField;
import 'package:fix_it/featuers/auth/signin/widget/custom_text_field.dart';
import 'package:fix_it/featuers/auth/signin/widget/social_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthCustomAppBar(
        onBack: () => Navigator.pop(context), // action عند الضغط على زر الرجوع
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
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

                // Email Field
                CustomTextField(
                  hintText: "Enter your email",
                  icon: Icons.email_outlined,
                  controller: _emailController,
                  validator: (value) => AppRegex.isEmailValid(value!) ? null : "Invalid email",
                ),
                const SizedBox(height: 16),

                // Password Field
                CustomPasswordField(
                  controller: _passwordController,
                  validator: (value) => value!.isEmpty ? "Password required" : null,
                ),
                const SizedBox(height: 8),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {}, // Forgot password
                    child: const Text("Forgot Password?"),
                  ),
                ),

                // Sign In Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Login process
                      }
                    },
                    child: const Text("Sign In"),
                  ),
                ),
                const SizedBox(height: 20),

                // Sign Up Now
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
              Navigator.pushNamed(context, '/SignupScreen'); // ✅ هنا بينتقل لصفحة التسجيل
            },
        ),
      ],
    ),
  ),
),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: const Text("Or"),
                    ),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),
                const SizedBox(height: 20),
                Center(child: const Text("Log in with")),
                const SizedBox(height: 16),

                Row(
                  children: [
                    SocialButton(icon: FontAwesomeIcons.google, text: 'Google', onPressed: () {}),
                    const SizedBox(width: 10),
                    SocialButton(icon: FontAwesomeIcons.facebook, text: 'Facebook', onPressed: () {}),
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
