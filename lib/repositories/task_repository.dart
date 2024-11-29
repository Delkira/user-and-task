import '../models/task.dart';
import '../services/database_service.dart';

class TaskRepository {
  final DatabaseService _dbService = DatabaseService();

  Future<int> addTask(Task task) async {
    final db = await _dbService.database;
    return await db.insert('tasks', task.toMap());
  }

  Future<List<Task>> getTasksByUserId(int userId) async {
    final db = await _dbService.database;
    final result = await db.query(
      'tasks',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return result.map((map) => Task.fromMap(map)).toList();
  }

  Future<int> updateTask(Task task) async {
    final db = await _dbService.database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await _dbService.database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
