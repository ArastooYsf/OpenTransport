import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

/// The big, full-width "Continue" button pinned at the bottom of each
/// onboarding step. On tap, traces an animated ring around its border
/// (reading as "processing," not as a delay — design.md wants transitions
/// fast, so this stays under ~600ms) before calling [onPressed], which the
/// caller uses to advance to the next step.
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
  late final AnimationController _ringController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
  );
  bool _isProcessing = false;

  @override
  void dispose() {
    _ringController.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    if (!widget.enabled || _isProcessing) return;
    setState(() => _isProcessing = true);
    await _ringController.forward(from: 0);
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
        animation: _ringController,
        builder: (context, child) {
          return CustomPaint(
            foregroundPainter: _isProcessing
                ? _RingTracePainter(
                    progress: Curves.easeOut.transform(_ringController.value),
                    color: AppTheme.accent,
                  )
                : null,
            child: child,
          );
        },
        child: FilledButton(
          onPressed: widget.enabled && !_isProcessing ? _handleTap : null,
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}

class _RingTracePainter extends CustomPainter {
  const _RingTracePainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(26),
    );
    final path = Path()..addRRect(rrect);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    for (final metric in path.computeMetrics()) {
      canvas.drawPath(metric.extractPath(0, metric.length * progress), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _RingTracePainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
