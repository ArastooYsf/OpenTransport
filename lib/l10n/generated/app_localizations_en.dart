// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'OpenTransport';

  @override
  String get stationListTitle => 'Stations';

  @override
  String interchangeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lines',
      one: '1 line',
    );
    return '$_temp0';
  }

  @override
  String get loadError => 'Couldn\'t load transit data.';

  @override
  String get homeMetroTitle => 'Metro';

  @override
  String get homeMetroSubtitle => 'Lines & stations';

  @override
  String get homeBrtTitle => 'BRT';

  @override
  String get homeBrtComingSoon => 'Coming soon';

  @override
  String get homeSmartTitle => 'Smart';

  @override
  String get homeSmartSubtitle =>
      'The easiest way to any destination or station';

  @override
  String get placeholderComingSoonMessage => 'This section is coming soon.';

  @override
  String get commonConfirm => 'Confirm';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSkipAll => 'Skip all';

  @override
  String onboardingStepIndicator(int step, int total) {
    return 'Step $step of $total';
  }

  @override
  String get onboardingSkipConfirmMessage =>
      'If you skip, that\'s totally fine — you can still use the maps. But without an account you won\'t be able to: save your favorite routes, sync your settings across your devices, or contribute new data to the community.';

  @override
  String get onboardingWithoutAccountTitle => 'Without an account';

  @override
  String get onboardingWithoutAccountIntro =>
      'Without an account, you won\'t be able to:';

  @override
  String get onboardingWithoutAccountBulletSaveRoutes =>
      'Save your favorite routes';

  @override
  String get onboardingWithoutAccountBulletSyncSettings =>
      'Sync your settings across your devices';

  @override
  String get onboardingWithoutAccountBulletContribute =>
      'Add new data to the community';

  @override
  String get onboardingWithoutAccountDismiss => 'Got it';

  @override
  String get onboardingContinueButton => 'Continue';

  @override
  String get onboardingAutocompleteNoMatches => 'No matches found';

  @override
  String get onboardingCountryLanguageStepTitle => 'Country & language';

  @override
  String get onboardingCountryFieldLabel => 'Country';

  @override
  String get onboardingLanguageFieldLabel => 'Language';

  @override
  String get onboardingProfileStepTitle => 'Tell us about yourself';

  @override
  String get onboardingProfileStepSubtitle =>
      'First and last name are optional';

  @override
  String get onboardingUsernameLabel => 'Username';

  @override
  String get onboardingUsernameFormatHint =>
      'English letters, digits, and _ only, 3–20 characters';

  @override
  String get onboardingUsernameTaken => 'This username is already taken';

  @override
  String get onboardingFirstNameLabel => 'First name';

  @override
  String get onboardingLastNameLabel => 'Last name';

  @override
  String get onboardingNamePlausibilityHint =>
      'It\'s better if it has at least one letter';

  @override
  String get onboardingPasswordStepTitle => 'Password';

  @override
  String get onboardingPasswordLabel => 'Password';

  @override
  String get onboardingPasswordMinLengthNote =>
      'It\'s better if it\'s at least 8 characters';

  @override
  String get onboardingPasswordStrengthWeak => 'Weak';

  @override
  String get onboardingPasswordStrengthGood => 'Good';

  @override
  String get onboardingPasswordStrengthStrong => 'Strong';

  @override
  String get onboardingPasswordSuggestUppercase =>
      'It\'s better if it also has an uppercase letter';

  @override
  String get onboardingPasswordSuggestNumber =>
      'It\'s better if it also has a number';

  @override
  String get onboardingPasswordSuggestSpecialChar =>
      'It\'s better if it also has a special character (like !@#\$)';

  @override
  String get onboardingCompletionMessage =>
      '🎉 Welcome! Your account is ready.';

  @override
  String get onboardingTutorialPromptQuestion =>
      'Want to see a quick tour of the app?';

  @override
  String get onboardingTutorialPromptNote =>
      'You can always run this tour again from settings.';

  @override
  String get onboardingTutorialShowButton => 'Show tutorial';

  @override
  String get onboardingTutorialSkipButton => 'Not now';
}
