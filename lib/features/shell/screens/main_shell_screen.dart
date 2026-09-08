import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_screen.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../home/screens/home_screen.dart';
import '../../map/screens/map_screen.dart';
import '../widgets/main_bottom_nav_bar.dart';

/// The persistent post-onboarding app shell: [HomeScreen], [MapScreen], and
/// three not-yet-built destinations (Saved, Account, Settings — the same
/// [PlaceholderScreen] pattern Home's own Metro/BRT/Smart options already
/// use), switched between by [MainBottomNavBar].
///
/// An [IndexedStack] keeps every tab's widget subtree alive (not just its
/// state object) even while hidden, so a tab's scroll position or in-flight
/// state survives switching away and back — the standard pattern for a
/// bottom-nav shell.
class MainShellScreen extends StatefulWidget {
  const MainShellScreen({
    super.key,
    this.showWithoutAccountNotice = false,
    this.showTutorialPrompt = false,
  });

  /// Forwarded to the Home tab's [HomeScreen] — see its own docs.
  final bool showWithoutAccountNotice;
  final bool showTutorialPrompt;

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  ShellTab _selected = ShellTab.home;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: IndexedStack(
        index: ShellTab.values.indexOf(_selected),
        children: [
          HomeScreen(
            showWithoutAccountNotice: widget.showWithoutAccountNotice,
            showTutorialPrompt: widget.showTutorialPrompt,
          ),
          const MapScreen(),
          for (final tab in ShellTab.values.skip(2))
            PlaceholderScreen(title: tab.label(l10n), icon: tab.fillIcon),
        ],
      ),
      bottomNavigationBar: MainBottomNavBar(
        selected: _selected,
        onSelected: (tab) => setState(() => _selected = tab),
      ),
    );
  }
}
