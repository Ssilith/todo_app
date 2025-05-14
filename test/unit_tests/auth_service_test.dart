import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/services/auth_service.dart';

import './utils/mocks.mocks.dart';
import '../utils/benchmark_helper.dart';

void main() {
  late MockSupabaseClient mockSupabaseClient;
  late MockGoTrueClient mockAuth;
  late AuthService authService;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    mockAuth = MockGoTrueClient();

    when(mockSupabaseClient.auth).thenReturn(mockAuth);
    AuthService.overrideInstanceForTesting(mockSupabaseClient);

    authService = AuthService();
  });

  group('AuthService', () {
    test('signUp delegates to Supabase auth.signUp', () async {
      final fakeResponse = MockAuthResponse();
      final fakeUser = MockUser();
      when(fakeResponse.user).thenReturn(fakeUser);

      when(
        mockAuth.signUp(email: 'a@b.c', password: '123'),
      ).thenAnswer((_) async => fakeResponse);

      await runPerf(() async {
        await authService.signUp('a@b.c', '123', '123');
      }, name: 'auth_signUp');

      final result = await authService.signUp('a@b.c', '123', '123');

      expect(result, fakeUser);
      verify(
        mockAuth.signUp(email: 'a@b.c', password: '123'),
      ).called(greaterThanOrEqualTo(1));
    });

    test('signIn delegates to Supabase auth.signInWithPassword', () async {
      final fakeResponse = MockAuthResponse();
      final fakeUser = MockUser();
      when(fakeResponse.user).thenReturn(fakeUser);

      when(
        mockAuth.signInWithPassword(email: 'a@b.c', password: '123'),
      ).thenAnswer((_) async => fakeResponse);

      await runPerf(() async {
        await authService.signIn('a@b.c', '123');
      }, name: 'auth_signIn');

      final result = await authService.signIn('a@b.c', '123');

      expect(result, fakeUser);
      verify(
        mockAuth.signInWithPassword(email: 'a@b.c', password: '123'),
      ).called(greaterThanOrEqualTo(1));
    });

    test('resetPassword calls Supabase auth.resetPasswordForEmail', () async {
      when(
        mockAuth.resetPasswordForEmail('a@b.c'),
      ).thenAnswer((_) async => null);

      await runPerf(() async {
        await authService.resetPassword('a@b.c');
      }, name: 'auth_resetPassword');

      verify(
        mockAuth.resetPasswordForEmail('a@b.c'),
      ).called(greaterThanOrEqualTo(1));
    });
  });
}
