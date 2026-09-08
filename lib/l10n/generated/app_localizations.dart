import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa'),
  ];

  /// The application title, shown in the OS app switcher.
  ///
  /// In en, this message translates to:
  /// **'OpenTransport'**
  String get appTitle;

  /// Title of the screen listing all stations for the loaded city.
  ///
  /// In en, this message translates to:
  /// **'Stations'**
  String get stationListTitle;

  /// Number of lines serving a station, shown on the station row.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 line} other{{count} lines}}'**
  String interchangeCount(int count);

  /// Shown when the bundled city JSON fails to load or parse.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load transit data.'**
  String get loadError;

  /// Home screen option: browse metro lines and stations.
  ///
  /// In en, this message translates to:
  /// **'Metro'**
  String get homeMetroTitle;

  /// Subtitle for the Metro option on the home screen.
  ///
  /// In en, this message translates to:
  /// **'Lines & stations'**
  String get homeMetroSubtitle;

  /// Home screen option: Bus Rapid Transit. Kept as the acronym in every language.
  ///
  /// In en, this message translates to:
  /// **'BRT'**
  String get homeBrtTitle;

  /// Subtitle for the BRT option on the home screen, shown once a city's data actually has BRT lines.
  ///
  /// In en, this message translates to:
  /// **'Bus rapid transit'**
  String get homeBrtSubtitle;

  /// Unused while no bundled city has BRT data yet — kept for when a BRT-only, not-yet-timetabled city needs it.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get homeBrtComingSoon;

  /// Home screen option, shown when a city's data has regular-bus lines.
  ///
  /// In en, this message translates to:
  /// **'Bus'**
  String get homeBusTitle;

  /// Subtitle for the Bus option on the home screen.
  ///
  /// In en, this message translates to:
  /// **'Bus lines & stops'**
  String get homeBusSubtitle;

  /// Home screen option, shown when a city's data has tram lines.
  ///
  /// In en, this message translates to:
  /// **'Tram'**
  String get homeTramTitle;

  /// Subtitle for the Tram option on the home screen.
  ///
  /// In en, this message translates to:
  /// **'Tram lines & stops'**
  String get homeTramSubtitle;

  /// Home screen option, shown when a city's data has commuter-rail lines.
  ///
  /// In en, this message translates to:
  /// **'Commuter rail'**
  String get homeCommuterRailTitle;

  /// Subtitle for the Commuter rail option on the home screen.
  ///
  /// In en, this message translates to:
  /// **'Regional lines & stops'**
  String get homeCommuterRailSubtitle;

  /// Home screen option for a transportType not covered by a more specific tile (schema.json's 'other').
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get homeOtherTransportTitle;

  /// Subtitle for the Other option on the home screen.
  ///
  /// In en, this message translates to:
  /// **'Lines & stops'**
  String get homeOtherTransportSubtitle;

  /// Home screen option: find the easiest way to a destination or station, across all transport types.
  ///
  /// In en, this message translates to:
  /// **'Smart'**
  String get homeSmartTitle;

  /// Subtitle explaining the Smart option on the home screen.
  ///
  /// In en, this message translates to:
  /// **'The easiest way to any destination or station'**
  String get homeSmartSubtitle;

  /// Accessibility label for the home screen's country switcher chip.
  ///
  /// In en, this message translates to:
  /// **'Change country'**
  String get homeCountrySwitcherTooltip;

  /// Accessibility label for the home screen's language switcher chip.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get homeLanguageSwitcherTooltip;

  /// Body text on a placeholder screen for a feature that isn't built yet.
  ///
  /// In en, this message translates to:
  /// **'This section is coming soon.'**
  String get placeholderComingSoonMessage;

  /// Generic confirmation button label in a dialog.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get commonConfirm;

  /// Generic cancel button label in a dialog.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// De-emphasized action to abandon a multi-step flow entirely.
  ///
  /// In en, this message translates to:
  /// **'Skip all'**
  String get commonSkipAll;

  /// Accessibility label for the onboarding progress bar.
  ///
  /// In en, this message translates to:
  /// **'Step {step} of {total}'**
  String onboardingStepIndicator(int step, int total);

  /// Screen-reader label for one step-indicator circle, combining its position with its state.
  ///
  /// In en, this message translates to:
  /// **'Step {step}: {state}'**
  String onboardingStepCircleLabel(int step, String state);

  /// Step-circle state, read out by a screen reader.
  ///
  /// In en, this message translates to:
  /// **'upcoming'**
  String get onboardingStepStateUpcoming;

  /// Step-circle state, read out by a screen reader.
  ///
  /// In en, this message translates to:
  /// **'current'**
  String get onboardingStepStateCurrent;

  /// Step-circle state, read out by a screen reader.
  ///
  /// In en, this message translates to:
  /// **'completed'**
  String get onboardingStepStateCompleted;

  /// Step-circle state, read out by a screen reader.
  ///
  /// In en, this message translates to:
  /// **'incomplete'**
  String get onboardingStepStateSkipped;

  /// Accessibility label for the step-back icon button.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get onboardingBackButtonTooltip;

  /// Screen-reader announcement while the username availability check is in flight.
  ///
  /// In en, this message translates to:
  /// **'Checking availability'**
  String get onboardingUsernameCheckingStatus;

  /// Screen-reader announcement once the username is confirmed available.
  ///
  /// In en, this message translates to:
  /// **'Username available'**
  String get onboardingUsernameAvailableStatus;

  /// Confirmation dialog shown when tapping 'Skip all' during onboarding.
  ///
  /// In en, this message translates to:
  /// **'If you skip, that\'s totally fine — you can still use the maps. But without an account you won\'t be able to: save your favorite routes, sync your settings across your devices, or contribute new data to the community.'**
  String get onboardingSkipConfirmMessage;

  /// Title of the one-time dialog shown after skipping onboarding.
  ///
  /// In en, this message translates to:
  /// **'Without an account'**
  String get onboardingWithoutAccountTitle;

  /// Lead-in line before the bullet list in the post-skip notice dialog.
  ///
  /// In en, this message translates to:
  /// **'Without an account, you won\'t be able to:'**
  String get onboardingWithoutAccountIntro;

  /// Bullet point in the post-skip notice dialog.
  ///
  /// In en, this message translates to:
  /// **'Save your favorite routes'**
  String get onboardingWithoutAccountBulletSaveRoutes;

  /// Bullet point in the post-skip notice dialog.
  ///
  /// In en, this message translates to:
  /// **'Sync your settings across your devices'**
  String get onboardingWithoutAccountBulletSyncSettings;

  /// Bullet point in the post-skip notice dialog.
  ///
  /// In en, this message translates to:
  /// **'Add new data to the community'**
  String get onboardingWithoutAccountBulletContribute;

  /// Dismiss button on the post-skip notice dialog.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get onboardingWithoutAccountDismiss;

  /// The single, full-width primary action at the bottom of every onboarding step.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboardingContinueButton;

  /// Shown in a step-1 dropdown (country or language) when the typed text matches nothing.
  ///
  /// In en, this message translates to:
  /// **'No matches found'**
  String get onboardingAutocompleteNoMatches;

  /// Title of onboarding step 1.
  ///
  /// In en, this message translates to:
  /// **'Country & language'**
  String get onboardingCountryLanguageStepTitle;

  /// Floating label on the country autocomplete field.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get onboardingCountryFieldLabel;

  /// Floating label on the language autocomplete field.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get onboardingLanguageFieldLabel;

  /// Title of onboarding step 2.
  ///
  /// In en, this message translates to:
  /// **'Tell us about yourself'**
  String get onboardingProfileStepTitle;

  /// Subtitle on step 2 — username is required, first/last name are not.
  ///
  /// In en, this message translates to:
  /// **'First and last name are optional'**
  String get onboardingProfileStepSubtitle;

  /// Username field label.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get onboardingUsernameLabel;

  /// Helper/format-error text under the username field.
  ///
  /// In en, this message translates to:
  /// **'English letters, digits, and _ only, 3–20 characters'**
  String get onboardingUsernameFormatHint;

  /// Shown after the duplicate check finds the username is taken.
  ///
  /// In en, this message translates to:
  /// **'This username is already taken'**
  String get onboardingUsernameTaken;

  /// Optional first name field label.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get onboardingFirstNameLabel;

  /// Optional last name field label.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get onboardingLastNameLabel;

  /// Gentle, non-blocking hint for a first/last name that's all digits/symbols.
  ///
  /// In en, this message translates to:
  /// **'It\'s better if it has at least one letter'**
  String get onboardingNamePlausibilityHint;

  /// Title of onboarding step 3.
  ///
  /// In en, this message translates to:
  /// **'Email & password'**
  String get onboardingPasswordStepTitle;

  /// Email field label.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get onboardingEmailLabel;

  /// Error text shown once the email field has been touched and doesn't look like a valid address.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get onboardingEmailInvalid;

  /// Accessibility label for the trailing clear (X) icon on any text field, onboarding or otherwise.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get commonClearFieldTooltip;

  /// Accessibility label for the password field's visibility toggle when the password is currently hidden.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get onboardingShowPasswordTooltip;

  /// Accessibility label for the password field's visibility toggle when the password is currently shown.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get onboardingHidePasswordTooltip;

  /// Password field label.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get onboardingPasswordLabel;

  /// Neutral-toned note shown below 8 characters — the only hard requirement, phrased gently anyway.
  ///
  /// In en, this message translates to:
  /// **'It\'s better if it\'s at least 8 characters'**
  String get onboardingPasswordMinLengthNote;

  /// Strength-meter label: 0-1 extra criteria met.
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get onboardingPasswordStrengthWeak;

  /// Strength-meter label: 2 extra criteria met.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get onboardingPasswordStrengthGood;

  /// Strength-meter label: 3 extra criteria met.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get onboardingPasswordStrengthStrong;

  /// Non-blocking suggestion, not a requirement.
  ///
  /// In en, this message translates to:
  /// **'It\'s better if it also has an uppercase letter'**
  String get onboardingPasswordSuggestUppercase;

  /// Non-blocking suggestion, not a requirement.
  ///
  /// In en, this message translates to:
  /// **'It\'s better if it also has a number'**
  String get onboardingPasswordSuggestNumber;

  /// Non-blocking suggestion, not a requirement.
  ///
  /// In en, this message translates to:
  /// **'It\'s better if it also has a special character (like !@#\$)'**
  String get onboardingPasswordSuggestSpecialChar;

  /// Line 1 of the celebratory completion screen — short, large text.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get onboardingCompletionGreeting;

  /// Question in the post-completion tutorial-offer dialog.
  ///
  /// In en, this message translates to:
  /// **'Want to see a quick tour of the app?'**
  String get onboardingTutorialPromptQuestion;

  /// Smaller reassurance note under the tutorial-offer question.
  ///
  /// In en, this message translates to:
  /// **'You can always run this tour again from settings.'**
  String get onboardingTutorialPromptNote;

  /// Accepts the quick tour offer.
  ///
  /// In en, this message translates to:
  /// **'Show tutorial'**
  String get onboardingTutorialShowButton;

  /// Declines the quick tour offer.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get onboardingTutorialSkipButton;

  /// Main bottom nav bar tab label.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get shellTabHome;

  /// Main bottom nav bar tab label.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get shellTabMap;

  /// Main bottom nav bar tab label.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get shellTabSaved;

  /// Main bottom nav bar tab label.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get shellTabAccount;

  /// Main bottom nav bar tab label.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get shellTabSettings;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fa':
      return AppLocalizationsFa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
