import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/auth/login_page_template.dart';
import 'package:todo_app/todo/todo_page.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  Map configData = await getSupabaseConfig();
  await Supabase.initialize(
    url: configData['SUPABASE_URL']!,
    anonKey: configData['SUPABASE_ANON_KEY']!,
  );

  if (!kIsWeb) {
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }
  runApp(MyApp());
}

Future<Map<String, String>> getSupabaseConfig() async {
  String jsonStr = await rootBundle.loadString('assets/secrets.json');
  final data = json.decode(jsonStr) as Map<String, dynamic>;
  final url = data['SUPABASE_URL'] as String?;
  final key = data['SUPABASE_ANON_KEY'] as String?;
  return {'SUPABASE_URL': url!, 'SUPABASE_ANON_KEY': key!};
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF182a38),
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF182a38)),
      ),
      home: AuthStateWrapper(),
    );
  }
}

class AuthStateWrapper extends StatelessWidget {
  final SupabaseClient supabase = Supabase.instance.client;
  AuthStateWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final user = supabase.auth.currentUser;
        if (user != null) {
          return TodoPage();
        }
        return const LoginPageTemplate();
      },
    );
  }
}
