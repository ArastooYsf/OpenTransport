import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_screen.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../onboarding/dialogs/without_account_notice_dialog.dart';
import '../widgets/option_card.dart';

/// The app's landing screen: a neutral, brand-colored hub for choosing how
/// to get around — never tied to a specific line color (see design.md,
/// "Map-first" and the color system's line-vs-brand separation).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.showWithoutAccountNotice = false});

  /// Shows the one-time "here's what you're missing" dialog right after
  /// arriving here from onboarding's "skip all" path.
  final bool showWithoutAccountNotice;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.showWithoutAccountNotice) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) showWithoutAccountNoticeDialog(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.appTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              OptionCard(
                icon: Icons.alt_route_rounded,
                title: l10n.homeSmartTitle,
                subtitle: l10n.homeSmartSubtitle,
                prominent: true,
                onTap: () => _openPlaceholder(
                  context,
                  title: l10n.homeSmartTitle,
                  icon: Icons.alt_route_rounded,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: OptionCard(
                      icon: Icons.train_rounded,
                      title: l10n.homeMetroTitle,
                      subtitle: l10n.homeMetroSubtitle,
                      onTap: () => _openPlaceholder(
                        context,
                        title: l10n.homeMetroTitle,
                        icon: Icons.train_rounded,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OptionCard(
                      icon: Icons.directions_bus_filled_rounded,
                      title: l10n.homeBrtTitle,
                      badge: l10n.homeBrtComingSoon,
                      muted: true,
                      onTap: () => _openPlaceholder(
                        context,
                        title: l10n.homeBrtTitle,
                        icon: Icons.directions_bus_filled_rounded,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openPlaceholder(
    BuildContext context, {
    required String title,
    required IconData icon,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlaceholderScreen(title: title, icon: icon),
      ),
    );
  }
}
