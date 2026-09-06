import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/catalog/available_countries.dart';
import '../../../data/catalog/available_country.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../models/onboarding_state.dart';
import '../validation.dart';

/// The number of steps shown in the top stepper — [OnboardingStep.country],
/// [OnboardingStep.profile], and [OnboardingStep.password].
/// [OnboardingStep.completion] is a final screen outside the stepper.
const stepperStepCount = 3;

/// Drives the onboarding wizard: current step, and everything the user has
/// entered so far.
class OnboardingNotifier extends Notifier<OnboardingState> {
  @override
  OnboardingState build() => const OnboardingState();

  void selectCountry(String slug) {
    state = state.copyWith(countrySlug: slug);
    if (!state.languageTouchedByUser) {
      state = state.copyWith(
        languageCode: preselectedLanguage(selectedCountry),
      );
    }
  }

  void selectLanguage(String languageCode) {
    state = state.copyWith(
      languageCode: languageCode,
      languageTouchedByUser: true,
    );
  }

  void updateProfile({String? username, String? firstName, String? lastName}) {
    state = state.copyWith(
      username: username ?? state.username,
      firstName: firstName ?? state.firstName,
      lastName: lastName ?? state.lastName,
    );
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void next() {
    final steps = OnboardingStep.values;
    final currentIndex = steps.indexOf(state.step);
    if (currentIndex >= steps.length - 1) return;
    state = state.copyWith(step: steps[currentIndex + 1]);
  }

  void back() {
    final steps = OnboardingStep.values;
    final currentIndex = steps.indexOf(state.step);
    if (currentIndex <= 0) return;
    state = state.copyWith(step: steps[currentIndex - 1]);
  }

  AvailableCountry? get selectedCountry {
    final slug = state.countrySlug;
    if (slug == null) return null;
    for (final country in availableCountries) {
      if (country.slug == slug) return country;
    }
    return null;
  }
}

/// The language to default the language field to: the [country]'s official
/// language, if the app supports it — otherwise English.
String preselectedLanguage(AvailableCountry? country) {
  final officialCode = country?.officialLanguageCode;
  final supportedCodes = AppLocalizations.supportedLocales.map(
    (locale) => locale.languageCode,
  );
  if (officialCode != null && supportedCodes.contains(officialCode)) {
    return officialCode;
  }
  return 'en';
}

/// How "filled in" a given stepper step (0=country, 1=profile, 2=password)
/// is, as a 0.0–1.0 fraction — used both to animate the stepper's
/// connecting line continuously (not just jump per step) and to decide
/// whether a completed step should show as "completed" or
/// "skipped/incomplete".
double stepFillFraction(OnboardingState state, int stepIndex) {
  switch (stepIndex) {
    case 0:
      final filled = [
        state.countrySlug != null,
        state.languageCode != null,
      ].where((ok) => ok).length;
      return filled / 2;
    case 1:
      final filled = [
        isUsernameFormatValid(state.username),
        state.firstName.trim().isNotEmpty,
        state.lastName.trim().isNotEmpty,
      ].where((ok) => ok).length;
      return filled / 3;
    case 2:
      final filled = [
        isEmailFormatValid(state.email),
        isPasswordLongEnough(state.password),
      ].where((ok) => ok).length;
      return filled / 2;
    default:
      return 1;
  }
}

/// How filled the connecting-line segment between circle [segmentIndex] and
/// circle `segmentIndex + 1` should be, as a 0.0–1.0 fraction of that one
/// segment (not the whole line — each step owns its own segment):
/// fully filled for a step already passed, empty for one not reached yet,
/// and — for the segment belonging to the current step — exactly
/// [stepFillFraction], so it fills in place as the user fills in fields,
/// not in one jump when the step changes.
double segmentFillFraction(OnboardingState state, int segmentIndex) {
  final currentIndex = OnboardingStep.values.indexOf(state.step);
  if (segmentIndex < currentIndex) return 1;
  if (segmentIndex == currentIndex) {
    return stepFillFraction(state, segmentIndex);
  }
  return 0;
}

enum StepCircleState { upcoming, current, completed, skippedIncomplete }

StepCircleState stepCircleStateFor(OnboardingState state, int circleIndex) {
  final currentIndex = OnboardingStep.values.indexOf(state.step);
  if (circleIndex > currentIndex) return StepCircleState.upcoming;
  if (circleIndex == currentIndex) return StepCircleState.current;
  final fullyComplete = stepFillFraction(state, circleIndex) >= 1.0;
  return fullyComplete
      ? StepCircleState.completed
      : StepCircleState.skippedIncomplete;
}

final onboardingProvider =
    NotifierProvider<OnboardingNotifier, OnboardingState>(
      OnboardingNotifier.new,
    );
