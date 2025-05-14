import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/todo/todo_page.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/todo_service.dart';

import '../utils/benchmark_helper.dart';
import 'utils/common_actions.dart';

class MockTodoService implements TodoService {
  List<Todo> _todos = [];

  @override
  Future<List<Todo>> getAllTodos() async {
    if (_todos.isEmpty) {
      _todos = [Todo(id: 1, name: 'Test todo 1', isComplete: false)];
    }
    return Future.delayed(Duration(milliseconds: 100), () => _todos);
  }

  @override
  Future<Todo> addTodo(Todo todo) async {
    final newTodo = Todo(
      id: _todos.length + 1,
      name: todo.name,
      isComplete: todo.isComplete,
    );
    _todos.add(newTodo);
    return Future.delayed(Duration(milliseconds: 100), () => newTodo);
  }

  @override
  Future<Todo> editTodo(Todo todo) async {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index >= 0) {
      _todos[index] = todo;
    }
    return Future.delayed(Duration(milliseconds: 100), () => todo);
  }

  @override
  Future<void> deleteTodo(int id) async {
    _todos.removeWhere((t) => t.id == id);
    return Future.delayed(Duration(milliseconds: 100));
  }
}

void main() {
  testWidgets('todo - add, edit, toggle, delete', (tester) async {
    WidgetsFlutterBinding.ensureInitialized();

    final mockTodoService = MockTodoService();

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(primaryColor: Colors.blue),
        home: TodoPage(todoService: mockTodoService),
      ),
    );

    await tester.pump(Duration(seconds: 1));

    await runPerf(() async {
      await addTodo(tester, name: 'Test Todo Item');
      await toggleTodo(tester);
      await editTodo(tester, newName: 'Edited Todo Item');
      await deleteTodo(tester);
    }, name: 'integ_todo_crud');
  });
}
