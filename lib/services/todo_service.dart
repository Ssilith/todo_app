import '../models/todo.dart';
import 'repository.dart';
import 'repository_impl.dart';

class TodoService {
  final Repository _repository;

  TodoService() : _repository = RepositoryImpl();
  TodoService.withRepository(this._repository);

  Future<List<Todo>> getAllTodos() async => await _repository.getTodos();
  Future<Todo> addTodo(Todo todo) async => await _repository.addTodo(todo);
  Future<Todo> editTodo(Todo todo) async => await _repository.editTodo(todo);
  Future<void> deleteTodo(int id) async => await _repository.deleteTodo(id);
}
