part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

final class SearchTasksEvent extends SearchEvent {
  final String query;

  const SearchTasksEvent({required this.query});

  @override
  List<Object?> get props => [query];
}
