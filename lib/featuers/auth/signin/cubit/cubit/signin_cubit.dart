import 'package:fix_it/core/helpers/shared_pref_helper.dart';
import 'package:fix_it/core/models/auth/login_request_body.dart';
import 'package:fix_it/core/networking/dio_factory.dart';
import 'package:fix_it/core/repos/signin_repo.dart';
import 'package:fix_it/featuers/auth/signin/cubit/cubit/signin_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fix_it/core/networking/api_result.dart' as api_result;
import 'package:fix_it/core/models/auth/login_response.dart';

class SigninCubit extends Cubit<SigninState> {
  final SigninRepo _signinRepo;

  SigninCubit(this._signinRepo) : super(const SigninState.initial());

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Login Method
  Future<void> emitSigninStates() async {
    if (!formKey.currentState!.validate()) return;

    emit(const SigninState.Loading());

    final response = await _signinRepo.login(
      LoginRequestBody(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ),
    );

    if (response is api_result.Success<LoginResponse>) {
      final loginResponse = response.data;
      await SharedPrefHelper.setData('userId', loginResponse.id.toString());
      await SharedPrefHelper.setData('userEmail', loginResponse.email);
      await SharedPrefHelper.setData('userName', loginResponse.name);
      emit(SigninState.success(loginResponse));
    } else if (response is api_result.Failure<LoginResponse>) {
      final error = response.errorHandler;
      print('Signin error: [31m${error.message}[0m');
      String errorMsg = error.message ?? '';
      if (errorMsg.contains('500')) {
        errorMsg = 'Email or password is incorrect, or server error.';
      }
      emit(SigninState.error(error: errorMsg));
    }
  }

  // Save Token Locally and Add it to Dio Header
Future<void> _saveUserData(String token, String userName) async {
    await SharedPrefHelper.setData('userToken', token);
    await SharedPrefHelper.setData('userName', userName);
    DioFactory.setTokenIntoHeaderAfterLogin(token);
  }
}

