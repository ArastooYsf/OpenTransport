import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_transport/features/onboarding/providers/onboarding_providers.dart';
import 'package:open_transport/features/onboarding/widgets/onboarding_stepper.dart';

Widget _harness(double progress) {
  return MaterialApp(
    home: Scaffold(
      body: OnboardingStepper(
        stepIndex: 1,
        stepCount: 3,
        progress: progress,
        circleStateAt: (index) => StepCircleState.upcoming,
        stepLabel: 'Step 2 of 3',
      ),
    ),
  );
}

double _lineWidthFactor(WidgetTester tester) {
  return tester
      .widget<FractionallySizedBox>(find.byType(FractionallySizedBox))
      .widthFactor!;
}

void main() {
  testWidgets(
    "the connecting line's fill tracks a fractional progress value — i.e. "
    "actual field completion within a step, not a full per-step jump",
    (tester) async {
      await tester.pumpWidget(_harness(0));
      await tester.pump(const Duration(milliseconds: 400));
      expect(_lineWidthFactor(tester), 0);

      // A value that lands strictly between two per-step boundaries (1/3
      // and 2/3) — the shape `overallStepperProgress` produces when the
      // current step is partially, not fully, filled in.
      const partialProgress = 1 / 3 + (1 / 3) / 3;
      await tester.pumpWidget(_harness(partialProgress));
      await tester.pump(const Duration(milliseconds: 400));
      expect(_lineWidthFactor(tester), closeTo(partialProgress, 0.01));

      await tester.pumpWidget(_harness(2 / 3));
      await tester.pump(const Duration(milliseconds: 400));
      expect(_lineWidthFactor(tester), closeTo(2 / 3, 0.01));
    },
  );
}
