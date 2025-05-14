import 'package:mockito/annotations.dart';
import 'package:todo_app/services/repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@GenerateNiceMocks([
  MockSpec<Repository>(),
  MockSpec<SupabaseClient>(),
  MockSpec<GoTrueClient>(),
  MockSpec<AuthResponse>(),
  MockSpec<User>(),
])
void main() {}
