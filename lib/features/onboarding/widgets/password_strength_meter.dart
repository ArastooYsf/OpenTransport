import 'package:flutter/material.dart';
import 'package:phosphor_icons/phosphor_icons.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/contrast_color.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../validation.dart';

/// A segmented strength bar plus friendly, non-blocking suggestions —
/// replaces a pass/fail checklist on purpose (see step 3's spec: "friendly
/// advice, not a security audit"). Only the 8-character minimum is a hard
/// requirement, enforced by the caller's Continue button, not here.
class PasswordStrengthMeter extends StatelessWidget {
  const PasswordStrengthMeter({super.key, required this.password});

  final String password;

  static const _segmentCount = 4;

  @override
  Widget build(BuildContext context) {
    if (password.isEmpty) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final colors = context.colors;
    final score = passwordExtraCriteriaScore(password);
    final strength = passwordStrengthFor(password);
    final filledSegments = score + 1;

    final (color, label) = switch (strength) {
      PasswordStrength.weak => (
        colors.danger,
        l10n.onboardingPasswordStrengthWeak,
      ),
      PasswordStrength.good => (
        colors.warning,
        l10n.onboardingPasswordStrengthGood,
      ),
      PasswordStrength.strong => (
        colors.success,
        l10n.onboardingPasswordStrengthStrong,
      ),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            for (var i = 0; i < _segmentCount; i++)
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: i == _segmentCount - 1 ? 0 : 4,
                  ),
                  child: AnimatedContainer(
                    duration: AppMotion.base,
                    curve: AppMotion.curve,
                    height: 4,
                    decoration: BoxDecoration(
                      color: i < filledSegments
                          ? color
                          : scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        // A filled pill (color + computed-contrast text), the same
        // fill-plus-readable-text pattern line badges use — not raw
        // colored text directly on the surface. design.md's own
        // `warning`/`success`/`danger` hexes fail WCAG text contrast at
        // this size against a light background (as low as 2.15:1 for
        // warning), so the label needs a guaranteed-readable pairing
        // rather than the semantic hue itself as the text color.
        AnimatedContainer(
          duration: AppMotion.fast,
          curve: AppMotion.curve,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: readableTextColorFor(color),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 12),
        _SuggestionRow(
          satisfied: passwordHasUppercase(password),
          text: l10n.onboardingPasswordSuggestUppercase,
        ),
        _SuggestionRow(
          satisfied: passwordHasNumber(password),
          text: l10n.onboardingPasswordSuggestNumber,
        ),
        _SuggestionRow(
          satisfied: passwordHasSpecialChar(password),
          text: l10n.onboardingPasswordSuggestSpecialChar,
        ),
      ],
    );
  }
}

class _SuggestionRow extends StatelessWidget {
  const _SuggestionRow({required this.satisfied, required this.text});

  final bool satisfied;
  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = satisfied ? scheme.outline : scheme.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSwitcher(
            duration: AppMotion.fast,
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: Icon(
              satisfied
                  ? PhosphorIconsFill.checkCircle
                  : PhosphorIconsRegular.circle,
              key: ValueKey(satisfied),
              size: 16,
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
