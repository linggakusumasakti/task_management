part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

final class AddTaskEvent extends TaskEvent {
  final Task task;

  const AddTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}

final class GetTasksEvent extends TaskEvent {
  @override
  List<Object?> get props => [];
}

final class UpdateTaskEvent extends TaskEvent {
  final Task task;

  const UpdateTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}

final class DeleteTaskEvent extends TaskEvent {
  final int id;

  const DeleteTaskEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

final class FilterTasksEvent extends TaskEvent {
  final TaskStatus status;

  const FilterTasksEvent({required this.status});

  @override
  List<Object?> get props => [status];
}
