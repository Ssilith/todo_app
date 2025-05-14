// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/foundation.dart' show kIsWeb;

const int _defaultRepeat = int.fromEnvironment(
  'BENCHMARK_REPEAT',
  defaultValue: 10,
);

final _reports = <Map<String, dynamic>>[];

Future<void> runPerf(
  Future<void> Function() action, {
  String name = 'unnamed',
  int repeat = _defaultRepeat,
}) async {
  final timings = <int>[];
  int failures = 0;

  for (var i = 0; i < repeat; i++) {
    final sw = Stopwatch()..start();
    var failed = false;
    try {
      await action();
    } catch (e, st) {
      failures++;
      print(e);
      failed = true;
    } finally {
      sw.stop();
      if (!failed) timings.add(sw.elapsedMicroseconds);
    }
  }

  if (timings.isEmpty) timings.add(0);
  timings.sort();

  double pct(List<int> d, double p) =>
      d[(p * (d.length - 1)).round()].toDouble();

  final avg = timings.reduce((a, b) => a + b) / timings.length;
  final p50 = pct(timings, .50);
  final p95 = pct(timings, .95);
  final min = timings.first.toDouble();
  final max = timings.last.toDouble();
  final stdev = math.sqrt(
    timings.fold<double>(0, (s, v) => s + math.pow(v - avg, 2)) /
        timings.length,
  );
  final cov = avg != 0.0 && !avg.isNaN ? (stdev / avg) : 0.0;

  _reports.add({
    'test': name,
    'repeat': repeat,
    'avg_us': avg,
    'p50_us': p50,
    'p95_us': p95,
    'min_us': min,
    'max_us': max,
    'stdev_us': stdev,
    'cov': cov,
    'failures': failures,
    'flaky': failures / repeat > 0.02,
    'platform': kIsWeb ? 'web' : 'mobile',
  });
}

void dumpPerfReports() {
  print('PERF_REPORT_START');
  print(jsonEncode(_reports));
  print('PERF_REPORT_END');
}
