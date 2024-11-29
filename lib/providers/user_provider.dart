import 'package:flutter/material.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _repository = UserRepository();
  List<User> _users = [];
  List<User> _filteredUsers = [];

  List<User> get users => _filteredUsers.isEmpty ? _users : _filteredUsers;

  Future<void> fetchUsers() async {
    _users = await _repository.getUsers();
    _filteredUsers = [];
    notifyListeners();
  }

  Future<void> addUser(String name, int age, String email) async {
    final user = User(name: name, age: age, email: email);
    await _repository.addUser(user);
    fetchUsers();
  }

  Future<void> updateUser(int id, String name, int age, String email) async {
    await _repository
        .updateUser(User(id: id, name: name, age: age, email: email));
    await fetchUsers();
  }

  Future<void> deleteUser(int id) async {
    await _repository.deleteUser(id);
    await fetchUsers();
  }

  Future<void> searchUsersByName(String query) async {
    if (query.isEmpty) {
      _filteredUsers = [];
    } else {
      _filteredUsers = _users.where((user) {
        return user.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  Future<void> filterUsersByAgeRange(int minAge, int maxAge) async {
    _filteredUsers = _users.where((user) {
      return user.age >= minAge && user.age <= maxAge;
    }).toList();
    notifyListeners();
  }

  Future<void> addTaskToUser(User user, String task) async {
    user.tasks.add(task);
    await _repository.updateUser(user);
    notifyListeners();
  }
}
