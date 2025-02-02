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