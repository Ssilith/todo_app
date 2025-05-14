import '../models/todo.dart';
import 'repository.dart';
import 'repository_impl.dart';

class TodoService {
  final Repository _repository;

  static TodoService? _testOverride;

  factory TodoService() {
    return _testOverride ?? TodoService._internal();
  }

  TodoService._internal() : _repository = RepositoryImpl();

  TodoService.withRepository(this._repository);

  static void overrideInstanceForTesting(TodoService service) {
    _testOverride = service;
  }

  static void resetInstanceForTesting() {
    _testOverride = null;
  }

  Future<List<Todo>> getAllTodos() async => await _repository.getTodos();
  Future<Todo> addTodo(Todo todo) async => await _repository.addTodo(todo);
  Future<Todo> editTodo(Todo todo) async => await _repository.editTodo(todo);
  Future<void> deleteTodo(int id) async => await _repository.deleteTodo(id);
}
