import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/services/auth_service.dart';

import '../unit_tests/utils/mocks.mocks.dart';

Future<void> ensureSupabaseInitialized() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  try {
    Supabase.instance.client;
    return;
  } catch (_) {}

  await Supabase.initialize(
    url: 'https://dummy.supabase.co',
    anonKey: 'public-anon-key',
  );

  final mockClient = MockSupabaseClient();
  AuthService.overrideInstanceForTesting(mockClient);
}
