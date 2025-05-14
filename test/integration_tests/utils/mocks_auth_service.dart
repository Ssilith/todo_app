import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/services/auth_service.dart';

class MockAuthService implements AuthService {
  @override
  Future<User?> signIn(String email, String password) async => null;

  @override
  Future<User?> signUp(
    String email,
    String password,
    String confirmPassword,
  ) async => null;

  @override
  Future<void> resetPassword(String email) async {}

  @override
  Future<void> signOut() async {}

  @override
  User? getUser() => null;

  @override
  SupabaseClient get supabaseClient => SupabaseClient("", "");
}
