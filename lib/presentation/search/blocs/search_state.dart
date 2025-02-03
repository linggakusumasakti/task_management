part of 'search_bloc.dart';

class SearchState extends Equatable {
  final Status status;
  final List<Task>? tasks;
  final String? error;

  const SearchState({required this.status, this.tasks, this.error});

  static SearchState initial() => const SearchState(status: Status.initial);

  SearchState copyWith({Status? status, List<Task>? tasks, String? error}) =>
      SearchState(
          status: status ?? this.status,
          tasks: tasks ?? this.tasks,
          error: error ?? this.error);

  @override
  List<Object?> get props => [status, tasks, error];
}
