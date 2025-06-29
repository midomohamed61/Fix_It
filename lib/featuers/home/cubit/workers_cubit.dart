import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fix_it/core/models/worker/worker_response.dart';
import 'package:fix_it/core/repos/customer_repo.dart';
import 'package:fix_it/core/di/di.dart';
import 'package:fix_it/core/helpers/shared_pref_helper.dart';
import 'package:fix_it/core/helpers/constants.dart';
import 'package:fix_it/core/networking/api_result.dart';

part 'workers_state.dart';

class WorkersCubit extends Cubit<WorkersState> {
  WorkersCubit() : super(WorkersInitial());

  Future<void> fetchWorkers() async {
    emit(WorkersLoading());
    try {
      final token = await SharedPrefHelper.getString(SharedPrefKeys.userToken);
      if (token != null && token.isNotEmpty) {
        // Set token in Dio headers if needed
      }
      final customerRepo = getIt<CustomerRepo>();
      final result = await customerRepo.findWorkers();
      if (result is Success<List<WorkerResponse>>) {
        emit(WorkersLoaded(result.data));
      } else {
        emit(WorkersError('Failed to load workers'));
      }
    } catch (e) {
      emit(WorkersError(e.toString()));
    }
  }
} 