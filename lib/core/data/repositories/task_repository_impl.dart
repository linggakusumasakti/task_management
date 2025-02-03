import 'package:task_management/core/data/datasources/local_data_source.dart';
import 'package:task_management/core/data/models/task.dart';

import '../../../domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final LocalDataSource localDataSource;

  TaskRepositoryImpl({required this.localDataSource});

  @override
  Future<int> addTask(Task task) async => await localDataSource.addTask(task);

  @override
  Future<List<Task>> getTasks() async => await localDataSource.getTasks();

  @override
  Future<int> updateTask(Task task) async =>
      await localDataSource.updateTask(task);

  @override
  Future<int> deleteTask(int id) async => await localDataSource.deleteTask(id);

  @override
  Future<List<Task>> searchTasks(String query) async =>
      await localDataSource.searchTasks(query);
}
