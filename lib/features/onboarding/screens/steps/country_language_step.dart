import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/app_locale_provider.dart';
import '../../../../core/utils/flag_emoji.dart';
import '../../../../core/utils/localized_text.dart';
import '../../../../data/catalog/available_country.dart';
import '../../../../data/providers/country_catalog_providers.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../providers/onboarding_providers.dart';
import '../../widgets/autocomplete_field.dart';
import '../../widgets/continue_button.dart';

/// A language's English name and its own endonym — e.g. `('Persian',
/// 'فارسی')`. Displayed as "English (endonym)" regardless of the current UI
/// locale, so the field reads the same way a native OS language picker
/// does. Neither half is translated UI copy (an endonym is the language's
/// own name for itself; the English name is a fixed label, not a string
/// that changes per locale), so these aren't ARB entries — the same way a
/// station's own-language name in schema.json isn't re-translated.
const _languageNames = <String, (String english, String native)>{
  'en': ('English', 'English'),
  'fa': ('Persian', 'فارسی'),
};

String _languageDisplayText(String code) {
  final names = _languageNames[code];
  return names == null ? code : '${names.$1} (${names.$2})';
}

/// Step 1: country, then the app's language (pre-filled from the country's
/// official language, but always user-confirmable via Next).
class CountryLanguageStep extends ConsumerWidget {
  const CountryLanguageStep({super.key, required this.onNext});

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    final countries = ref.watch(availableCountriesProvider);
    final state = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);

    final selectedCountry = notifier.selectedCountry;
    final selectedLanguageCode = state.languageCode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.onboardingCountryLanguageStepTitle,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 24),
        AutocompleteField<AvailableCountry>(
          label: l10n.onboardingCountryFieldLabel,
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
          selected: selectedCountry,
          onSelected: (country) => notifier.selectCountry(country.slug),
          noResultsText: l10n.onboardingAutocompleteNoMatches,
        ),
        const SizedBox(height: 16),
        AutocompleteField<String>(
          label: l10n.onboardingLanguageFieldLabel,
          options: const ['en', 'fa'],
          searchableText: (code) => [_languageDisplayText(code), code],
          optionDisplayText: _languageDisplayText,
          selected: selectedLanguageCode,
          onSelected: notifier.selectLanguage,
          noResultsText: l10n.onboardingAutocompleteNoMatches,
        ),
        const Spacer(),
        // A guaranteed minimum gap before the primary action, per design.md's
        // spacing scale (~32dp+ before a field group's button) — on top of
        // whatever slack the Spacer above already contributes.
        const SizedBox(height: 32),
        ContinueButton(
          label: l10n.onboardingContinueButton,
          enabled: selectedCountry != null && selectedLanguageCode != null,
          onPressed: () {
            if (selectedLanguageCode != null) {
              ref.read(appLocaleProvider.notifier).state = Locale(
                selectedLanguageCode,
              );
            }
            onNext();
          },
        ),
      ],
    );
  }
}
