import 'package:flutter_test/flutter_test.dart';

/// Pumps until [finder] finds something or [timeout] elapses — for widgets
/// whose content depends on a real (non-fake-clock) asset read, such as
/// `cityDataProvider`, so a single fixed-duration pump can't reliably win
/// the race.
///
/// The wait itself runs via [WidgetTester.runAsync]: `pump(duration)` alone
/// only advances the test's fake clock and flushes microtasks, which isn't
/// enough for a real asset read of any real size to progress — real file
/// IO needs an actual turn of the real event loop, which only `runAsync`
/// yields to.
Future<void> pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 10),
}) async {
  final end = DateTime.now().add(timeout);
  while (finder.evaluate().isEmpty && DateTime.now().isBefore(end)) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 100)),
    );
    await tester.pump();
  }
}
