import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/todo.dart';
import 'repository.dart';

class RepositoryImpl implements Repository {
  final _client = Supabase.instance.client;

  @override
  String getUserId() {
    final user = _client.auth.currentUser;
    return user?.id ?? (throw Exception('No authenticated user'));
  }

  @override
  Future<Todo> addTodo(Todo todo) async {
    final response =
        await _client
            .from('todos')
            .insert(todo.toMap(getUserId()))
            .select()
            .single();
    return Todo.fromMap(response);
  }

  @override
  Future<Todo> editTodo(Todo todo) async {
    final response =
        await _client
            .from('todos')
            .update(todo.toMap(getUserId()))
            .eq('id', todo.id)
            .select()
            .single();
    return Todo.fromMap(response);
  }

  @override
  Future<List<Todo>> getTodos() async {
    final results = await _client
        .from('todos')
        .select()
        .eq('user_id', getUserId())
        .order('id', ascending: false);
    return (results as List)
        .map((e) => Todo.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> deleteTodo(int id) async {
    await _client.from('todos').delete().eq('id', id);
  }
}
