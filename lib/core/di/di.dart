import 'package:dio/dio.dart';
import 'package:fix_it/core/networking/api_service.dart';
import 'package:fix_it/core/networking/dio_factory.dart';
import 'package:fix_it/core/repos/signin_repo.dart';
import 'package:fix_it/core/repos/signup_repo.dart';
import 'package:fix_it/featuers/auth/account/cubit/service_type_cubit.dart';
import 'package:fix_it/featuers/auth/signin/cubit/cubit/signin_cubit.dart';
import 'package:fix_it/featuers/auth/signup/cubit/cubit/signup_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:fix_it/core/repos/profile_repo.dart';
import 'package:fix_it/core/repos/worker_repo.dart';
import 'package:fix_it/core/repos/customer_repo.dart';


final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  if (!getIt.isRegistered<ApiService>()) {
    getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
  }

  // login
  if (!getIt.isRegistered<SigninRepo>()) {
    getIt.registerLazySingleton<SigninRepo>(() => SigninRepo(getIt()));
  }
  getIt.registerFactory<SigninCubit>(() => SigninCubit(getIt()));

  // signup
  if (!getIt.isRegistered<SignupRepo>()) {
    getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt()));
  }
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt()));

  // Register ServiceTypeCubit 
  getIt.registerFactory<ServiceTypeCubit>(() => ServiceTypeCubit());

  if (!getIt.isRegistered<ProfileRepo>()) {
    getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepo(getIt()));
  }
  if (!getIt.isRegistered<WorkerRepo>()) {
    getIt.registerLazySingleton<WorkerRepo>(() => WorkerRepo(getIt()));
  }
  if (!getIt.isRegistered<CustomerRepo>()) {
    getIt.registerLazySingleton<CustomerRepo>(() => CustomerRepo(getIt()));
  }
}
