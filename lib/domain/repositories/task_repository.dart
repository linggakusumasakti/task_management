import '../../core/data/models/task.dart';

abstract class TaskRepository {
  Future<int> addTask(Task task);
  Future<List<Task>> getTasks();
}
