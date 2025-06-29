import 'package:fix_it/core/networking/api_service.dart';
import 'package:fix_it/core/networking/api_result.dart';
import 'package:fix_it/core/networking/api_error_handler.dart';
import '../models/customer/customer_data_request.dart';
import '../models/customer/customer_request.dart';
import '../models/customer/rate_request.dart';
import '../models/worker/request_response.dart';
import '../models/worker/worker_response.dart';

class CustomerRepo {
  final ApiService _apiService;
  CustomerRepo(this._apiService);

  Future<ApiResult<void>> updateCustomerData(CustomerDataRequest body) async {
    try {
      await _apiService.updateCustomerData(body);
      return const ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<WorkerResponse>>> findWorkers() async {
    try {
      final response = await _apiService.findWorkers();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> createCustomerRequest(CustomerRequest body) async {
    try {
      await _apiService.createCustomerRequest(body);
      return const ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<RequestResponse>>> getCustomerRequests(String userId) async {
    try {
      final response = await _apiService.getCustomerRequests(userId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> cancelCustomerRequest(String requestId) async {
    try {
      await _apiService.cancelCustomerRequest(requestId);
      return const ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> rateCustomerRequest(String requestId, RateRequest body) async {
    try {
      await _apiService.rateCustomerRequest(requestId, body);
      return const ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
} 