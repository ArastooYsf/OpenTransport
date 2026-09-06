import 'dart:math' as math;

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../widgets/continue_button.dart';

/// Final screen after the 3-step stepper: a one-off celebratory moment
/// (confetti, oversized congratulatory text — deliberately bigger than any
/// other text size in the app, see design.md's "utility app, not an
/// editorial one" type-scale rule, which this screen is the one exception
/// to) before the user taps Continue and hands off to [onFinished], which
/// the flow screen wires to navigate home. The tutorial-tour prompt is
/// *not* shown here — it appears a beat after landing on the home screen
/// (see `HomeScreen.showTutorialPrompt`), not on top of this screen.
class CompletionStep extends StatefulWidget {
  const CompletionStep({super.key, required this.onFinished});

  final VoidCallback onFinished;

  @override
  State<CompletionStep> createState() => _CompletionStepState();
}

class _CompletionStepState extends State<CompletionStep> {
  static const _confettiDuration = Duration(seconds: 2, milliseconds: 500);

  late final ConfettiController _confettiController = ConfettiController(
    duration: _confettiDuration,
  )..play();

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  l10n.onboardingCompletionMessage,
                  textAlign: TextAlign.center,
                  // Bigger than any other text size in the app on purpose —
                  // a one-off celebratory moment breaking the small,
                  // utility-app type scale design.md otherwise calls for.
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            ContinueButton(
              label: l10n.onboardingContinueButton,
              enabled: true,
              onPressed: widget.onFinished,
            ),
          ],
        ),
        // Falls from the top of the screen, in the app's own palette
        // (accent + semantic colors) rather than a random rainbow, so it
        // reads as on-brand rather than a generic effect.
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirection: math.pi / 2,
          numberOfParticles: 24,
          maxBlastForce: 12,
          minBlastForce: 6,
          emissionFrequency: 0.08,
          gravity: 0.25,
          shouldLoop: false,
          colors: [
            colors.accent,
            colors.success,
            colors.warning,
            colors.danger,
            colors.info,
          ],
        ),
      ],
    );
  }
}
