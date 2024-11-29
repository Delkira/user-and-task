import 'package:flutter/material.dart';
import '../models/task.dart';
import '../repositories/task_repository.dart';

class TaskProvider extends ChangeNotifier {
  final TaskRepository _repository = TaskRepository();

  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> fetchTasksByUserId(int userId) async {
    _tasks = await _repository.getTasksByUserId(userId);
    notifyListeners();
  }

  Future<void> addTask(int userId, String title) async {
    final task = Task(userId: userId, title: title, completed: false);
    await _repository.addTask(task);
    await fetchTasksByUserId(userId);
  }

  Future<void> updateTask(Task task) async {
    await _repository.updateTask(task);
    await fetchTasksByUserId(task.userId);
  }

  Future<void> deleteTask(int id, int userId) async {
    await _repository.deleteTask(id);
    await fetchTasksByUserId(userId);
  }
}
