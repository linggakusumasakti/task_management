import '../../core/data/models/task.dart';
import '../repositories/task_repository.dart';

class AddTask {
  final TaskRepository repository;

  AddTask({required this.repository});

  Future<int> execute(Task task) => repository.addTask(task);
}
