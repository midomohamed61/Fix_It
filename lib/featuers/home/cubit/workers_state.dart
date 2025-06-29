part of 'workers_cubit.dart';

abstract class WorkersState {}

class WorkersInitial extends WorkersState {}
class WorkersLoading extends WorkersState {}
class WorkersLoaded extends WorkersState {
  final List<WorkerResponse> workers;
  WorkersLoaded(this.workers);
}
class WorkersError extends WorkersState {
  final String message;
  WorkersError(this.message);
} 