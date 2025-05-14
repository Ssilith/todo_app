import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> login(
  WidgetTester tester, {
  String email = 'a@a.com',
  String password = '123456',
}) async {
  await tester.pumpAndSettle(const Duration(seconds: 2));

  await tester.enterText(find.byKey(const Key('emailField')), email);
  await tester.pump(const Duration(milliseconds: 100));
  await tester.enterText(find.byKey(const Key('passwordField')), password);
  await tester.pump(const Duration(milliseconds: 100));

  final loginBtn = find.text('LOGIN');
  expect(loginBtn, findsOneWidget);
  await tester.tap(loginBtn);
  await tester.pumpAndSettle();
}

Future<void> logout(WidgetTester tester) async {
  await tester.pumpAndSettle();
  final logoutBtn = find.byIcon(Icons.logout_outlined);
  expect(logoutBtn, findsOneWidget);
  await tester.tap(logoutBtn);
  await tester.pumpAndSettle();
}

Future<void> addTodo(WidgetTester tester, {String name = 'Buy milk'}) async {
  final fab = find.byIcon(Icons.add);
  expect(fab, findsOneWidget);
  await tester.tap(fab);
  await tester.pumpAndSettle();

  final todoField = find.widgetWithText(TextField, 'New todo');
  expect(todoField, findsOneWidget);
  await tester.enterText(todoField, name);
  await tester.pump(const Duration(milliseconds: 150));

  await tester.tap(find.byIcon(Icons.check).last);
  await tester.pumpAndSettle();
}

Future<void> editTodo(
  WidgetTester tester, {
  String newName = 'Buy milk & bread',
}) async {
  final firstTile = find.byType(GestureDetector).first;
  await tester.tap(firstTile);
  await tester.pump(const Duration(milliseconds: 50));
  await tester.tap(firstTile);
  await tester.pumpAndSettle();

  final editField = find.widgetWithText(TextField, 'Edit todo');
  expect(editField, findsOneWidget);
  await tester.enterText(editField, newName);
  await tester.pump(const Duration(milliseconds: 150));

  await tester.tap(find.byIcon(Icons.check).last);
  await tester.pumpAndSettle();
}

Future<void> toggleTodo(WidgetTester tester) async {
  final cb = find.byType(Checkbox).first;
  expect(cb, findsOneWidget);
  await tester.tap(cb);
  await tester.pumpAndSettle();
}

Future<void> deleteTodo(WidgetTester tester) async {
  final deleteBtn = find.byIcon(Icons.delete).first;
  expect(deleteBtn, findsOneWidget);
  await tester.tap(deleteBtn);
  await tester.pumpAndSettle();
}

Future<void> resetPassword(
  WidgetTester tester, {
  String email = 'a@a.com',
}) async {
  final forgotBtn = find.text('Forgot your password?');
  expect(forgotBtn, findsOneWidget);
  await tester.tap(forgotBtn);
  await tester.pumpAndSettle();

  final emailField = find.widgetWithText(TextField, 'E-mail');
  expect(emailField, findsOneWidget);
  await tester.enterText(emailField, email);
  await tester.pump(const Duration(milliseconds: 150));

  await tester.tap(find.text('Confirm'));
  await tester.pumpAndSettle();
}
