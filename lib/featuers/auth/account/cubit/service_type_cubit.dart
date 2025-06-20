import 'package:bloc/bloc.dart';

part 'service_type_state.dart';

class ServiceTypeCubit extends Cubit<ServiceTypeState> {
  ServiceTypeCubit() : super(ServiceTypeState.initial());

  void selectServiceProvider() {
    emit(ServiceTypeState(serviceType: ServiceType.provider));
  }

  void selectLookingForService() {
    emit(ServiceTypeState(serviceType: ServiceType.seeker));
  }

  void clearSelection() {
    emit(ServiceTypeState.initial());
  }
}
