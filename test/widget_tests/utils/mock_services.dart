import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/repository.dart';
import 'package:todo_app/services/todo_service.dart';

class MockRepository implements Repository {
  List<Todo> _list = [];

  @override
  Future<Todo> addTodo(Todo todo) async {
    _list.add(todo);
    return todo;
  }

  @override
  Future<void> deleteTodo(int id) async {
    _list.removeWhere((e) => e.id == id);
  }

  @override
  Future<Todo> editTodo(Todo todo) async {
    final idx = _list.indexWhere((e) => e.id == todo.id);
    _list[idx] = todo;
    return todo;
  }

  @override
  Future<List<Todo>> getTodos() async => _list;

  @override
  String getUserId() => "test-user";
}

class MockTodoService extends TodoService {
  MockTodoService() : super.withRepository(MockRepository());
}
