import 'package:fix_it/core/networking/api_service.dart';
import 'package:fix_it/core/networking/api_result.dart';
import 'package:fix_it/core/networking/api_error_handler.dart';
import 'package:dio/dio.dart';
import '../models/worker/worker_data_request.dart';
import '../models/worker/request_response.dart';
import '../models/worker/rate_response.dart';
import '../models/worker/comment_response.dart';
import '../models/worker/credential_response.dart';
import 'package:fix_it/core/networking/api_constant.dart';

class WorkerRepo {
  final ApiService _apiService;
  WorkerRepo(this._apiService);

  Future<ApiResult<void>> updateWorkerData(WorkerDataRequest body) async {
    try {
      await _apiService.updateWorkerData(body);
      return const ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<RequestResponse>>> getWorkerRequests(String workerId) async {
    try {
      final response = await _apiService.getWorkerRequests(workerId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<RateResponse>> getWorkerRate(String workerId) async {
    try {
      final response = await _apiService.getWorkerRate(workerId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<CommentResponse>>> getWorkerComments(String workerId) async {
    try {
      final response = await _apiService.getWorkerComments(workerId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<Response> uploadWorkerCredentialsWithDio(String workerId, String filePath) async {
    try {
      final dio = Dio();
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(filePath, filename: "credential.jpg"),
      });
      final response = await dio.post(
        "${ApiConstant.baseUrl}/worker/credentials/upload/$workerId",
        data: formData,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<ApiResult<List<CredentialResponse>>> getWorkerCredentials(String workerId) async {
    try {
      final response = await _apiService.getWorkerCredentials(workerId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> acceptWorkerRequest(String requestId) async {
    try {
      await _apiService.acceptWorkerRequest(requestId);
      return const ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> cancelWorkerRequest(String requestId) async {
    try {
      await _apiService.cancelWorkerRequest(requestId);
      return const ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
} 