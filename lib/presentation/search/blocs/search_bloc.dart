import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/utils/status.dart';
import '../../../core/data/models/task.dart';
import '../../../domain/usecases/search_tasks.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchTasks searchTasks;

  SearchBloc({required this.searchTasks}) : super(SearchState.initial()) {
    on<SearchTasksEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: Status.loading, tasks: []));
        final tasks = await searchTasks.execute(event.query);
        if (tasks.isEmpty) {
          emit(state.copyWith(status: Status.empty, tasks: []));
        } else {
          emit(state.copyWith(status: Status.success, tasks: tasks));
        }
      } on FormatException catch (e) {
        emit(state.copyWith(status: Status.error, error: e.message));
      }
    });
  }
}
