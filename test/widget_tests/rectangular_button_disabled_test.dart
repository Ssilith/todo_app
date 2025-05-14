import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/widgets/rectangular_button.dart';
import '../utils/benchmark_helper.dart';
import 'utils/pump_widget.dart';

void main() {
  testWidgets('RectangularButton disabled when loading', (tester) async {
    var pressed = false;
    await pumpWithMaterial(
      tester,
      RectangularButton(
        title: 'Save',
        isLoading: true,
        onPressed: () => pressed = true,
      ),
    );

    await runPerf(() async {
      await tester.tap(find.byType(RectangularButton), warnIfMissed: false);
    }, name: 'widget_rect_btn_disabled');

    expect(pressed, isFalse);
  });
}
