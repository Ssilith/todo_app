import 'package:flutter_test/flutter_test.dart';
import '../utils/benchmark_helper.dart';
import 'utils/common_actions.dart';

void main() {
  testWidgets('login + logout smoke', (tester) async {
    await runPerf(() async {
      await login(tester);
      await logout(tester);
    }, name: 'integ_auth_login_logout');
  });
}
