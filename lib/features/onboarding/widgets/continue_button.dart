import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart' show AppColorsX, AppTheme;
import '../../../core/utils/contrast_color.dart';

/// The big, full-width "Continue" button pinned at the bottom of each
/// onboarding step.
///
/// On tap, plays a two-phase confirmation (see [_ButtonFxPainter]):
/// 1. A glowing border traces the button's outline, growing from 0% of the
///    perimeter at a fixed anchor point up to a full 100% loop back to
///    that same point (the stroke's "end" travels all the way around
///    while its "start" stays anchored) — not a fixed-length segment.
/// 2. Once that loop closes, a small filled circle appears at the same
///    anchor point and expands (a circular reveal) until it covers the
///    whole button in [AppColors.accentPressed] — a visible "confirmed"
///    fill sweep, not an instant color swap.
///
/// Only once both finish does [onPressed] fire.
class ContinueButton extends StatefulWidget {
  const ContinueButton({
    super.key,
    required this.label,
    required this.enabled,
    required this.onPressed,
  });

  final String label;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  State<ContinueButton> createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<ContinueButton>
    with TickerProviderStateMixin {
  // design.md caps a primary-action confirmation at "~1s total including
  // any settle/pause" — 480 + 320 = 800ms, leaving real margin rather than
  // sitting right at the limit.
  static const _ringDuration = Duration(milliseconds: 480);
  static const _fillDuration = Duration(milliseconds: 320);
  static const _borderRadius = AppTheme.pillRadius;

  late final AnimationController _ringController = AnimationController(
    vsync: this,
    duration: _ringDuration,
  );
  late final AnimationController _fillController = AnimationController(
    vsync: this,
    duration: _fillDuration,
  );
  bool _isProcessing = false;

  @override
  void dispose() {
    _ringController.dispose();
    _fillController.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    if (!widget.enabled || _isProcessing) return;
    setState(() => _isProcessing = true);
    await _ringController.forward(from: 0);
    if (!mounted) return;
    await _fillController.forward(from: 0);
    if (!mounted) return;
    setState(() => _isProcessing = false);
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    // Computed once against the resting accent fill — accentPressed is
    // consistently *lighter* than accent in both themes (see design.md's
    // Color system), so this stays readable throughout the reveal sweep
    // too without needing to recompute per frame.
    final onAccent = readableTextColorFor(colors.accent);

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: AnimatedBuilder(
        animation: Listenable.merge([_ringController, _fillController]),
        builder: (context, child) {
          return CustomPaint(
            foregroundPainter: _isProcessing
                ? _ButtonFxPainter(
                    ringProgress: Curves.easeOut.transform(
                      _ringController.value,
                    ),
                    fillProgress: Curves.easeOut.transform(
                      _fillController.value,
                    ),
                    borderRadius: _borderRadius,
                    ringColor: colors.accent,
                    fillColor: colors.accentPressed,
                    textDirection: Directionality.of(context),
                  )
                : null,
            child: child,
          );
        },
        child: FilledButton(
          onPressed: widget.enabled && !_isProcessing ? _handleTap : null,
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_borderRadius),
            ),
          ),
          child: DefaultTextStyle.merge(
            style: TextStyle(color: onAccent),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}

/// The anchor both animation phases share — a fixed point on the button's
/// perimeter (its top corner at the *end* of reading order: top-right in
/// LTR, top-left in RTL, via [AlignmentDirectional]) that the ring grows
/// away from and the fill circle expands from.
Offset buttonFxAnchor(Size size, TextDirection textDirection) {
  return AlignmentDirectional.topEnd
      .resolve(textDirection)
      .withinRect(Offset.zero & size);
}

/// The circle radius needed, at a given [progress] (0.0-1.0), to fully
/// cover a [size]-sized rect from [anchor] — i.e. the distance to the
/// *farthest* corner, scaled by progress. At `progress == 1` the circle's
/// edge reaches the farthest corner exactly, guaranteeing full coverage
/// (the caller clips to the button's own rounded-rect shape, so a corner
/// landing exactly on the circle's edge is enough — nothing outside the
/// button's bounds needs covering).
double revealRadiusFor({
  required double progress,
  required Size size,
  required Offset anchor,
}) {
  final corners = [
    Offset.zero,
    Offset(size.width, 0),
    Offset(0, size.height),
    Offset(size.width, size.height),
  ];
  final maxDistance = corners
      .map((corner) => (corner - anchor).distance)
      .reduce(math.max);
  return progress.clamp(0.0, 1.0) * maxDistance;
}

class _ButtonFxPainter extends CustomPainter {
  const _ButtonFxPainter({
    required this.ringProgress,
    required this.fillProgress,
    required this.borderRadius,
    required this.ringColor,
    required this.fillColor,
    required this.textDirection,
  });

  final double ringProgress;
  final double fillProgress;
  final double borderRadius;
  final Color ringColor;
  final Color fillColor;
  final TextDirection textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(borderRadius),
    );
    final anchor = buttonFxAnchor(size, textDirection);

    if (fillProgress > 0) {
      final radius = revealRadiusFor(
        progress: fillProgress,
        size: size,
        anchor: anchor,
      );
      canvas.save();
      canvas.clipRRect(rrect);
      canvas.drawCircle(anchor, radius, Paint()..color = fillColor);
      canvas.restore();
    }

    if (ringProgress > 0 && fillProgress == 0) {
      final metric = (Path()..addRRect(rrect)).computeMetrics().first;
      final segment = metric.extractPath(
        0,
        metric.length * ringProgress.clamp(0.0, 1.0),
      );

      final glow = Paint()
        ..color = ringColor.withValues(alpha: 0.35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8
        ..strokeCap = StrokeCap.butt
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      final core = Paint()
        ..color = ringColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.butt;

      canvas.drawPath(segment, glow);
      canvas.drawPath(segment, core);
    }
  }

  @override
  bool shouldRepaint(covariant _ButtonFxPainter oldDelegate) =>
      oldDelegate.ringProgress != ringProgress ||
      oldDelegate.fillProgress != fillProgress ||
      oldDelegate.ringColor != ringColor ||
      oldDelegate.fillColor != fillColor;
}
