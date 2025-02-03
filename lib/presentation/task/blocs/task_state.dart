part of 'task_bloc.dart';

class TaskState extends Equatable {
  final Status status;
  final List<Task>? tasks;
  final String? error;

  const TaskState({required this.status, this.tasks, this.error});

  static TaskState initial() => const TaskState(status: Status.initial);

  TaskState copyWith({Status? status, List<Task>? tasks, String? error}) =>
      TaskState(
          status: status ?? this.status,
          tasks: tasks ?? this.tasks,
          error: error ?? this.error);

  String getInformationTask() {
    if (tasks?.isEmpty ?? false || tasks == null) {
      return 'Let\'s create a task. Get things done, one task at a time!';
    }
    var total = 0;
    for (Task task in tasks!) {
      if (task.status != TaskStatus.completed) {
        total++;
      }
    }
    if (total == 0) {
      return 'You have completed the task';
    } else if (total < 2) {
      return 'You have 1 task to complete';
    } else {
      return 'You have $total tasks to complete';
    }
  }

  @override
  List<Object?> get props => [status, tasks, error];
}
