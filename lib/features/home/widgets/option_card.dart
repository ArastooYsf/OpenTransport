import 'package:flutter/material.dart';

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

    final borderRadius = BorderRadius.circular(20);
    final iconBadge = Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: iconBackground, shape: BoxShape.circle),
      child: Icon(icon, color: iconColor, size: prominent ? 30 : 26),
    );

    return Material(
      color: background,
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
                style: textTheme.titleLarge?.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: textTheme.bodyMedium?.copyWith(
                    color: foreground.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: 8),
        Icon(
          Icons.arrow_forward_ios_rounded,
          size: 18,
          color: foreground.withValues(alpha: 0.6),
          // Auto-mirrors so it always points toward reading-forward, in
          // both LTR and RTL, without any manual left/right logic.
          textDirection: Directionality.of(context),
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
          style: textTheme.titleMedium?.copyWith(
            color: foreground,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 2),
          Text(
            subtitle!,
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
