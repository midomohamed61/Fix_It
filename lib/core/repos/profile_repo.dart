import 'package:fix_it/core/networking/api_service.dart';
import 'package:fix_it/core/networking/api_result.dart';
import 'package:fix_it/core/networking/api_error_handler.dart';
import 'package:dio/dio.dart';
import '../models/profile/profile_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:fix_it/core/networking/api_constant.dart';

class ProfileRepo {
  final ApiService _apiService;
  ProfileRepo(this._apiService);

  Future<ApiResult<ProfileResponse>> getProfile(String userId) async {
    try {
      final response = await _apiService.getProfile(userId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<HttpResponse>> getProfileImage(String userId) async {
    try {
      final response = await _apiService.getProfileImage(userId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<Response> uploadProfileImageWithDio(String userId, String filePath) async {
    try {
      final dio = Dio();
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(filePath, filename: "image.jpg"),
      });
      final response = await dio.post(
        "${ApiConstant.baseUrl}/profile/image/upload/$userId",
        data: formData,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<ApiResult<ProfileResponse>> updateProfile(String userId, Map<String, dynamic> body) async {
    try {
      final response = await _apiService.updateProfile(userId, body);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
} 