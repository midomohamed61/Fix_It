import 'package:fix_it/core/helpers/shared_pref_helper.dart';
import 'package:fix_it/core/models/signin/login_request_body.dart';
import 'package:fix_it/core/networking/dio_factory.dart';
import 'package:fix_it/core/repos/signin_repo.dart';
import 'package:fix_it/featuers/auth/signin/cubit/cubit/signin_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    response.when(
      success: (loginResponse) async {
        final token = loginResponse.userData?.token ?? '';

        // Save Token & Set Header
        await _saveUserToken(token);

        emit(SigninState.success(loginResponse));
      },
      failure: (error) {
        emit(SigninState.error(error: error.apiErrorModel.message ?? 'Error'));
      },
    );
  }

  // Save Token Locally and Add it to Dio Header
  Future<void> _saveUserToken(String token) async {
    await SharedPrefHelper.setData('userToken', token); // Saving token
    DioFactory.setTokenIntoHeaderAfterLogin(token);
  }
}

