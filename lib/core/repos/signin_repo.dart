

import 'package:fix_it/core/models/login_request_body.dart';
import 'package:fix_it/core/models/login_response.dart';
import 'package:fix_it/core/networking/api_error_handler.dart';
import 'package:fix_it/core/networking/api_result.dart';
import 'package:fix_it/core/networking/api_service.dart';

class SigninRepo {
  final ApiService _apiService;

  SigninRepo(this._apiService);

  Future<ApiResult<LoginResponse>> login(LoginRequestBody loginRequestBody) async {
  try {
    final response = await _apiService.login(loginRequestBody);
    return ApiResult.success(response);
  } catch (error) {
    return ApiResult.failure(ErrorHandler.handle(error));
  }
}

}