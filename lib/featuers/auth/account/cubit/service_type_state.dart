part of 'service_type_cubit.dart';

enum ServiceType { provider, seeker, none }

class ServiceTypeState {
  final ServiceType serviceType;

  const ServiceTypeState({required this.serviceType});

  factory ServiceTypeState.initial() {
    return const ServiceTypeState(serviceType: ServiceType.none);
  }
}
