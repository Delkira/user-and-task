class User {
  final int? id;
  final String name;
  final int age;
  final String email;
  List<String> tasks;

  User({
    this.id,
    required this.name,
    required this.age,
    required this.email,
    this.tasks = const [],
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      email: map['email'],
      tasks: List<String>.from(map['tasks'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'email': email,
      'tasks': tasks,
    };
  }
}
