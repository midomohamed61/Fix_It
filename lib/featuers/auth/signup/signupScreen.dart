import 'package:fix_it/core/helpers/app_regex.dart';
import 'package:fix_it/featuers/auth/signin/widget/auth_custom_app_bar.dart';
import 'package:fix_it/featuers/auth/signin/widget/custom_password_field.dart' show CustomPasswordField;
import 'package:fix_it/featuers/auth/signin/widget/custom_text_field.dart';
import 'package:fix_it/featuers/auth/signin/widget/social_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../signin/widget/custom_checkbox_row.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthCustomAppBar(
        onBack: () => Navigator.pop(context), // action عند الضغط على زر الرجوع
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Enter your email and password to login",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 20),

                // Full Name
                CustomTextField(
                  hintText: "Full name",
                  icon: Icons.person,
                  controller: _fullName,
                  validator: (val) => val!.isEmpty ? "Name required" : null,
                ),
                const SizedBox(height: 15),

                // Email
                CustomTextField(
                  hintText: "Enter your email",
                  icon: Icons.email_outlined,
                  controller: _email,
                  validator: (val) => AppRegex.isEmailValid(val!) ? null : "Invalid email",
                ),
                const SizedBox(height: 15),

                // Password
                CustomPasswordField(
                  controller: _password,
                  validator: (val) => AppRegex.isPasswordValid(val!) ? null : "Invalid password",
                ),
                const SizedBox(height: 10),

                // Terms
                CustomCheckboxRow(value: _checked, onChanged: (v) => setState(() => _checked = v!)),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() && _checked) {
                        // Sign Up Logic
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text("Sign Up"),
                  ),
                ),
                const SizedBox(height: 20),

                // Already have account
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      children: [
                        TextSpan(
                          text: "Sign in now",
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/SigninScreen'); // ✅ انتقل لصفحة تسجيل الدخول
                            },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Row(children: [Expanded(child: Divider()), Text("Or"), Expanded(child: Divider())]),
                const SizedBox(height: 20),
                Center(child: Text("Sign up with")),
                const SizedBox(height: 20),

                Row(
                  children: [
                    SocialButton(icon: FontAwesomeIcons.google, text: 'Google', onPressed: () {}),
                    const SizedBox(width: 10),
                    SocialButton(icon: FontAwesomeIcons.facebook, text: 'Facebook', onPressed: () {}),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
