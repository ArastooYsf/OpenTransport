import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_icons/phosphor_icons.dart';

import '../../../core/widgets/placeholder_screen.dart';
import '../../../data/providers/transit_data_providers.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../onboarding/dialogs/tutorial_prompt_dialog.dart';
import '../../onboarding/dialogs/without_account_notice_dialog.dart';
import '../models/transport_type_info.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/option_card.dart';

/// The app's landing screen: a neutral, brand-colored hub for choosing how
/// to get around — never tied to a specific line color (see design.md,
/// "Map-first" and the color system's line-vs-brand separation).
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    super.key,
    this.showWithoutAccountNotice = false,
    this.showTutorialPrompt = false,
  });

  /// Shows the one-time "here's what you're missing" dialog right after
  /// arriving here from onboarding's "skip all" path.
  final bool showWithoutAccountNotice;

  /// Shows the "want a quick tour?" dialog a beat after arriving here from
  /// a completed (non-skipped) onboarding — deliberately delayed so this
  /// screen registers first before the dialog appears on top of it.
  final bool showTutorialPrompt;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  static const _tutorialPromptDelay = Duration(milliseconds: 700);

  @override
  void initState() {
    super.initState();
    if (widget.showWithoutAccountNotice) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) showWithoutAccountNoticeDialog(context);
      });
    } else if (widget.showTutorialPrompt) {
      Future.delayed(_tutorialPromptDelay, () {
        if (mounted) showTutorialPromptDialog(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // Present in every city regardless of data — Smart is cross-mode by
    // definition, not tied to any one transportType.
    final availableTypes = ref.watch(availableTransportTypesProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeTopBar(),
              const SizedBox(height: 20),
              Text(
                l10n.appTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              OptionCard(
                icon: PhosphorIconsRegular.flowArrow,
                title: l10n.homeSmartTitle,
                subtitle: l10n.homeSmartSubtitle,
                prominent: true,
                onTap: () => _openPlaceholder(
                  context,
                  title: l10n.homeSmartTitle,
                  icon: PhosphorIconsRegular.flowArrow,
                ),
              ),
              if (availableTypes.isNotEmpty) ...[
                const SizedBox(height: 16),
                LayoutBuilder(
                  builder: (context, constraints) {
                    const spacing = 16.0;
                    final tileWidth = (constraints.maxWidth - spacing) / 2;
                    return Wrap(
                      spacing: spacing,
                      runSpacing: spacing,
                      children: [
                        for (final type in availableTypes)
                          SizedBox(
                            width: tileWidth,
                            child: OptionCard(
                              icon: type.icon,
                              title: type.title(l10n),
                              subtitle: type.subtitle(l10n),
                              onTap: () => _openPlaceholder(
                                context,
                                title: type.title(l10n),
                                icon: type.icon,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
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
