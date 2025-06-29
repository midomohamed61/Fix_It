import 'package:fix_it/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/service_type_cubit.dart';
import 'package:fix_it/core/models/auth/signup_response.dart';
import 'package:fix_it/core/repos/worker_repo.dart';
import 'package:fix_it/core/repos/customer_repo.dart';
import 'package:fix_it/core/models/worker/worker_data_request.dart';
import 'package:fix_it/core/models/customer/customer_data_request.dart';
import 'package:fix_it/core/di/di.dart';
import 'package:fix_it/core/networking/api_result.dart';
import 'package:fix_it/core/repos/signup_repo.dart';
import 'package:fix_it/core/models/auth/signup_request_body.dart';
import 'package:fix_it/core/helpers/shared_pref_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoleSelectionScreen extends StatelessWidget {
  final SignupResponse signupResponse;
  const RoleSelectionScreen({super.key, required this.signupResponse});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ServiceTypeCubit>();
    final workerRepo = getIt<WorkerRepo>();
    final customerRepo = getIt<CustomerRepo>();

    Future<void> handleNext(ServiceType type) async {
      // Save the selected role in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      
      if (type == ServiceType.provider) {
        // Save role as worker
        await prefs.setString('user_role', 'worker');
        
        final req = WorkerDataRequest(
          workerId: signupResponse.id.toString(),
          email: signupResponse.email,
          name: signupResponse.name,
          jobTitle: '',
          address: '',
          latitude: '',
          longitude: '',
          age: '',
          about: '',
          phoneNumber: '',
          skills: '',
        );
        await workerRepo.updateWorkerData(req);
        
        // Continue to phone verification for worker
        Navigator.pushNamed(context, '/PhoneVerificationScreen');
        
      } else if (type == ServiceType.seeker) {
        // Save role as customer
        await prefs.setString('user_role', 'customer');
        
        final req = CustomerDataRequest(
          userId: signupResponse.id.toString(),
          name: signupResponse.name,
          phoneNumber: '',
          age: '',
        );
        await customerRepo.updateCustomerData(req);
        
        // For customer, go directly to phone verification and stop there
        Navigator.pushNamed(context, '/PhoneVerificationScreen');
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "I am",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            BlocBuilder<ServiceTypeCubit, ServiceTypeState>(
              builder: (context, state) {
                return Column(
                  children: [
                    // Service Provider Option
                    RadioListTile<ServiceType>(
                      title: const Text("Service Provider"),
                      subtitle: const Text("I offer professional services."),
                      value: ServiceType.provider,
                      groupValue: state.serviceType,
                      onChanged: (value) {
                        cubit.selectServiceProvider();
                      },
                      activeColor: AppColors.primaryColor,
                    ),
                    
                    // Looking For Service Option
                    RadioListTile<ServiceType>(
                      title: const Text("Looking For Service"),
                      subtitle: const Text("I am looking for home services."),
                      value: ServiceType.seeker,
                      groupValue: state.serviceType,
                      onChanged: (value) {
                        cubit.selectLookingForService();
                      },
                      activeColor: AppColors.primaryColor,
                    ),
                  ],
                );
              },
            ),
            const Spacer(),
            // Next Button
            BlocBuilder<ServiceTypeCubit, ServiceTypeState>(
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state.serviceType == ServiceType.none
                        ? null
                        : () {
                            handleNext(state.serviceType);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    child: const Text("Next"),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SignupCubit extends Cubit<void> {
  final SignupRepo signupRepo;
  SignupCubit(this.signupRepo) : super(null);

  Future<ApiResult<SignupResponse>> signup({
    required String email,
    required String name,
    required String password,
    required String role,
  }) async {
    return await signupRepo.signup(
      SignupRequestBody(
        email: email,
        name: name,
        password: password,
        role: role,
      ),
    );
  }
}
