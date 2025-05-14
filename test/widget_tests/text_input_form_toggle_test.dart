import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/widgets/text_input_form.dart';
import 'package:flutter/material.dart';
import '../utils/benchmark_helper.dart';
import 'utils/pump_widget.dart';

void main() {
  testWidgets('TextInputForm eye icon toggles visibility', (tester) async {
    final controller = TextEditingController();

    await pumpWithMaterial(
      tester,
      TextInputForm(
        width: 300,
        hint: 'Password',
        controller: controller,
        hideText: true,
      ),
      settle: true,
    );

    final offIconFinder = find.byIcon(Icons.visibility_off);
    expect(
      offIconFinder,
      findsOneWidget,
      reason: 'Should find visibility_off icon initially',
    );

    final toggleButtonFinder = find.byKey(const Key('visibilityToggle'));
    expect(
      toggleButtonFinder,
      findsOneWidget,
      reason: 'Should find the visibility toggle button',
    );

    await tester.ensureVisible(toggleButtonFinder);

    await tester.tap(toggleButtonFinder);
    await tester.pumpAndSettle();

    final onIconFinder = find.byIcon(Icons.visibility);
    expect(
      onIconFinder,
      findsOneWidget,
      reason: 'Should find visibility icon after tapping',
    );

    await runPerf(() async {
      await tester.tap(toggleButtonFinder);
      await tester.pumpAndSettle();

      await tester.tap(toggleButtonFinder);
      await tester.pumpAndSettle();
    }, name: 'widget_text_input_toggle');
  });
}
