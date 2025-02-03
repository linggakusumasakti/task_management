import 'package:task_management/domain/repositories/task_repository.dart';

import '../../core/data/models/task.dart';

class FilterTasks {
  final TaskRepository repository;

  FilterTasks({required this.repository});

  Future<List<Task>> execute(TaskStatus status) => repository.filterTasks(status);
}
