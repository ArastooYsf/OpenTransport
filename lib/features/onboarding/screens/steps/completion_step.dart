import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../providers/onboarding_providers.dart';
import '../../widgets/continue_button.dart';

/// Final screen after the 3-step stepper: a one-off celebratory moment
/// (a single confetti burst, oversized congratulatory text — deliberately
/// bigger than any other text size in the app, see design.md's "utility
/// app, not an editorial one" type-scale rule, which this screen is the
/// one exception to) before the user taps Continue and hands off to
/// [onFinished], which the flow screen wires to navigate home. The
/// tutorial-tour prompt is *not* shown here — it appears a beat after
/// landing on the home screen (see `HomeScreen.showTutorialPrompt`), not on
/// top of this screen. There's no "skip all" here either — see
/// [OnboardingScaffold]; it makes no sense once everything's finished.
class CompletionStep extends ConsumerStatefulWidget {
  const CompletionStep({super.key, required this.onFinished});

  final VoidCallback onFinished;

  @override
  ConsumerState<CompletionStep> createState() => _CompletionStepState();
}

class _CompletionStepState extends ConsumerState<CompletionStep> {
  // A single short burst, not a multi-second stream — see confetti's own
  // "explosive" blast mode below, which releases everything at once.
  static const _confettiDuration = Duration(milliseconds: 300);

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
    final state = ref.watch(onboardingProvider);
    final displayName = state.username.isNotEmpty
        ? state.username
        : state.firstName;
    final headlineStyle = Theme.of(
      context,
    ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w700);

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.onboardingCompletionGreeting,
                      textAlign: TextAlign.center,
                      style: headlineStyle,
                    ),
                    if (displayName.isNotEmpty)
                      Text(
                        displayName,
                        textAlign: TextAlign.center,
                        style: headlineStyle?.copyWith(color: colors.accent),
                      ),
                  ],
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
        // A single emitter, top-center, firing one explosive burst — every
        // piece releases at once rather than streaming continuously, then
        // falls and fades under the confetti package's own gravity/fade.
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          numberOfParticles: 40,
          maxBlastForce: 20,
          minBlastForce: 10,
          gravity: 0.3,
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
