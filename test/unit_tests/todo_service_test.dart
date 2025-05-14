import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/todo_service.dart';

import './utils/mocks.mocks.dart';
import '../utils/benchmark_helper.dart';

void main() {
  late MockRepository mockRepository;
  late TodoService todoService;

  setUp(() {
    mockRepository = MockRepository();
    todoService = TodoService.withRepository(mockRepository);
  });

  group('TodoService', () {
    test('getAllTodos returns a list of Todo', () async {
      final todos = [
        Todo(id: 1, name: 'Wash dishes', isComplete: false),
        Todo(id: 2, name: 'Walk the dog', isComplete: true),
      ];

      when(mockRepository.getTodos()).thenAnswer((_) async => todos);

      await runPerf(() async {
        await todoService.getAllTodos();
      }, name: 'todo_getAllTodos');

      final result = await todoService.getAllTodos();

      expect(result, todos);
      verify(mockRepository.getTodos()).called(greaterThanOrEqualTo(1));
    });

    test('addTodo returns the newly added Todo', () async {
      final newTodo = Todo(id: 3, name: 'Read a book', isComplete: false);

      when(mockRepository.addTodo(newTodo)).thenAnswer((_) async => newTodo);

      await runPerf(() async {
        await todoService.addTodo(newTodo);
      }, name: 'todo_addTodo');

      final result = await todoService.addTodo(newTodo);

      expect(result, newTodo);
      verify(mockRepository.addTodo(newTodo)).called(greaterThanOrEqualTo(1));
    });

    test('editTodo returns the edited Todo', () async {
      final editedTodo = Todo(
        id: 1,
        name: 'Wash ALL the dishes',
        isComplete: true,
      );

      when(
        mockRepository.editTodo(editedTodo),
      ).thenAnswer((_) async => editedTodo);

      await runPerf(() async {
        await todoService.editTodo(editedTodo);
      }, name: 'todo_editTodo');

      final result = await todoService.editTodo(editedTodo);

      expect(result, editedTodo);
      verify(
        mockRepository.editTodo(editedTodo),
      ).called(greaterThanOrEqualTo(1));
    });

    test('deleteTodo completes successfully', () async {
      when(mockRepository.deleteTodo(1)).thenAnswer((_) async => null);

      await runPerf(() async {
        await todoService.deleteTodo(1);
      }, name: 'todo_deleteTodo');

      verify(mockRepository.deleteTodo(1)).called(greaterThanOrEqualTo(1));
    });
  });
}
