import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

/// A slim, indeterminate progress bar in the brand accent color, per
/// design.md's explicit "splash-screen loading bar" use of the accent.
///
/// Indeterminate (rather than a fake determinate fill) on purpose: it looks
/// correct regardless of how long initialization actually takes, so the
/// current fake delay in [SplashScreen] can be swapped for real async init
/// later without this widget needing to change at all.
class SplashLoadingBar extends StatelessWidget {
  const SplashLoadingBar({super.key, this.width = 120});

  final double width;

  @override
  Widget build(BuildContext context) {
    final accent = context.colors.accent;
    return SizedBox(
      width: width,
      height: 4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: LinearProgressIndicator(
          color: accent,
          backgroundColor: accent.withValues(alpha: 0.15),
        ),
      ),
    );
  }
}
