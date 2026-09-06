import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/contrast_color.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../models/onboarding_state.dart';
import '../providers/onboarding_providers.dart';

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
          ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (var i = 0; i < stepCount; i++) ...[
                _StepCircle(state: stepCircleStateFor(state, i)),
                if (i != stepCount - 1)
                  Expanded(
                    child: _StepSegment(
                      fillFraction: segmentFillFraction(state, i),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// One connecting-line segment: a background layer (full width, [border]
/// token, static) and a foreground layer (an [AnimatedContainer], [accent]
/// token) whose width tracks [fillFraction] — the fraction of *this one
/// segment*, not the whole line.
class _StepSegment extends StatelessWidget {
  const _StepSegment({required this.fillFraction});

  final double fillFraction;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      height: 3,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              // Background layer: full-width line, fixed.
              Container(
                width: constraints.maxWidth,
                height: 3,
                color: colors.border,
              ),
              // Foreground layer: animates to the live per-field fraction.
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                width: constraints.maxWidth * fillFraction.clamp(0.0, 1.0),
                height: 3,
                color: colors.accent,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _StepCircle extends StatelessWidget {
  const _StepCircle({required this.state});

  final StepCircleState state;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final (
      Color background,
      Color iconColor,
      IconData icon,
      double scale,
    ) = switch (state) {
      StepCircleState.upcoming => (
        colors.border,
        colors.textSecondary,
        Icons.radio_button_unchecked_rounded,
        1.0,
      ),
      StepCircleState.current => (
        colors.accent,
        readableTextColorFor(colors.accent),
        Icons.edit_rounded,
        1.15,
      ),
      StepCircleState.completed => (
        colors.success,
        readableTextColorFor(colors.success),
        Icons.check_rounded,
        1.0,
      ),
      StepCircleState.skippedIncomplete => (
        colors.warning,
        readableTextColorFor(colors.warning),
        Icons.warning_rounded,
        1.0,
      ),
    };

    return TweenAnimationBuilder<double>(
      key: ValueKey(state),
      tween: Tween<double>(begin: 0.85, end: scale),
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      builder: (context, animatedScale, child) {
        return Transform.scale(scale: animatedScale, child: child);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        width: 32,
        height: 32,
        decoration: BoxDecoration(color: background, shape: BoxShape.circle),
        child: Icon(icon, size: 18, color: iconColor),
      ),
    );
  }
}
