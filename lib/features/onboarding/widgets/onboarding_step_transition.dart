import 'package:flutter/material.dart';

/// Cross-fades and slides between onboarding steps, per design.md's motion
/// principle: ease-out (fast start, gentle settle), never linear, and kept
/// under ~400ms.
///
/// [isForward] controls slide direction: a step entering via "Next" slides
/// in from the reading-end (right in LTR, left in RTL) and out toward the
/// start; "Back" reverses both. Direction-awareness comes from
/// [Directionality] at build time, not a hardcoded left/right.
class OnboardingStepTransition extends StatelessWidget {
  const OnboardingStepTransition({
    super.key,
    required this.isForward,
    required this.child,
  });

  final bool isForward;
  final Widget child;

  static const _duration = Duration(milliseconds: 320);

  @override
  Widget build(BuildContext context) {
    final directionSign = Directionality.of(context) == TextDirection.rtl
        ? -1.0
        : 1.0;
    final enterFromEnd = (isForward ? 1.0 : -1.0) * directionSign;

    return AnimatedSwitcher(
      duration: _duration,
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: (child, animation) {
        final isIncoming = child.key == this.child.key;
        final beginOffset = isIncoming
            ? Offset(0.06 * enterFromEnd, 0)
            : Offset(-0.06 * enterFromEnd, 0);
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: beginOffset,
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [...previousChildren, ?currentChild],
        );
      },
      child: child,
    );
  }
}
