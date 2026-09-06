import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
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
    final score = passwordExtraCriteriaScore(password);
    final strength = passwordStrengthFor(password);
    final filledSegments = score + 1;

    final (color, label) = switch (strength) {
      PasswordStrength.weak => (
        scheme.error,
        l10n.onboardingPasswordStrengthWeak,
      ),
      PasswordStrength.good => (
        AppTheme.warning,
        l10n.onboardingPasswordStrengthGood,
      ),
      PasswordStrength.strong => (
        AppTheme.success,
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
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
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
        const SizedBox(height: 6),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
          child: Text(label),
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
            duration: const Duration(milliseconds: 200),
            child: Icon(
              satisfied ? Icons.check_circle_rounded : Icons.circle_outlined,
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
