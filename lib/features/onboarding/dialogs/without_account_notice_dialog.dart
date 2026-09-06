import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';

/// The one-time notice shown right after skipping onboarding, spelling out
/// what won't be available without an account.
Future<void> showWithoutAccountNoticeDialog(BuildContext context) {
  final l10n = AppLocalizations.of(context);
  final bullets = [
    l10n.onboardingWithoutAccountBulletSaveRoutes,
    l10n.onboardingWithoutAccountBulletSyncSettings,
    l10n.onboardingWithoutAccountBulletContribute,
  ];

  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.onboardingWithoutAccountTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.onboardingWithoutAccountIntro),
          const SizedBox(height: 12),
          for (final bullet in bullets)
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('•  '),
                  Expanded(child: Text(bullet)),
                ],
              ),
            ),
        ],
      ),
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.onboardingWithoutAccountDismiss),
        ),
      ],
    ),
  );
}
