import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return ListView.builder(
      itemCount: userProvider.users.length,
      itemBuilder: (context, index) {
        final user = userProvider.users[index];
        return ExpansionTile(
          title: Text(user.name),
          subtitle: Text('Edad: ${user.age}'),
          children: [
            // Mostrar las tareas asociadas a este usuario
            for (var task in user.tasks)
              ListTile(
                title: Text(task),
              ),
            // Botón para agregar tareas
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  _showAddTaskDialog(context, userProvider, user);
                },
                child: const Text('Agregar tarea'),
              ),
            ),
            // Botones de edición y eliminación de usuario
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      _showEditDialog(context, userProvider, user);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      userProvider.deleteUser(user.id!);
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, UserProvider userProvider, user) {
    final TextEditingController nameController =
        TextEditingController(text: user.name);
    final TextEditingController ageController =
        TextEditingController(text: user.age.toString());
    final TextEditingController emailController =
        TextEditingController(text: user.email);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar usuario'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Edad'),
            ),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text;
              final age = int.tryParse(ageController.text) ?? 0;
              final email = emailController.text;

              userProvider.updateUser(user.id!, name, age, email);
              Navigator.pop(context);
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _showAddTaskDialog(
      BuildContext context, UserProvider userProvider, user) {
    final TextEditingController taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Agregar tarea'),
        content: TextField(
          controller: taskController,
          decoration: const InputDecoration(labelText: 'Tarea'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final task = taskController.text;
              if (task.isNotEmpty) {
                userProvider.addTaskToUser(user, task);
                Navigator.pop(context);
              }
            },
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }
}
