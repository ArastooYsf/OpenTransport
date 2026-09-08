import 'package:flutter/material.dart';
import 'package:phosphor_icons/phosphor_icons.dart';

import '../../../core/theme/app_theme.dart';

/// One tappable home-screen destination (Metro, BRT, Smart routing).
///
/// [prominent] renders the larger, accent-tinted "hero" treatment used for
/// the Smart option. [muted] renders the grayed-out, not-ready-yet
/// treatment used for BRT — it's still tappable (see design.md: nothing
/// should feel like a dead end), just visually de-emphasized.
class OptionCard extends StatelessWidget {
  const OptionCard({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.badge,
    this.muted = false,
    this.prominent = false,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final String? badge;
  final bool muted;
  final bool prominent;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final Color background;
    final Color foreground;
    final Color iconBackground;
    final Color iconColor;
    if (prominent) {
      background = scheme.primaryContainer;
      foreground = scheme.onPrimaryContainer;
      iconBackground = scheme.primary.withValues(alpha: 0.14);
      iconColor = scheme.primary;
    } else if (muted) {
      background = scheme.surfaceContainerLow;
      foreground = scheme.onSurfaceVariant;
      iconBackground = scheme.surfaceContainerHighest;
      iconColor = scheme.outline;
    } else {
      background = scheme.surfaceContainerHigh;
      foreground = scheme.onSurface;
      iconBackground = scheme.primary.withValues(alpha: 0.1);
      iconColor = scheme.primary;
    }

    final borderRadius = BorderRadius.circular(AppTheme.cardRadius);
    final iconBadge = Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: iconBackground, shape: BoxShape.circle),
      child: Icon(icon, color: iconColor, size: prominent ? 30 : 26),
    );

    return Material(
      color: background,
      // The card's own background is already a deliberately-tinted role
      // color (primaryContainer / surfaceContainerHigh / -Low, see above),
      // so it carries design.md's dark-mode "lighter surface tint" on its
      // own — an M3 elevation tint on top of that would just muddy it.
      // The shadow below is what actually expresses Level 1 elevation.
      surfaceTintColor: Colors.transparent,
      elevation: AppElevation.level1,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: prominent
              ? _ProminentLayout(
                  iconBadge: iconBadge,
                  title: title,
                  subtitle: subtitle,
                  foreground: foreground,
                  textTheme: textTheme,
                )
              : _RegularLayout(
                  iconBadge: iconBadge,
                  title: title,
                  subtitle: subtitle,
                  badge: badge,
                  foreground: foreground,
                  textTheme: textTheme,
                ),
        ),
      ),
    );
  }
}

class _ProminentLayout extends StatelessWidget {
  const _ProminentLayout({
    required this.iconBadge,
    required this.title,
    required this.subtitle,
    required this.foreground,
    required this.textTheme,
  });

  final Widget iconBadge;
  final String title;
  final String? subtitle;
  final Color foreground;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        iconBadge,
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleLarge?.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(
                    color: foreground.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: 8),
        // Every Phosphor glyph ships with matchTextDirection: true, so
        // Icon auto-mirrors this against the ambient Directionality with
        // no extra plumbing — it always points toward reading-forward.
        Icon(
          PhosphorIconsRegular.caretRight,
          size: 18,
          color: foreground.withValues(alpha: 0.6),
        ),
      ],
    );
  }
}

class _RegularLayout extends StatelessWidget {
  const _RegularLayout({
    required this.iconBadge,
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.foreground,
    required this.textTheme,
  });

  final Widget iconBadge;
  final String title;
  final String? subtitle;
  final String? badge;
  final Color foreground;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        iconBadge,
        const SizedBox(height: 14),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.titleMedium?.copyWith(
            color: foreground,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 2),
          Text(
            subtitle!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodySmall?.copyWith(
              color: foreground.withValues(alpha: 0.75),
            ),
          ),
        ],
        if (badge != null) ...[
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: foreground.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              badge!,
              style: textTheme.labelSmall?.copyWith(color: foreground),
            ),
          ),
        ],
      ],
    );
  }
}
