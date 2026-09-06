import 'package:flutter/material.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../dialogs/tutorial_prompt_dialog.dart';

/// Final screen after the 3-step stepper: celebrate, then offer a quick
/// tour before handing off to [onFinished] (which the flow screen wires to
/// navigate home).
class CompletionStep extends StatefulWidget {
  const CompletionStep({super.key, required this.onFinished});

  final VoidCallback onFinished;

  @override
  State<CompletionStep> createState() => _CompletionStepState();
}

class _CompletionStepState extends State<CompletionStep> {
  @override
  void initState() {
    super.initState();
    // Let the step's entrance transition settle before asking anything.
    Future.delayed(const Duration(milliseconds: 600), _promptForTutorial);
  }

  Future<void> _promptForTutorial() async {
    if (!mounted) return;
    await showTutorialPromptDialog(context);
    if (!mounted) return;
    widget.onFinished();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Text(
        l10n.onboardingCompletionMessage,
        textAlign: TextAlign.center,
        style: Theme.of(
          context,
        ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}
