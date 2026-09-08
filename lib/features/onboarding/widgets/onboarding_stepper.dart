import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_icons/phosphor_icons.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/contrast_color.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../models/onboarding_state.dart';
import '../providers/onboarding_providers.dart';

/// Circle diameter — noticeably bigger than a decorative dot, and clears
/// the 44dp minimum touch target as a side benefit even though these
/// circles aren't currently tappable.
const _circleSize = 44.0;
const _lineThickness = 6.0;

/// The persistent "STEP X/3" header. Reads [onboardingProvider] directly
/// (rather than taking a pre-computed progress value) so every segment's
/// fill is always freshly derived from live field-validity state — any
/// field's `onChanged` that updates the provider rebuilds this straight
/// from [segmentFillFraction]/[stepCircleStateFor], never a value that was
/// only set once per step.
class OnboardingStepper extends ConsumerWidget {
  const OnboardingStepper({super.key, required this.stepCount});

  final int stepCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(onboardingProvider);
    final currentIndex = OnboardingStep.values.indexOf(state.step);

    return Column(
      children: [
        Text(
          l10n.onboardingStepIndicator(currentIndex + 1, stepCount),
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: _circleSize,
          child: Stack(
            children: [
              // Background layer: the connecting lines only, using
              // circle-sized invisible placeholders so its segments land
              // in exactly the same slots as the circles below.
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (var i = 0; i < stepCount; i++) ...[
                    const SizedBox(width: _circleSize, height: _circleSize),
                    if (i != stepCount - 1)
                      Expanded(
                        child: _StepSegment(
                          fillFraction: segmentFillFraction(state, i),
                          color: _segmentColorFor(
                            context.colors,
                            stepCircleStateFor(state, i + 1),
                          ),
                        ),
                      ),
                  ],
                ],
              ),
              // Foreground layer: the circles, painted after (= on top of)
              // the line layer above, so a line's tip never pokes past a
              // circle's edge — each circle fully caps its line ends.
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (var i = 0; i < stepCount; i++) ...[
                    _StepCircle(
                      stepNumber: i + 1,
                      state: stepCircleStateFor(state, i),
                    ),
                    if (i != stepCount - 1) const Expanded(child: SizedBox()),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// The color a segment takes on once (partially or fully) filled — the
/// state of the circle it leads *into* ([circleIndex] `i + 1`): success
/// once that step is completed, warning if it was left incomplete/skipped,
/// accent while it's the current step being filled in. "Upcoming" never
/// actually paints (its segment's fill fraction is always 0).
Color _segmentColorFor(AppColors colors, StepCircleState state) {
  return switch (state) {
    StepCircleState.completed => colors.success,
    StepCircleState.skippedIncomplete => colors.warning,
    StepCircleState.current => colors.accent,
    StepCircleState.upcoming => colors.accent,
  };
}

/// One connecting-line segment: a background layer (full width, [border]
/// token, static) and a foreground layer (an [AnimatedContainer]) whose
/// width tracks [fillFraction] — the fraction of *this one segment*, not
/// the whole line — and whose [color] reflects the state of the step it
/// leads into (see [_segmentColorFor]).
class _StepSegment extends StatelessWidget {
  const _StepSegment({required this.fillFraction, required this.color});

  final double fillFraction;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      height: _lineThickness,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              // Background layer: full-width line, fixed.
              Container(
                width: constraints.maxWidth,
                height: _lineThickness,
                color: colors.border,
              ),
              // Foreground layer: animates to the live per-field fraction.
              AnimatedContainer(
                duration: AppMotion.base,
                curve: AppMotion.curve,
                width: constraints.maxWidth * fillFraction.clamp(0.0, 1.0),
                height: _lineThickness,
                color: color,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _StepCircle extends StatelessWidget {
  const _StepCircle({required this.stepNumber, required this.state});

  final int stepNumber;
  final StepCircleState state;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = AppLocalizations.of(context);

    final (
      Color background,
      Color iconColor,
      IconData icon,
      double scale,
    ) = switch (state) {
      StepCircleState.upcoming => (
        colors.border,
        colors.textSecondary,
        PhosphorIconsRegular.circle,
        1.0,
      ),
      StepCircleState.current => (
        colors.accent,
        readableTextColorFor(colors.accent),
        PhosphorIconsFill.pencilSimple,
        1.15,
      ),
      StepCircleState.completed => (
        colors.success,
        readableTextColorFor(colors.success),
        PhosphorIconsFill.check,
        1.0,
      ),
      StepCircleState.skippedIncomplete => (
        colors.warning,
        readableTextColorFor(colors.warning),
        PhosphorIconsFill.warning,
        1.0,
      ),
    };

    final stateText = switch (state) {
      StepCircleState.upcoming => l10n.onboardingStepStateUpcoming,
      StepCircleState.current => l10n.onboardingStepStateCurrent,
      StepCircleState.completed => l10n.onboardingStepStateCompleted,
      StepCircleState.skippedIncomplete => l10n.onboardingStepStateSkipped,
    };

    return Semantics(
      label: l10n.onboardingStepCircleLabel(stepNumber, stateText),
      excludeSemantics: true,
      child: TweenAnimationBuilder<double>(
        key: ValueKey(state),
        tween: Tween<double>(begin: 0.85, end: scale),
        duration: AppMotion.base,
        curve: AppMotion.curve,
        builder: (context, animatedScale, child) {
          return Transform.scale(scale: animatedScale, child: child);
        },
        child: AnimatedContainer(
          duration: AppMotion.base,
          curve: AppMotion.curve,
          width: _circleSize,
          height: _circleSize,
          decoration: BoxDecoration(color: background, shape: BoxShape.circle),
          child: Center(
            child: AnimatedSwitcher(
              duration: AppMotion.fast,
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: FadeTransition(opacity: animation, child: child),
              ),
              child: Icon(
                icon,
                key: ValueKey(icon),
                size: 22,
                color: iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
