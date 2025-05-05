import '../models/todo.dart';

abstract class Repository {
  Future<Todo> addTodo(Todo todo);
  Future<Todo> editTodo(Todo todo);
  Future<List<Todo>> getTodos();
  Future<void> deleteTodo(int id);

  String getUserId();
}
