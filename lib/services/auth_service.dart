import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient supabaseClient;

  static SupabaseClient? _testOverride;
  static void overrideInstanceForTesting(SupabaseClient client) {
    _testOverride = client;
  }

  AuthService({SupabaseClient? client})
    : supabaseClient = client ?? _testOverride ?? Supabase.instance.client;

  Future<User?> signUp(
    String email,
    String password,
    String confirmPassword,
  ) async {
    if (password != confirmPassword) {
      throw Exception('Passwords do not match');
    }
    final res = await supabaseClient.auth.signUp(
      email: email,
      password: password,
    );
    return res.user;
  }

  Future<User?> signIn(String email, String password) async {
    final res = await supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return res.user;
  }

  Future<void> resetPassword(String email) async {
    await supabaseClient.auth.resetPasswordForEmail(email);
  }

  Future<void> signOut() async {
    await supabaseClient.auth.signOut();
  }

  User? getUser() {
    return supabaseClient.auth.currentUser;
  }
}
