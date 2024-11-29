import '../models/user.dart';
import '../services/database_service.dart';

class UserRepository {
  final DatabaseService _dbService = DatabaseService();

  Future<int> addUser(User user) async {
    final db = await _dbService.database;
    return await db.insert('users', user.toMap());
  }

  Future<List<User>> getUsers() async {
    final db = await _dbService.database;
    final result = await db.query('users');
    return result.map((map) => User.fromMap(map)).toList();
  }

  Future<int> updateUser(User user) async {
    final db = await _dbService.database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await _dbService.database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<User>> searchUsersByName(String query) async {
    final db = await _dbService.database;
    final result = await db.query(
      'users',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
    );
    return result.map((map) => User.fromMap(map)).toList();
  }

  Future<List<User>> filterUsersByAgeRange(int minAge, int maxAge) async {
    final db = await _dbService.database;
    final result = await db.query(
      'users',
      where: 'age BETWEEN ? AND ?',
      whereArgs: [minAge, maxAge],
    );
    return result.map((map) => User.fromMap(map)).toList();
  }
}
