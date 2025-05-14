import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/blank_scaffold.dart';
import 'package:flutter/material.dart';
import '../utils/benchmark_helper.dart';
import 'utils/pump_widget.dart';

void main() {
  testWidgets('BlankScaffold renders its child stack', (tester) async {
    await runPerf(() async {
      await pumpWithMaterial(
        tester,
        BlankScaffold(children: const [Center(child: Text('Hi'))]),
      );

      expect(find.text('Hi'), findsOneWidget);
      expect(find.byType(BlankScaffold), findsOneWidget);
    }, name: 'widget_blank_scaffold_smoke');
  });
}
