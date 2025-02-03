import 'package:task_management/core/data/db/database_provider.dart';
import 'package:task_management/core/data/models/task.dart';
import 'package:task_management/core/utils/constants.dart';

abstract class LocalDataSource {
  Future<int> addTask(Task task);

  Future<List<Task>> getTasks();

  Future<int> updateTask(Task task);

  Future<int> deleteTask(int id);

  Future<List<Task>> searchTasks(String query);
}

class LocalDataSourceImpl implements LocalDataSource {
  final DatabaseProvider provider;

  LocalDataSourceImpl({required this.provider});

  @override
  Future<int> addTask(Task task) async {
    try {
      final db = await provider.database;
      return await db.insert(tableTask, task.toMap());
    } catch (e) {
      throw FormatException(e.toString());
    }
  }

  @override
  Future<List<Task>> getTasks() async {
    try {
      final db = await provider.database;
      final tasks = await db.query(tableTask);
      return tasks.map((task) => Task.fromMap(task)).toList();
    } catch (e) {
      throw FormatException(e.toString());
    }
  }

  @override
  Future<int> updateTask(Task task) async {
    try {
      final db = await provider.database;
      return await db.update(
        tableTask,
        task.toMap(),
        where: 'id = ?',
        whereArgs: [task.id],
      );
    } catch (e) {
      throw FormatException(e.toString());
    }
  }

  @override
  Future<int> deleteTask(int id) async {
    try {
      final db = await provider.database;
      return await db.delete(
        tableTask,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw FormatException(e.toString());
    }
  }

  @override
  Future<List<Task>> searchTasks(String query) async {
    try {
      final db = await provider.database;
      final tasks = await db.query(
        tableTask,
        where: 'title LIKE ?',
        whereArgs: ['%$query%'],
      );
      return tasks.map((task) => Task.fromMap(task)).toList();
    } catch (e) {
      throw FormatException(e.toString());
    }
  }
}
