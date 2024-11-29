import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/task_provider.dart';
import '../../models/task.dart';

class TaskList extends StatelessWidget {
  final int userId;

  const TaskList({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(labelText: 'Nueva tarea'),
            onSubmitted: (title) {
              if (title.isNotEmpty) {
                taskProvider.addTask(userId, title);
              }
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: taskProvider.tasks.length,
            itemBuilder: (context, index) {
              final task = taskProvider.tasks[index];
              return ListTile(
                title: Text(task.title),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(task.completed
                          ? Icons.check_box
                          : Icons.check_box_outline_blank),
                      onPressed: () {
                        taskProvider.updateTask(Task(
                            id: task.id,
                            userId: task.userId,
                            title: task.title,
                            completed: !task.completed));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        taskProvider.deleteTask(task.id!, task.userId);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
