import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart' show AppColorsX;

/// The big, full-width "Continue" button pinned at the bottom of each
/// onboarding step.
///
/// On tap, a fixed-length glowing segment starts at one point on the
/// button's perimeter, sweeps all the way around, and converges back on
/// that exact same point — see [_GlowSegmentPainter] — then holds briefly
/// once fully stopped before [onPressed] fires. Total time (sweep + hold)
/// stays under design.md's ~1s budget for this kind of confirmation
/// animation, so it reads as "processing," not as an artificial delay.
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
    with SingleTickerProviderStateMixin {
  static const _sweepDuration = Duration(milliseconds: 700);
  static const _holdDuration = Duration(milliseconds: 180);
  static const _borderRadius = 26.0;

  late final AnimationController _sweepController = AnimationController(
    vsync: this,
    duration: _sweepDuration,
  );
  bool _isProcessing = false;

  @override
  void dispose() {
    _sweepController.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    if (!widget.enabled || _isProcessing) return;
    setState(() => _isProcessing = true);
    await _sweepController.forward(from: 0);
    if (!mounted) return;
    await Future<void>.delayed(_holdDuration);
    if (!mounted) return;
    setState(() => _isProcessing = false);
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: AnimatedBuilder(
        animation: _sweepController,
        builder: (context, child) {
          return CustomPaint(
            foregroundPainter: _isProcessing
                ? _GlowSegmentPainter(
                    progress: Curves.easeInOut.transform(
                      _sweepController.value,
                    ),
                    color: context.colors.accent,
                    borderRadius: _borderRadius,
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
          child: Text(widget.label),
        ),
      ),
    );
  }
}

/// Paints a fixed-length glowing segment of the button's rounded-rect
/// outline, at a position determined by [progress]:
///
/// - `0.0`: zero-length, sitting at the path's start point.
/// - Ramps up to full length ([_segmentFraction] of the perimeter) as its
///   leading edge pulls away from the start point.
/// - Holds that fixed length while sweeping the rest of the perimeter.
/// - Shrinks back to zero-length as its trailing edge catches up to the
///   leading edge, exactly at the start point again, when `progress == 1.0`.
///
/// So the glow visibly emerges from one point, travels the full loop, and
/// converges back on that same point — rather than just growing outward
/// from a fixed start like a simple progress ring.
class _GlowSegmentPainter extends CustomPainter {
  const _GlowSegmentPainter({
    required this.progress,
    required this.color,
    required this.borderRadius,
  });

  final double progress;
  final Color color;
  final double borderRadius;

  static const _segmentFraction = 0.22;
  static const _totalHeadDistance = 1.0 + _segmentFraction;

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(borderRadius),
    );
    final metric = (Path()..addRRect(rrect)).computeMetrics().first;
    final total = metric.length;

    final headRaw = progress * _totalHeadDistance;
    final head = headRaw.clamp(0.0, 1.0);
    final tail = (headRaw - _segmentFraction).clamp(0.0, 1.0);
    if (head <= tail) return;

    final segment = metric.extractPath(tail * total, head * total);

    final glow = Paint()
      ..color = color.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawPath(segment, glow);

    final core = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(segment, core);
  }

  @override
  bool shouldRepaint(covariant _GlowSegmentPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
