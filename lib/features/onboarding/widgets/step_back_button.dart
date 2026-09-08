import 'package:flutter/material.dart';
import 'package:phosphor_icons/phosphor_icons.dart';

import '../../../l10n/generated/app_localizations.dart';

/// A small back affordance shown above a step's title, for any step that
/// isn't first. Kept out of the bottom action area on purpose — the bottom
/// is reserved for the single, full-width Continue button.
class StepBackButton extends StatelessWidget {
  const StepBackButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // A plain, default-sized IconButton — its full 48dp hit area is kept
    // intact rather than zeroed out for a pixel-tight visual fit against
    // the title below (a prior version did that, shrinking the tappable
    // region below the 48dp accessibility minimum).
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 4),
      child: IconButton(
        onPressed: onPressed,
        tooltip: l10n.onboardingBackButtonTooltip,
        // Every Phosphor glyph carries matchTextDirection: true, so this
        // auto-mirrors in RTL and always points toward "back" in reading
        // order — no manual left/right logic needed.
        icon: const Icon(PhosphorIconsRegular.arrowLeft),
      ),
    );
  }
}
