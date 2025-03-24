import 'package:fix_it/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/service_type_cubit.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ServiceTypeCubit>();

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
                            Navigator.pushNamed(context, '/PhoneVerificationScreen');
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
