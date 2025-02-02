import 'package:sqflite/sqflite.dart';
import 'package:task_management/core/utils/constants.dart';

class DatabaseProvider {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/task.db';
    return openDatabase(
      databasePath,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $tableTask (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL CHECK(length(title) <= 50),
            description TEXT,
            due_date TEXT NOT NULL,
            status INTEGER NOT NULL CHECK(status IN (0, 1, 2))
          )
        ''');
      },
      version: 1,
    );
  }
}
