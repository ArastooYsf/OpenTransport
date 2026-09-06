import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_state.freezed.dart';

/// Step order for the onboarding wizard. [country], [profile], and
/// [password] are the 3 steps shown in the top stepper; [completion] is a
/// final, non-stepper confirmation screen.
enum OnboardingStep { country, profile, password, completion }

/// In-memory state for the onboarding wizard. Deliberately not persisted —
/// there's no backend wired up yet (see CLAUDE.md's `assistant/` layer for
/// the same "stable interface, no real implementation yet" pattern); this
/// just collects what the user entered so the completion step can use it.
@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(OnboardingStep.country) OnboardingStep step,
    String? countrySlug,
    String? languageCode,

    /// Whether the user has ever explicitly picked a language themselves,
    /// as opposed to just receiving the country-derived pre-fill. Once
    /// true, selecting a different country no longer overwrites it.
    @Default(false) bool languageTouchedByUser,
    @Default('') String username,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String email,
    @Default('') String password,
  }) = _OnboardingState;
}
