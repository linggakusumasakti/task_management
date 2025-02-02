import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/core/data/models/task.dart';
import 'package:task_management/domain/usecases/add_task.dart';

import '../../../common/utils/status.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final AddTask addTask;

  AddTaskBloc({required this.addTask}) : super(AddTaskState.initial()) {
    on<AddTaskEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: Status.loading));
        await addTask.execute(event.task);
        emit(state.copyWith(status: Status.success));
      } on FormatException catch (e) {
        emit(state.copyWith(status: Status.error, error: e.message));
      }
    });
  }
}
