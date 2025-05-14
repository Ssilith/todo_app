import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/auth/login_page_template.dart';
import 'package:todo_app/services/auth_service.dart';
import '../unit_tests/utils/mocks.mocks.dart';
import '../utils/benchmark_helper.dart';
import 'utils/common_actions.dart';

void main() {
  setUpAll(() {
    final mock = MockSupabaseClient();
    AuthService.overrideInstanceForTesting(mock);
  });

  testWidgets('login + logout', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPageTemplate()));
    await tester.pump();

    await runPerf(() async {
      await login(tester);
      await logout(tester);
    }, name: 'integ_auth_login_logout');
  });
}
