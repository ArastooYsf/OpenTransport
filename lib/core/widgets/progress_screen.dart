import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// How long a rotating message should stay on screen: longer messages get
/// more time, with a floor so even a short message is readable.
int rotatingMessageDurationMs(String message) {
  return math.max(1800, message.length * 45);
}

/// A reusable progress screen for long-running operations (map downloads,
/// data updates, ...): a slim progress bar plus a rotating strip of short
/// messages below it (tips, context, welcome notes) that cross-fade in and
/// out rather than cutting abruptly.
///
/// [progress] is 0.0–1.0 for a determinate bar, or `null` for indeterminate
/// (e.g. while the total size isn't known yet). [messages] is supplied by
/// the caller so different screens can offer their own message sets.
class ProgressScreen extends StatefulWidget {
  const ProgressScreen({
    super.key,
    required this.messages,
    this.progress,
    this.title,
  });

  final List<String> messages;
  final double? progress;
  final String? title;

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  int _messageIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _scheduleNextMessage();
  }

  @override
  void didUpdateWidget(covariant ProgressScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.messages != widget.messages) {
      _messageIndex = 0;
      _scheduleNextMessage();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _scheduleNextMessage() {
    _timer?.cancel();
    if (widget.messages.length < 2) return;
    final currentMessage = widget.messages[_messageIndex];
    _timer = Timer(
      Duration(milliseconds: rotatingMessageDurationMs(currentMessage)),
      () {
        if (!mounted) return;
        setState(() {
          _messageIndex = (_messageIndex + 1) % widget.messages.length;
        });
        _scheduleNextMessage();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final title = widget.title;

    return Scaffold(
      appBar: title == null ? null : AppBar(title: Text(title)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: SizedBox(
                  height: 4,
                  width: double.infinity,
                  child: LinearProgressIndicator(
                    value: widget.progress,
                    color: context.colors.accent,
                    backgroundColor: scheme.surfaceContainerHighest,
                  ),
                ),
              ),
              if (widget.messages.isNotEmpty) ...[
                const SizedBox(height: 28),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: Text(
                    widget.messages[_messageIndex],
                    key: ValueKey(_messageIndex),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
