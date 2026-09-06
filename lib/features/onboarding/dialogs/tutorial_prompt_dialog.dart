import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';

/// The completion-step dialog offering a quick app tour. Returns `true` if
/// the user wants the tour, `false` if they skipped it — either way, the
/// caller proceeds to the home screen (the tour itself isn't built yet;
/// this is the hook point for it, same as the `assistant/` layer's
/// stable-interface-first pattern in CLAUDE.md).
Future<bool> showTutorialPromptDialog(BuildContext context) async {
  final l10n = AppLocalizations.of(context);
  final wantsTutorial = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Text(l10n.onboardingTutorialPromptQuestion),
      content: Text(
        l10n.onboardingTutorialPromptNote,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.onboardingTutorialSkipButton),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(l10n.onboardingTutorialShowButton),
        ),
      ],
    ),
  );
  return wantsTutorial ?? false;
}
