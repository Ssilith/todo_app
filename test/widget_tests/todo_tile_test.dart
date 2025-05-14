import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/todo/todo_tile.dart';
import 'package:todo_app/models/todo.dart';
import 'package:flutter/material.dart';
import 'utils/pump_widget.dart';

void main() {
  testWidgets('TodoTile calls callbacks', (tester) async {
    bool toggled = false;
    bool removed = false;

    final todo = Todo(id: 1, name: 'Write tests', isComplete: false);

    await pumpWithMaterial(
      tester,
      TodoTile(
        todo: todo,
        toggleFinished: (v) {
          toggled = true;
        },
        remove: () {
          removed = true;
        },
        onDoubleTap: () {},
      ),
      settle: true,
    );

    await tester.pumpAndSettle();

    final checkboxFinder = find.byType(Checkbox);
    expect(checkboxFinder, findsOneWidget, reason: 'Could not find Checkbox');

    await tester.ensureVisible(checkboxFinder);

    await tester.longPress(checkboxFinder, warnIfMissed: false);
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    // If it's still not toggled, try a different approach
    // if (!toggled) {
    //   print('Longpress didn\'t work, trying direct callback invocation');
    //   final checkbox = tester.widget<Checkbox>(checkboxFinder);
    //   checkbox.onChanged!(!checkbox.value!);
    //   await tester.pump();
    // }

    // Check if toggle callback was called
    expect(toggled, isTrue, reason: 'Toggle callback not called');

    // Reset the flag for the second test
    toggled = false;

    // Find the IconButton using byType
    final deleteButtonFinder = find.byType(IconButton);
    expect(
      deleteButtonFinder,
      findsOneWidget,
      reason: 'Could not find IconButton',
    );
    // print('Found IconButton with direct type finder');

    // Use ensureVisible to make sure the widget is visible
    await tester.ensureVisible(deleteButtonFinder);

    // Try a longer press duration for the delete button
    await tester.longPress(deleteButtonFinder, warnIfMissed: false);
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    // // If it's still not removed, try a different approach
    // if (!removed) {
    //   print('Longpress didn\'t work, trying direct callback invocation');
    //   final iconButton = tester.widget<IconButton>(deleteButtonFinder);
    //   iconButton.onPressed!();
    //   await tester.pump();
    // }

    // Check if remove callback was called
    expect(removed, isTrue, reason: 'Remove callback not called');
  });
}
