import 'package:fix_it/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:fix_it/featuers/auth/signup/cubit/cubit/signup_cubit.dart';

class PhoneVerificationScreen extends StatelessWidget {
  const PhoneVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signupCubit = context.read<SignupCubit>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Enter your Phone number to verify",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            InternationalPhoneNumberInput(
  onInputChanged: (PhoneNumber number) {
    signupCubit.phoneController.text = number.phoneNumber ?? "";
  },
  onInputValidated: (bool value) {
    print(value);
  },
  selectorConfig: const SelectorConfig(
    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
  ),
  textFieldController: signupCubit.phoneController,
  formatInput: true,
  keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
  inputDecoration: InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    hintText: 'Phone Number',
  ),
  initialValue: PhoneNumber(isoCode: 'ُEG'),
  ignoreBlank: false,
  autoValidateMode: AutovalidateMode.disabled,
  selectorTextStyle: const TextStyle(color: Colors.black),
),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Call SignupCubit function to process phone number
                  Navigator.pushNamed(context, '/nextScreen'); // مثلاً
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                ),
                child: const Text(
                  "Send Code",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: AppColors.backgroundColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
