import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_transport/core/theme/app_theme.dart';
import 'package:open_transport/features/onboarding/providers/onboarding_providers.dart';
import 'package:open_transport/features/onboarding/widgets/onboarding_stepper.dart';
import 'package:open_transport/l10n/generated/app_localizations.dart';

Widget _harness(ProviderContainer container) {
  return UncontrolledProviderScope(
    container: container,
    child: MaterialApp(
      theme: AppTheme.light(const Locale('en')),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Scaffold(body: OnboardingStepper(stepCount: 3)),
    ),
  );
}

/// The two connecting-line segments' current animated widths, in tree
/// order (segment 0 between circles 0–1, segment 1 between circles 1–2) —
/// found by height, since each circle is also an [AnimatedContainer] but a
/// fixed 44x44, distinct from a segment's 6px-tall bar.
List<double> _segmentWidths(WidgetTester tester) {
  return tester
      .widgetList<AnimatedContainer>(find.byType(AnimatedContainer))
      .where((container) => container.constraints?.maxHeight == 6)
      .map((container) => container.constraints!.maxWidth)
      .toList();
}

void main() {
  testWidgets(
    "each connecting-line segment fills from live field-validity state via "
    "Riverpod, not just the step index — the current step's segment fills "
    'field-by-field, not in one jump',
    (tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(onboardingProvider.notifier);

      await tester.pumpWidget(_harness(container));
      await tester.pump(const Duration(milliseconds: 400));

      // Still on step 0 (country/language), nothing filled: both segments
      // are empty.
      var widths = _segmentWidths(tester);
      expect(widths[0], 0);
      expect(widths[1], 0);

      // Jump to the profile step without filling step 0 — its segment
      // reads as fully passed regardless of step 0's own fields, and the
      // profile step's own segment starts empty.
      notifier.selectCountry('iran');
      notifier.next();
      await tester.pump(const Duration(milliseconds: 400));
      widths = _segmentWidths(tester);
      expect(widths[0], greaterThan(0));
      final fullSegmentWidth = widths[0];
      expect(widths[1], 0);

      // Filling the profile step's three fields one at a time fills its
      // segment in place, proportionally to how many are valid so far.
      notifier.updateProfile(username: 'arastoo1');
      await tester.pump(const Duration(milliseconds: 400));
      expect(_segmentWidths(tester)[1], closeTo(fullSegmentWidth / 3, 1));

      notifier.updateProfile(firstName: 'Arastoo');
      await tester.pump(const Duration(milliseconds: 400));
      expect(_segmentWidths(tester)[1], closeTo(fullSegmentWidth * 2 / 3, 1));

      notifier.updateProfile(lastName: 'Yousefi');
      await tester.pump(const Duration(milliseconds: 400));
      expect(_segmentWidths(tester)[1], closeTo(fullSegmentWidth, 1));
    },
  );
}
