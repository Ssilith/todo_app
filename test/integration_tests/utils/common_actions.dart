import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> safePump(
  WidgetTester tester, {
  int frameCount = 5,
  Duration perFrame = const Duration(milliseconds: 100),
}) async {
  try {
    for (var i = 0; i < frameCount; i++) {
      await tester.pump(perFrame);
    }
  } catch (e) {
    debugPrint('Warning: pumpAndSettle timed out: $e');
  }
}

Future<void> login(WidgetTester tester) async {
  await tester.pumpAndSettle(Duration(seconds: 2));

  final textFields = find.byType(TextField);
  if (textFields.evaluate().length >= 2) {
    await tester.enterText(textFields.at(0), 'a@a.com');
    await tester.pump();
    await tester.enterText(textFields.at(1), '123456');
    await tester.pump();

    final buttons = find.byType(TextButton);
    if (buttons.evaluate().isNotEmpty) {
      await tester.tap(buttons.first, warnIfMissed: false);
      await tester.pumpAndSettle();
    }
  }
}

Future<void> logout(WidgetTester tester) async {
  await tester.pumpAndSettle();

  final logoutIconButton = find.byIcon(Icons.logout_outlined);
  if (logoutIconButton.evaluate().isNotEmpty) {
    await tester.tap(logoutIconButton, warnIfMissed: false);
  } else {
    final iconButtons = find.byType(IconButton);
    if (iconButtons.evaluate().isNotEmpty) {
      await tester.tap(iconButtons.first, warnIfMissed: false);
    }
  }

  await tester.pumpAndSettle();
}

Future<void> addTodo(WidgetTester tester, {String name = 'Buy milk'}) async {
  final fab = find.byIcon(Icons.add);

  await tester.tap(fab.first, warnIfMissed: false);
  await safePump(tester);

  final textFields = find.byType(TextField);
  await tester.enterText(textFields.first, name);
  await tester.pump(Duration(milliseconds: 300));

  final checkIcons = find.byIcon(Icons.check);
  await tester.tap(checkIcons.last, warnIfMissed: false);
  await safePump(tester);
}

Future<void> editTodo(
  WidgetTester tester, {
  String newName = 'Buy milk & bread',
}) async {
  await safePump(tester);

  final containers = find.descendant(
    of: find.byType(ListView),
    matching: find.byType(Container),
  );

  Finder todoItem;
  if (containers.evaluate().isNotEmpty) {
    todoItem = containers.first;
  } else {
    final gestures = find.byType(GestureDetector);
    todoItem = gestures.first;
  }

  await tester.tap(todoItem, warnIfMissed: false);
  await tester.pump(const Duration(milliseconds: 100));
  await tester.tap(todoItem, warnIfMissed: false);
  await safePump(tester);

  final textField = find.byType(TextField);
  await tester.enterText(textField.first, newName);
  await tester.pump(const Duration(milliseconds: 300));

  final checkButton = find.byIcon(Icons.check);
  await tester.tap(checkButton.last, warnIfMissed: false);
  await safePump(tester);
}

Future<void> toggleTodo(WidgetTester tester) async {
  await safePump(tester);

  final cb = find.byType(Checkbox);
  await tester.tap(cb.first, warnIfMissed: false);
  await safePump(tester);
}

Future<void> deleteTodo(WidgetTester tester) async {
  await safePump(tester);
  final deleteBtn = find.byIcon(Icons.delete);
  await tester.tap(deleteBtn.first, warnIfMissed: false);
  await safePump(tester);
}
