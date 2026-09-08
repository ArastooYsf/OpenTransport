import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_icons/phosphor_icons.dart';

import '../../../core/providers/app_locale_provider.dart';
import '../../../core/providers/current_country_provider.dart';
import '../../../core/utils/flag_emoji.dart';
import '../../../core/utils/language_names.dart';
import '../../../core/utils/localized_text.dart';
import '../../../core/widgets/autocomplete_field.dart';
import '../../../data/catalog/available_country.dart';
import '../../../data/providers/country_catalog_providers.dart';
import '../../../l10n/generated/app_localizations.dart';
import 'switcher_chip.dart';

/// Home's country and language quick-switches — each opens the same
/// [AutocompleteField] onboarding's country/language step uses (not a
/// rebuilt picker), in a bottom sheet, and applies the choice immediately
/// via [currentCountryProvider]/[appLocaleProvider] (which persist it —
/// see `PreferencesRepository`) — no separate "save" step.
class HomeTopBar extends ConsumerWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    final country = ref.watch(currentCountryProvider);
    final languageCode = locale.languageCode;

    return Row(
      children: [
        Flexible(
          child: SwitcherChip(
            leading: Text(
              flagEmoji(country.isoCode),
              style: const TextStyle(fontSize: 18),
            ),
            label: resolveLocalizedText(country.name, locale),
            semanticLabel: l10n.homeCountrySwitcherTooltip,
            onTap: () => _showCountryPicker(context, ref),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: SwitcherChip(
            leading: const Icon(PhosphorIconsRegular.translate, size: 18),
            label: languageEndonym(languageCode),
            semanticLabel: l10n.homeLanguageSwitcherTooltip,
            onTap: () => _showLanguagePicker(context, ref, languageCode),
          ),
        ),
      ],
    );
  }

  Future<void> _showCountryPicker(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    final countries = ref.read(availableCountriesProvider);
    final selected = ref.read(currentCountryProvider);

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => _PickerSheet(
        child: AutocompleteField<AvailableCountry>(
          label: l10n.onboardingCountryFieldLabel,
          fieldIcon: PhosphorIconsRegular.globe,
          options: countries,
          searchableText: (country) => [
            ...country.name.values,
            country.isoCode,
          ],
          optionDisplayText: (country) =>
              resolveLocalizedText(country.name, locale),
          optionLeading: (country) => Text(
            flagEmoji(country.isoCode),
            style: const TextStyle(fontSize: 20),
          ),
          selected: selected,
          onSelected: (country) {
            ref.read(currentCountryProvider.notifier).select(country);
            Navigator.of(sheetContext).pop();
          },
          noResultsText: l10n.onboardingAutocompleteNoMatches,
        ),
      ),
    );
  }

  Future<void> _showLanguagePicker(
    BuildContext context,
    WidgetRef ref,
    String currentCode,
  ) async {
    final l10n = AppLocalizations.of(context);

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => _PickerSheet(
        child: AutocompleteField<String>(
          label: l10n.onboardingLanguageFieldLabel,
          fieldIcon: PhosphorIconsRegular.translate,
          options: const ['en', 'fa'],
          searchableText: (code) => [languageDisplayText(code), code],
          optionDisplayText: languageDisplayText,
          selected: currentCode,
          onSelected: (code) {
            ref.read(appLocaleProvider.notifier).select(Locale(code));
            Navigator.of(sheetContext).pop();
          },
          noResultsText: l10n.onboardingAutocompleteNoMatches,
        ),
      ),
    );
  }
}

/// Shared padding/safe-area handling for both picker sheets — keeps the
/// field clear of the on-screen keyboard and the gesture bar.
///
/// [AutocompleteField]'s options dropdown (up to 260dp tall) renders below
/// the field via its own `Overlay` entry, independent of this sheet's own
/// size — a sheet sized to just the field's own ~60dp height would leave
/// the dropdown with nowhere to go but past the visible sheet card, into
/// the dimmed barrier behind it (unreachable/untappable there). Reserving
/// a minimum height up front keeps the whole dropdown inside the sheet.
class _PickerSheet extends StatelessWidget {
  const _PickerSheet({required this.child});

  static const _minContentHeight = 340.0;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.viewInsetsOf(context);
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 20 + viewInsets.bottom + bottomPadding,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: _minContentHeight),
        child: Align(alignment: AlignmentDirectional.topStart, child: child),
      ),
    );
  }
}
