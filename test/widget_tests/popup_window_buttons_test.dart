import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/widgets/popup_window.dart';
import '../utils/benchmark_helper.dart';
import 'package:flutter/material.dart';

import 'utils/pump_widget.dart';

void main() {
  testWidgets('PopupWindow confirm triggers callback', (tester) async {
    var confirmed = false;
    await pumpWithMaterial(
      tester,
      Builder(
        builder:
            (context) => PopupWindow(
              title: 'Delete',
              message: 'Sure?',
              onPressed: () => confirmed = true,
            ),
      ),
      settle: true,
    );

    await tester.pumpAndSettle();

    await runPerf(() async {
      await tester.tap(find.byKey(const ValueKey('popupConfirmBtn')));
      await tester.pumpAndSettle();
    }, name: 'widget_popup_confirm');

    expect(confirmed, isTrue);
  });
}
