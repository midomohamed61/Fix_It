import 'package:fix_it/core/models/auth/signup_request_body.dart';
import 'package:fix_it/core/models/auth/signup_response.dart';
import 'package:fix_it/core/models/auth/activate_request_body.dart';
import 'package:fix_it/core/networking/api_error_handler.dart';
import 'package:fix_it/core/networking/api_result.dart';
import 'package:fix_it/core/networking/api_service.dart';

class SignupRepo {
  final ApiService _apiService;

  SignupRepo(this._apiService);

  Future<ApiResult<SignupResponse>> signup(SignupRequestBody signupRequestBody) async {
    try {
      final response = await _apiService.signup(signupRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> activate(ActivateRequestBody body) async {
    try {
      await _apiService.activate(body);
      return const ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}