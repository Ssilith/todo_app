import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/services/auth_service.dart';

import '../unit_tests/utils/mocks.mocks.dart';

Future<void> ensureSupabaseInitialized() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  // await Supabase.initialize(
  //   url: 'https://dummy.supabase.co',
  //   anonKey: 'public-anon-key',
  // );

  final mockClient = MockSupabaseClient();
  AuthService.overrideInstanceForTesting(mockClient);
}
