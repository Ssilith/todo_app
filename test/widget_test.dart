import 'package:flutter_test/flutter_test.dart';

import 'widget_tests/blank_scaffold_smoke_test.dart' as blank_scaffold;
import 'widget_tests/text_input_form_toggle_test.dart' as text_toggle;
import 'widget_tests/rectangular_button_disabled_test.dart' as rect_btn;
import 'widget_tests/popup_window_buttons_test.dart' as popup_confirm;
import 'widget_tests/todo_tile_test.dart' as todo_tile;
import 'utils/benchmark_helper.dart';

void main() {
  group('All Widget Tests', () {
    blank_scaffold.main();
    text_toggle.main();
    rect_btn.main();
    popup_confirm.main();
    todo_tile.main();
  });

  tearDownAll(dumpPerfReports);
}
