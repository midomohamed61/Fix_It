import 'package:fix_it/core/helpers/constants.dart';
import 'package:fix_it/core/helpers/shared_pref_helper.dart';
import 'package:fix_it/core/models/login_request_body.dart';
import 'package:fix_it/core/networking/dio_factory.dart' show DioFactory;
import 'package:fix_it/core/repos/signin_repo.dart';
import 'package:fix_it/featuers/auth/signin/cubit/cubit/signin_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SigninCubit extends Cubit<SigninRepo> {
  final SigninRepo _signinRepo;
  SigninCubit(this._signinRepo) : super(const SigninState.initial() as SigninRepo);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void emitLoginStates() async {
    emit(const SigninState.loading() as SigninRepo);
    final response = await _signinRepo.login(
      LoginRequestBody(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    response.when(success: (loginResponse) async {
      await saveUserToken(loginResponse.userData?.token ?? '');
      emit(SigninState.success(loginResponse) as SigninRepo);
    }, failure: (error) {
      emit(SigninState.error(error: error.apiErrorModel.message ?? '') as SigninRepo);
    });
  }

  Future<void> saveUserToken(String token) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    DioFactory.setTokenIntoHeaderAfterLogin(token);
  }
}