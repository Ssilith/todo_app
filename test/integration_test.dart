import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/services/todo_service.dart';

import 'integration_tests/auth_flow_test.dart' as auth;
import 'integration_tests/todo_flow_test.dart' as todo;

import '../test/utils/benchmark_helper.dart';
import 'unit_tests/utils/mocks.mocks.dart';

void main() {
  setUpAll(() async {
    TodoService.overrideInstanceForTesting(
      TodoService.withRepository(MockRepository()),
    );
  });

  group('All Integration Tests', () {
    auth.main();
    todo.main();
  });

  tearDownAll(dumpPerfReports);
}
