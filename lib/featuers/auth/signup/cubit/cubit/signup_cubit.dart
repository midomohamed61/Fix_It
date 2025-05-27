import 'package:fix_it/core/helpers/shared_pref_helper.dart';
import 'package:fix_it/core/models/signup/sign_up_request_body.dart';
import 'package:fix_it/core/repos/signup_repo.dart';
import 'package:fix_it/featuers/auth/signup/cubit/cubit/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepo _signupRepo;
  SignupCubit(this._signupRepo) : super(const SignupState.initial());

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void emitSignupStates() async {
    if (formKey.currentState!.validate()) {
      emit(const SignupState.signupLoading());
      
      final response = await _signupRepo.signup(
        SignupRequestBody(
          name: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
          password: passwordController.text,
          passwordConfirmation: passwordConfirmationController.text,
          gender: 0,
        ),
      );

      response.when(
        success: (signupResponse) async {
          // حفظ بيانات المستخدم بعد نجاح عملية التسجيل
          await SharedPrefHelper.setData('name', nameController.text);
          await SharedPrefHelper.setData('email', emailController.text);
          await SharedPrefHelper.setData('phone', phoneController.text);
          await SharedPrefHelper.setData('password', passwordController.text);
          
          emit(SignupState.signupSuccess(signupResponse));
          
        },
        failure: (error) {
          emit(SignupState.signupError(error: error.apiErrorModel.message ?? ''));
        },
      );
    }
  }
}
