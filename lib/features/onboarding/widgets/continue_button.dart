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

/// The perimeter fraction the glowing segment always spans while visible.
const glowSegmentFraction = 0.22;

/// A deliberate, tiny overshoot on the head position so the very last
/// frame's segment overlaps its own closure point by a hair rather than
/// landing exactly on it — floating-point/frame-timing slack right at
/// closure otherwise reads as a hairline gap. Invisible mid-sweep; only
/// matters in the last couple of pixels.
const glowClosureOverlapPx = 1.5;

/// The `(start, end)` ranges (in path-length pixels, for [PathMetric.
/// extractPath]) to draw for the glow segment at a given [progress] (0.0 to
/// 1.0) around a closed perimeter of length [total]:
///
/// - `0.0`: no ranges — zero-length, sitting at the path's start point.
/// - Ramps up to full length ([glowSegmentFraction] of the perimeter) as
///   its leading edge pulls away from the start point.
/// - Holds that fixed length while sweeping the rest of the perimeter.
/// - Shrinks back to zero-length as its trailing edge catches up to the
///   leading edge, exactly at the start point again, at `progress == 1.0`.
///
/// So the glow visibly emerges from one point, travels the full loop, and
/// converges back on that same point — rather than just growing outward
/// from a fixed start like a simple progress ring.
///
/// [glowClosureOverlapPx] can push the head position past [total] in the
/// final frames; a naive single range would then stop short at `total`,
/// leaving a gap right at closure. When that happens this returns *two*
/// ranges instead — `(tail, total)` and `(0, overflow)` — so the caller
/// draws both pieces of the wrap rather than losing the overflow.
List<(double, double)> glowSegmentRanges({
  required double progress,
  required double total,
}) {
  const totalHeadDistance = 1.0 + glowSegmentFraction;
  final headRaw = progress * totalHeadDistance;
  final head = headRaw.clamp(0.0, 1.0);
  final tail = (headRaw - glowSegmentFraction).clamp(0.0, 1.0);
  if (head <= tail) return const [];

  final tailPx = tail * total;
  final headPx = (head * total) + glowClosureOverlapPx;

  if (headPx <= total) return [(tailPx, headPx)];
  return [(tailPx, total), (0, headPx - total)];
}

class _GlowSegmentPainter extends CustomPainter {
  const _GlowSegmentPainter({
    required this.progress,
    required this.color,
    required this.borderRadius,
  });

  final double progress;
  final Color color;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(borderRadius),
    );
    final metric = (Path()..addRRect(rrect)).computeMetrics().first;
    final total = metric.length;
    final ranges = glowSegmentRanges(progress: progress, total: total);
    if (ranges.isEmpty) return;

    // Butt caps (flat, ending exactly at the coordinate) rather than round
    // — a round cap's dome can visually inset from the true endpoint,
    // which reads as a gap right where the segment should meet flush with
    // its own starting point.
    final glow = Paint()
      ..color = color.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.butt
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    final core = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.butt;

    for (final range in ranges) {
      final part = metric.extractPath(range.$1, range.$2);
      canvas.drawPath(part, glow);
      canvas.drawPath(part, core);
    }
  }

  @override
  bool shouldRepaint(covariant _GlowSegmentPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
