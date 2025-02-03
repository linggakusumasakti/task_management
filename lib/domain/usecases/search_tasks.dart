import 'package:task_management/domain/repositories/task_repository.dart';

import '../../core/data/models/task.dart';

class SearchTasks {
  final TaskRepository repository;

  SearchTasks({required this.repository});

  Future<List<Task>> execute(String query) => repository.searchTasks(query);
}
