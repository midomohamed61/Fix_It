import 'package:fix_it/core/helpers/constants.dart';
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

  /// Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /// Form Key
  final formKey = GlobalKey<FormState>();

  /// Login Method
  Future<void> emitSigninStates() async {
    if (!formKey.currentState!.validate()) return; // Stop if form is not valid

    emit(const SigninState.Loading()); // Emit loading state

    final response = await _signinRepo.login(
      LoginRequestBody(
        email: emailController.text.trim(), // Trim for safety
        password: passwordController.text.trim(),
      ),
    );

    response.when(
      success: (loginResponse) async {
        final token = loginResponse.userData?.token ?? '';

        /// Save Token & Set Header
        await _saveUserToken(token);

        /// Emit success state with data
        emit(SigninState.success(loginResponse));
      },
      failure: (error) {
        emit(SigninState.error(
          error: error.apiErrorModel.message ?? 'حدث خطأ ما!',
        ));
      },
    );
  }

  /// Save Token Locally and Add it to Dio Header
  Future<void> _saveUserToken(String token) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    DioFactory.setTokenIntoHeaderAfterLogin(token);
  }

  /// Dispose Controllers when Needed (Optional for better management)
  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }
}
