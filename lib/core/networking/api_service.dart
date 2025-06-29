import 'package:dio/dio.dart';
import 'package:fix_it/core/networking/api_constant.dart';
import 'package:retrofit/retrofit.dart';
import '../models/auth/login_request_body.dart';
import '../models/auth/login_response.dart';
import '../models/auth/signup_request_body.dart';
import '../models/auth/signup_response.dart';
import '../models/auth/activate_request_body.dart';
import '../models/profile/profile_response.dart';
import '../models/worker/worker_data_request.dart';
import '../models/worker/request_response.dart';
import '../models/worker/rate_response.dart';
import '../models/worker/comment_response.dart';
import '../models/worker/credential_response.dart';
import '../models/worker/worker_response.dart';
import '../models/customer/customer_data_request.dart';
import '../models/customer/customer_request.dart';
import '../models/customer/rate_request.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // Auth
  @POST("/auth/signup")
  Future<SignupResponse> signup(@Body() SignupRequestBody body);

  @POST("/auth/active")
  Future<void> activate(@Body() ActivateRequestBody body);

  @POST("/auth/login")
  Future<LoginResponse> login(@Body() LoginRequestBody body);

  // Profile
  @GET("/profile/{userId}")
  Future<ProfileResponse> getProfile(@Path("userId") String userId);

  @GET("/profile/image/{userId}")
  Future<HttpResponse> getProfileImage(@Path("userId") String userId);

  @PATCH("/profile/{userId}")
  Future<ProfileResponse> updateProfile(@Path("userId") String userId, @Body() Map<String, dynamic> body);

  // Worker
  @POST("/worker/data")
  Future<void> updateWorkerData(@Body() WorkerDataRequest body);

  @GET("/worker/request/{workerId}")
  Future<List<RequestResponse>> getWorkerRequests(@Path("workerId") String workerId);

  @GET("/worker/rate/{workerId}")
  Future<RateResponse> getWorkerRate(@Path("workerId") String workerId);

  @GET("/worker/comments/{workerId}")
  Future<List<CommentResponse>> getWorkerComments(@Path("workerId") String workerId);

  @GET("/worker/credentials/{workerId}")
  Future<List<CredentialResponse>> getWorkerCredentials(@Path("workerId") String workerId);

  @POST("/worker/request/accept/{requestId}")
  Future<void> acceptWorkerRequest(@Path("requestId") String requestId);

  @POST("/worker/request/cancel/{requestId}")
  Future<void> cancelWorkerRequest(@Path("requestId") String requestId);

  // Customer
  @POST("/customer/data")
  Future<void> updateCustomerData(@Body() CustomerDataRequest body);

  @GET("/customer/find")
  Future<List<WorkerResponse>> findWorkers();

  @POST("/customer/request")
  Future<void> createCustomerRequest(@Body() CustomerRequest body);

  @GET("/customer/request/{userId}")
  Future<List<RequestResponse>> getCustomerRequests(@Path("userId") String userId);

  @POST("/customer/request/cancel/{requestId}")
  Future<void> cancelCustomerRequest(@Path("requestId") String requestId);

  @POST("/customer/request/rate/{requestId}")
  Future<void> rateCustomerRequest(
    @Path("requestId") String requestId,
    @Body() RateRequest body,
  );
}