import 'package:flutter_test/flutter_test.dart';

import 'integration_tests/auth_flow_test.dart' as auth;
import 'integration_tests/todo_flow_test.dart' as todo;

import 'utils/benchmark_helper.dart';
import 'utils/supabase_test_setup.dart';

void main() {
  setUpAll(() async {
    await ensureSupabaseInitialized();
  });

  group('All Integration Tests', () {
    auth.main();
    todo.main();
  });

  tearDownAll(dumpPerfReports);
}
