import 'package:flutter/material.dart';
import 'package:phosphor_icons/phosphor_icons.dart';

import '../theme/app_theme.dart';
import '../../l10n/generated/app_localizations.dart';

/// The "X" that appears once a field has text and clears it on tap — shared
/// by every text field in the app ([ClearableTextField] and
/// [AutocompleteField]) so it fades in/out the same way everywhere, rather
/// than one field animating it and another swapping it instantly.
class AnimatedClearIcon extends StatelessWidget {
  const AnimatedClearIcon({
    super.key,
    required this.visible,
    required this.onPressed,
  });

  final bool visible;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AnimatedSwitcher(
      duration: AppMotion.fast,
      transitionBuilder: (child, animation) =>
          FadeTransition(opacity: animation, child: child),
      child: visible
          ? IconButton(
              key: const ValueKey('clear'),
              icon: const Icon(PhosphorIconsRegular.x),
              tooltip: l10n.commonClearFieldTooltip,
              onPressed: onPressed,
            )
          : const SizedBox(key: ValueKey('empty'), width: 0),
    );
  }
}
