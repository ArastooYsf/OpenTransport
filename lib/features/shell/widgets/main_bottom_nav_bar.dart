import 'package:flutter/material.dart';
import 'package:phosphor_icons/phosphor_icons.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/contrast_color.dart';
import '../../../l10n/generated/app_localizations.dart';

/// The five persistent destinations behind [MainBottomNavBar], in
/// start-to-end order — [Row] and [AnimatedPositionedDirectional] below
/// both resolve against the ambient [Directionality], so this order reads
/// correctly mirrored in RTL without any left/right logic of its own.
enum ShellTab { home, map, saved, account, settings }

/// design.md's Iconography mixed-weight system (outline = inactive,
/// fill = active) plus each tab's accessibility label, kept next to the
/// enum itself so [MainBottomNavBar] and [MainShellScreen] read from one
/// source.
extension ShellTabInfo on ShellTab {
  IconData get outlineIcon => switch (this) {
    ShellTab.home => PhosphorIconsRegular.house,
    ShellTab.map => PhosphorIconsRegular.mapTrifold,
    ShellTab.saved => PhosphorIconsRegular.bookmarkSimple,
    ShellTab.account => PhosphorIconsRegular.user,
    ShellTab.settings => PhosphorIconsRegular.gear,
  };

  IconData get fillIcon => switch (this) {
    ShellTab.home => PhosphorIconsFill.house,
    ShellTab.map => PhosphorIconsFill.mapTrifold,
    ShellTab.saved => PhosphorIconsFill.bookmarkSimple,
    ShellTab.account => PhosphorIconsFill.user,
    ShellTab.settings => PhosphorIconsFill.gear,
  };

  /// Not shown on-screen (this nav bar is icon-only) — read by a screen
  /// reader via each tab's [Semantics] label instead.
  String label(AppLocalizations l10n) => switch (this) {
    ShellTab.home => l10n.shellTabHome,
    ShellTab.map => l10n.shellTabMap,
    ShellTab.saved => l10n.shellTabSaved,
    ShellTab.account => l10n.shellTabAccount,
    ShellTab.settings => l10n.shellTabSettings,
  };
}

/// A floating, icon-only pill nav bar for [MainShellScreen]'s five tabs —
/// margin on every side rather than edge-to-edge, per design.md's Elevation
/// ("floating elements" = Level 3) and Components ("pill-shaped controls")
/// sections. The active tab is shown by a small solid-accent circle sliding
/// behind its icon, not by a label or a full-width highlight.
///
/// Every part of a tab switch — the indicator circle's travel, the
/// newly-active icon's outline→fill crossfade + bounce, and the
/// previously-active icon crossfading back — runs off the same
/// [AppMotion.base] duration so nothing looks like it's lagging or leading
/// the rest; only the immediate press-down/spring-back feedback (felt
/// before a tab is "officially" selected) uses the snappier [AppMotion.fast].
class MainBottomNavBar extends StatelessWidget {
  const MainBottomNavBar({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final ShellTab selected;
  final ValueChanged<ShellTab> onSelected;

  static const _tabs = ShellTab.values;
  static const _barHeight = 60.0;
  static const _indicatorDiameter = 44.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    // Floating above the gesture bar/home indicator on modern devices,
    // rather than sitting flush with the bottom edge.
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, bottomInset + 12),
      child: Material(
        color: colors.surfaceElevated,
        elevation: AppElevation.level3,
        surfaceTintColor: Colors.transparent,
        borderRadius: BorderRadius.circular(999),
        child: SizedBox(
          height: _barHeight,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = constraints.maxWidth / _tabs.length;
              final selectedIndex = _tabs.indexOf(selected);
              const indicatorInset = (_barHeight - _indicatorDiameter) / 2;

              return Stack(
                children: [
                  AnimatedPositionedDirectional(
                    duration: AppMotion.base,
                    curve: AppMotion.curve,
                    top: indicatorInset,
                    start:
                        itemWidth * selectedIndex +
                        (itemWidth - _indicatorDiameter) / 2,
                    width: _indicatorDiameter,
                    height: _indicatorDiameter,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      for (final tab in _tabs)
                        Expanded(
                          child: _NavBarTabItem(
                            tab: tab,
                            isSelected: tab == selected,
                            onTap: () => onSelected(tab),
                          ),
                        ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NavBarTabItem extends StatefulWidget {
  const _NavBarTabItem({
    required this.tab,
    required this.isSelected,
    required this.onTap,
  });

  final ShellTab tab;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_NavBarTabItem> createState() => _NavBarTabItemState();
}

class _NavBarTabItemState extends State<_NavBarTabItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounceController = AnimationController(
    vsync: this,
    duration: AppMotion.base,
  );

  // A true overshoot-and-settle (1.0 -> 1.15 -> 1.0), not a one-way ease
  // into place — the same TweenSequence technique already used for the
  // greeting screen's hand-wave and the onboarding stepper's circle pop.
  late final Animation<double> _bounceScale = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween(
        begin: 1.0,
        end: 1.15,
      ).chain(CurveTween(curve: AppMotion.curve)),
      weight: 45,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 1.15,
        end: 1.0,
      ).chain(CurveTween(curve: AppMotion.curve)),
      weight: 55,
    ),
  ]).animate(_bounceController);

  bool _pressed = false;

  @override
  void didUpdateWidget(covariant _NavBarTabItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Only the tab *becoming* active bounces — the one it replaces just
    // crossfades back (see the AnimatedSwitcher below), per spec.
    if (widget.isSelected && !oldWidget.isSelected) {
      _bounceController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final label = widget.tab.label(l10n);
    // Inactive: plain outline icon in the neutral textSecondary tone.
    // Active: the icon sits *on* the solid-accent indicator circle (drawn
    // behind it by MainBottomNavBar), so it needs the same guaranteed-
    // readable contrast pairing line badges and the stepper's "current"
    // circle already use — not the accent color itself.
    final color = widget.isSelected
        ? readableTextColorFor(colors.accent)
        : colors.textSecondary;

    return Semantics(
      selected: widget.isSelected,
      button: true,
      label: label,
      // InkWell's own semantics are excluded in favor of this single node
      // (with `onTap` repeated below) so a screen reader announces the tab
      // once, with its selected state, rather than twice.
      excludeSemantics: true,
      onTap: widget.onTap,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTheme.cardRadius),
          splashColor: colors.accent.withValues(alpha: 0.15),
          highlightColor: colors.accent.withValues(alpha: 0.08),
          onTap: widget.onTap,
          onTapDown: (_) => _setPressed(true),
          onTapCancel: () => _setPressed(false),
          onTapUp: (_) => _setPressed(false),
          child: AnimatedScale(
            scale: _pressed ? 0.95 : 1.0,
            duration: AppMotion.fast,
            curve: AppMotion.curve,
            child: Center(
              child: ScaleTransition(
                scale: _bounceScale,
                child: AnimatedSwitcher(
                  duration: AppMotion.base,
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: Icon(
                    widget.isSelected
                        ? widget.tab.fillIcon
                        : widget.tab.outlineIcon,
                    key: ValueKey(widget.isSelected),
                    color: color,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
