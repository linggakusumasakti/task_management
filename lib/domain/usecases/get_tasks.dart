import 'package:task_management/core/data/models/task.dart';
import 'package:task_management/domain/repositories/task_repository.dart';

class GetTasks {
  final TaskRepository repository;

  GetTasks({required this.repository});

  Future<List<Task>> execute() => repository.getTasks();
}
