import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/contrast_color.dart';
import '../providers/onboarding_providers.dart';

/// The persistent "STEP X/3" header: a horizontal connecting line whose
/// fill tracks actual field-completion progress (not just a per-step
/// jump), with a circle per step showing one of four states.
class OnboardingStepper extends StatelessWidget {
  const OnboardingStepper({
    super.key,
    required this.stepIndex,
    required this.stepCount,
    required this.progress,
    required this.circleStateAt,
    required this.stepLabel,
  });

  final int stepIndex;
  final int stepCount;

  /// 0.0–1.0 overall completion, animated smoothly as it changes.
  final double progress;
  final StepCircleState Function(int circleIndex) circleStateAt;
  final String stepLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          stepLabel,
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 40,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  PositionedDirectional(
                    top: 19,
                    start: 20,
                    end: 20,
                    child: _ConnectingLine(progress: progress),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var i = 0; i < stepCount; i++)
                        _StepCircle(state: circleStateAt(i)),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ConnectingLine extends StatelessWidget {
  const _ConnectingLine({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: SizedBox(
        height: 3,
        child: Stack(
          children: [
            ColoredBox(color: scheme.surfaceContainerHighest),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: progress),
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return FractionallySizedBox(
                  alignment: AlignmentDirectional.centerStart,
                  widthFactor: value.clamp(0, 1),
                  child: ColoredBox(color: AppTheme.accent),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _StepCircle extends StatelessWidget {
  const _StepCircle({required this.state});

  final StepCircleState state;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final (
      Color background,
      Color iconColor,
      IconData icon,
      double scale,
    ) = switch (state) {
      StepCircleState.upcoming => (
        scheme.surfaceContainerHighest,
        scheme.outline,
        Icons.radio_button_unchecked_rounded,
        1.0,
      ),
      StepCircleState.current => (
        AppTheme.accent,
        readableTextColorFor(AppTheme.accent),
        Icons.edit_rounded,
        1.15,
      ),
      StepCircleState.completed => (
        AppTheme.success,
        readableTextColorFor(AppTheme.success),
        Icons.check_rounded,
        1.0,
      ),
      StepCircleState.skippedIncomplete => (
        AppTheme.warning,
        readableTextColorFor(AppTheme.warning),
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
