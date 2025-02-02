part of 'add_task_bloc.dart';

class AddTaskState extends Equatable {
  final Status status;
  final String? error;

  const AddTaskState({required this.status, this.error});

  static AddTaskState initial() => const AddTaskState(status: Status.initial);

  AddTaskState copyWith({Status? status, String? error}) =>
      AddTaskState(status: status ?? this.status, error: error ?? this.error);

  @override
  List<Object?> get props => [status, error];
}
