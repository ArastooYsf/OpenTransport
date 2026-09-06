import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';
import 'onboarding_stepper.dart';
import '../providers/onboarding_providers.dart';

/// Shared chrome for every onboarding screen: the "Skip all" action and,
/// while [stepIndex] is within the stepper (see [stepperStepCount]), the
/// "STEP X/3" header — hidden on the final completion screen, which isn't
/// part of the numbered stepper. [OnboardingStepper] reads step/field state
/// from Riverpod directly, so this scaffold only needs to know whether to
/// show it.
class OnboardingScaffold extends StatelessWidget {
  const OnboardingScaffold({
    super.key,
    required this.stepIndex,
    required this.onSkipAll,
    required this.child,
  });

  final int stepIndex;
  final VoidCallback onSkipAll;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final showStepper = stepIndex < stepperStepCount;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onSkipAll,
                    child: Text(l10n.commonSkipAll),
                  ),
                ],
              ),
              if (showStepper) ...[
                const SizedBox(height: 4),
                const OnboardingStepper(stepCount: stepperStepCount),
                const SizedBox(height: 24),
              ],
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
