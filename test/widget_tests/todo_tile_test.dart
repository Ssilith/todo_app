import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/todo/todo_tile.dart';
import 'package:todo_app/models/todo.dart';
import 'package:flutter/material.dart';
import '../utils/benchmark_helper.dart';
import 'utils/pump_widget.dart';

void main() {
  testWidgets('TodoTile calls callbacks', (tester) async {
    int toggleCount = 0;
    int removeCount = 0;

    final todo = Todo(id: 1, name: 'Write tests', isComplete: false);

    await pumpWithMaterial(
      tester,
      TodoTile(
        todo: todo,
        toggleFinished: (v) {
          toggleCount++;
        },
        remove: () {
          removeCount++;
        },
        onDoubleTap: () {},
      ),
      settle: true,
    );

    await tester.pumpAndSettle();

    final checkboxFinder = find.byType(Checkbox);
    expect(checkboxFinder, findsOneWidget, reason: 'Could not find Checkbox');

    final deleteButtonFinder = find.byType(IconButton);
    expect(
      deleteButtonFinder,
      findsOneWidget,
      reason: 'Could not find IconButton',
    );

    final checkbox = tester.widget<Checkbox>(checkboxFinder);
    final iconButton = tester.widget<IconButton>(deleteButtonFinder);

    await runPerf(() async {
      checkbox.onChanged!(!checkbox.value!);
      await tester.pump();

      iconButton.onPressed!();
      await tester.pump();

      await tester.ensureVisible(checkboxFinder);
      await tester.tap(checkboxFinder);
      await tester.pumpAndSettle();

      await tester.ensureVisible(deleteButtonFinder);
      await tester.tap(deleteButtonFinder);
      await tester.pumpAndSettle();
    }, name: 'widget_todo_tile_actions');

    expect(toggleCount, greaterThan(0), reason: 'Toggle callback not called');
    expect(removeCount, greaterThan(0), reason: 'Remove callback not called');
  });
}
