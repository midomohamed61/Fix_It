import 'package:fix_it/core/helpers/shared_pref_helper.dart';
import 'package:fix_it/core/models/auth/signup_request_body.dart';
import 'package:fix_it/core/repos/signup_repo.dart';
import 'package:fix_it/featuers/auth/signup/cubit/cubit/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fix_it/core/networking/api_result.dart' as api_result;
import 'package:fix_it/core/models/auth/signup_response.dart';
import 'package:fix_it/core/models/auth/activate_request_body.dart';

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
          password: passwordController.text,
          role: 'USER', // أو حسب اختيار المستخدم
        ),
      );
      if (response is api_result.Success<SignupResponse>) {
        final signupResponse = response.data;
        await SharedPrefHelper.setData('name', nameController.text);
        await SharedPrefHelper.setData('email', emailController.text);
        await SharedPrefHelper.setData('password', passwordController.text);
        emit(SignupState.signupSuccess(signupResponse));
      } else if (response is api_result.Failure<SignupResponse>) {
        final error = response.errorHandler;
        print('Signup error: [31m${error.message}[0m');
        emit(SignupState.signupError(error: error.message ?? ''));
      }
    }
  }

  Future<api_result.ApiResult<void>> activateAccount(String email, String code) async {
    return await _signupRepo.activate(ActivateRequestBody(email: email, code: code));
  }
}
