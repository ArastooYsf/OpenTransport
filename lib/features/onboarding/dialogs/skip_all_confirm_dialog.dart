import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';

/// Confirms that the user wants to abandon onboarding entirely. Returns
/// `true` if they confirmed, `false`/`null` if they backed out.
Future<bool?> showSkipAllConfirmDialog(BuildContext context) {
  final l10n = AppLocalizations.of(context);
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(l10n.onboardingSkipConfirmMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(l10n.commonConfirm),
        ),
      ],
    ),
  );
}
