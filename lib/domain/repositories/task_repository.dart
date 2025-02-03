import '../../core/data/models/task.dart';

abstract class TaskRepository {
  Future<int> addTask(Task task);
  Future<List<Task>> getTasks();
  Future<int> updateTask(Task task);
  Future<int> deleteTask(int id);
  Future<List<Task>> searchTasks(String query);
}
