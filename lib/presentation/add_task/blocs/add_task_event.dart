part of 'add_task_bloc.dart';

final class AddTaskEvent extends Equatable {
  const AddTaskEvent({required this.task});

  final Task task;

  @override
  List<Object?> get props => [task];
}
