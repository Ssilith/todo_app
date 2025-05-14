// integration_test/todo_crud_test.dart
import 'package:flutter_test/flutter_test.dart';

import '../utils/benchmark_helper.dart';
import 'utils/common_actions.dart';

void main() {
  testWidgets('todo - add, edit, toggle, delete', (tester) async {
    await runPerf(() async {
      await login(tester);
      await addTodo(tester);
      await editTodo(tester);
      await toggleTodo(tester);
      await deleteTodo(tester);
      await logout(tester);
    }, name: 'integ_todo_crud');
  });
}
