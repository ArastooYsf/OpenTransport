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
/// Every part of a tab switch — the indicator's liquid travel, the
/// newly-active icon's outline→fill crossfade + bounce, and the
/// previously-active icon crossfading back — runs off the same
/// [AppMotion.base] duration so nothing looks like it's lagging or leading
/// the rest; only the immediate press-down/spring-back feedback (felt
/// before a tab is "officially" selected) uses the snappier [AppMotion.fast].
class MainBottomNavBar extends StatefulWidget {
  const MainBottomNavBar({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final ShellTab selected;
  final ValueChanged<ShellTab> onSelected;

  static const tabs = ShellTab.values;
  static const barHeight = 60.0;
  static const indicatorDiameter = 44.0;

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar>
    with SingleTickerProviderStateMixin {
  // How much wider than its resting diameter the indicator stretches to at
  // its most elongated, mid-travel — "20-30% wider... not more."
  static const _peakWidthFactor = 1.25;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppMotion.base,
    // Starts "at rest" (t=1) so the very first build doesn't play a
    // travel animation from nothing into the initially-selected tab.
    value: 1,
  );

  // The indicator's horizontal position, expressed as a continuous tab
  // *index* (e.g. 1.6 = 60% of the way from tab 1 to tab 2) rather than a
  // pixel offset, so it stays correct across rebuilds/resizes without
  // needing to cache item width between them — the pixel conversion
  // happens fresh at paint time in `build`.
  //
  // `Curves.easeOutBack` gives the travel itself the lead/lag feel: it
  // overshoots past the destination index before settling, so the
  // indicator's *center* arrives a beat later than a linear tween would,
  // while the width tween below (peaking early, independently) is what
  // actually reads as the leading edge racing ahead.
  late Animation<double> _indexAnimation = AlwaysStoppedAnimation(
    MainBottomNavBar.tabs.indexOf(widget.selected).toDouble(),
  );

  // Rest -> stretched (fast, first 40%) -> rest with a spring-like
  // overshoot-and-settle (remaining 60%) — a width *factor* against
  // [MainBottomNavBar.indicatorDiameter], not a pixel value, for the same
  // resize-safety reason as the index animation above.
  late Animation<double> _widthFactorAnimation = const AlwaysStoppedAnimation(
    1.0,
  );

  @override
  void didUpdateWidget(covariant MainBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected == widget.selected) return;

    final fromIndex = MainBottomNavBar.tabs.indexOf(oldWidget.selected);
    final toIndex = MainBottomNavBar.tabs.indexOf(widget.selected);

    _indexAnimation = Tween<double>(
      begin: fromIndex.toDouble(),
      end: toIndex.toDouble(),
    ).chain(CurveTween(curve: Curves.easeOutBack)).animate(_controller);

    _widthFactorAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: _peakWidthFactor,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: _peakWidthFactor,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 60,
      ),
    ]).animate(_controller);

    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
          height: MainBottomNavBar.barHeight,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth =
                  constraints.maxWidth / MainBottomNavBar.tabs.length;
              const indicatorTop =
                  (MainBottomNavBar.barHeight -
                      MainBottomNavBar.indicatorDiameter) /
                  2;

              return Stack(
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      final width =
                          MainBottomNavBar.indicatorDiameter *
                          _widthFactorAnimation.value;
                      final centerX = itemWidth * (_indexAnimation.value + 0.5);

                      return PositionedDirectional(
                        top: indicatorTop,
                        start: centerX - width / 2,
                        width: width,
                        height: MainBottomNavBar.indicatorDiameter,
                        child: child!,
                      );
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.accent,
                        // BoxShape.circle paints an ellipse inscribed in
                        // whatever box it's given — exactly the "soft
                        // blob" look wanted here as width and height
                        // diverge mid-travel, with no shape-switching
                        // needed.
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      for (final tab in MainBottomNavBar.tabs)
                        Expanded(
                          child: _NavBarTabItem(
                            tab: tab,
                            isSelected: tab == widget.selected,
                            onTap: () => widget.onSelected(tab),
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
      // A plain GestureDetector, not InkWell/Material — no ripple, no
      // splash, no press-highlight color at all. The only visible press
      // feedback is the AnimatedScale below; the only "selected" feedback
      // is the indicator circle and icon crossfade MainBottomNavBar/this
      // widget already draw.
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
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
    );
  }
}
