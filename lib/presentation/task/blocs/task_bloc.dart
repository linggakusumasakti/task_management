import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/domain/usecases/add_task.dart';
import 'package:task_management/domain/usecases/delete_task.dart';
import 'package:task_management/domain/usecases/get_tasks.dart';
import 'package:task_management/domain/usecases/update_task.dart';

import '../../../common/utils/status.dart';
import '../../../core/data/models/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final AddTask addTask;
  final GetTasks getTasks;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;

  TaskBloc(
      {required this.addTask,
      required this.getTasks,
      required this.updateTask,
      required this.deleteTask})
      : super(TaskState.initial()) {
    on<AddTaskEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: Status.loading));
        await addTask.execute(event.task);
        emit(state.copyWith(status: Status.success));
      } on FormatException catch (e) {
        emit(state.copyWith(status: Status.error, error: e.message));
      }
    });

    on<GetTasksEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: Status.loading));
        final tasks = await getTasks.execute();
        if (tasks.isEmpty) {
          emit(state.copyWith(status: Status.empty));
        } else {
          emit(state.copyWith(status: Status.success, tasks: tasks));
        }
      } on FormatException catch (e) {
        emit(state.copyWith(status: Status.error, error: e.message));
      }
    });

    on<UpdateTaskEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: Status.loading));
        await updateTask.execute(event.task);
        emit(state.copyWith(status: Status.success));
      } on FormatException catch (e) {
        emit(state.copyWith(status: Status.error, error: e.message));
      }
    });

    on<DeleteTaskEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: Status.loading));
        await deleteTask.execute(event.id);
        emit(state.copyWith(status: Status.success));
      } on FormatException catch (e) {
        emit(state.copyWith(status: Status.error, error: e.message));
      }
    });
  }
}
