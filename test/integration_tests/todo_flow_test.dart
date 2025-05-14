import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/todo/todo_page.dart';
import '../utils/benchmark_helper.dart';
import '../widget_tests/utils/mock_services.dart';
import 'utils/common_actions.dart';
import 'utils/mocks_auth_service.dart';

void main() {
  testWidgets('todo - add, edit, toggle, delete', (tester) async {
    WidgetsFlutterBinding.ensureInitialized();

    final mockTodoService = MockTodoService();
    final mockAuthService = MockAuthService();

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(primaryColor: Colors.blue),
        home: TodoPage(
          todoService: mockTodoService,
          authService: mockAuthService,
        ),
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
