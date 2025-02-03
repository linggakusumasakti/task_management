import 'package:task_management/domain/repositories/task_repository.dart';

class DeleteTask {
  final TaskRepository repository;

  DeleteTask({required this.repository});

  Future<int> execute(int id) => repository.deleteTask(id);
}
