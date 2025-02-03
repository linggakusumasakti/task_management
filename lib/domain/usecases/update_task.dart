import 'package:task_management/domain/repositories/task_repository.dart';

import '../../core/data/models/task.dart';

class UpdateTask {
  final TaskRepository repository;

  UpdateTask({required this.repository});

  Future<int> execute(Task task) => repository.updateTask(task);
}
