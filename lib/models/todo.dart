class Todo {
  final int id;
  String name;
  bool isComplete;

  Todo({required this.id, required this.name, required this.isComplete});

  factory Todo.fromMap(Map<String, dynamic> map) => Todo(
    id: map['id'] as int,
    name: map['name'] as String,
    isComplete: map['is_complete'] as bool,
  );

  Map<String, dynamic> toMap(String userId) => {
    'name': name,
    'is_complete': isComplete,
    'user_id': userId,
  };
}
