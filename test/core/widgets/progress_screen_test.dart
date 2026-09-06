import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_transport/core/widgets/progress_screen.dart';

void main() {
  group('rotatingMessageDurationMs', () {
    test('floors short messages at 1800ms', () {
      expect(rotatingMessageDurationMs('Hi'), 1800);
    });

    test('scales with message length past the floor', () {
      final longMessage = 'a' * 100; // 100 * 45 = 4500, above the floor
      expect(rotatingMessageDurationMs(longMessage), 4500);
    });
  });

  testWidgets('rotates to the next message after its computed duration', (
    tester,
  ) async {
    const messages = ['Short', 'A somewhat longer welcome message'];

    await tester.pumpWidget(
      const MaterialApp(home: ProgressScreen(messages: messages)),
    );

    expect(find.text(messages[0]), findsOneWidget);
    expect(find.text(messages[1]), findsNothing);

    // 'Short'.length == 5, so its duration is the 1800ms floor.
    await tester.pump(const Duration(milliseconds: 1800));
    // Let the cross-fade transition (350ms) finish. Pump a little past the
    // exact duration — AnimatedSwitcher's ticker needs strictly more than
    // its nominal duration to report "completed" in fake time.
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text(messages[0]), findsNothing);
    expect(find.text(messages[1]), findsOneWidget);

    // Let the second message's own timer elapse too, so nothing is left
    // pending when the test ends.
    await tester.pump(
      Duration(milliseconds: rotatingMessageDurationMs(messages[1])),
    );
    await tester.pump(const Duration(milliseconds: 400));
  });

  testWidgets('renders nothing extra when given an empty message list', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: ProgressScreen(messages: [])),
    );

    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    expect(find.byType(AnimatedSwitcher), findsNothing);
  });
}
