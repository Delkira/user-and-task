import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'widgets/user_list.dart';

class UserScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController minAgeController = TextEditingController();
  final TextEditingController maxAgeController = TextEditingController();

  UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de usuarios'),
      ),
      body: Column(
        children: [
          // Agregar nombre
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
          ),
          // Agregar edad
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Edad'),
            ),
          ),
          // Agregar email
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final name = _nameController.text;
              final age = int.tryParse(_ageController.text) ?? 0;
              final email = _emailController.text;
              userProvider.addUser(name, age, email);
              _nameController.clear();
              _ageController.clear();
              _emailController.clear();
            },
            child: const Text('Agregar usuario'),
          ),
          // Buscar por nombre
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(labelText: 'Buscar por nombre'),
              onChanged: (query) {
                userProvider.searchUsersByName(query);
              },
            ),
          ),
          // Filtro por edad
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: minAgeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Edad mínima'),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    controller: maxAgeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Edad máxima'),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    final minAge = int.tryParse(minAgeController.text) ?? 0;
                    final maxAge = int.tryParse(maxAgeController.text) ?? 100;
                    userProvider.filterUsersByAgeRange(minAge, maxAge);
                  },
                  child: const Text('Filtrar'),
                ),
              ],
            ),
          ),
          const Expanded(child: UserList()),
        ],
      ),
    );
  }
}
