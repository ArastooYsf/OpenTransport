import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_transport/data/catalog/available_country.dart';
import 'package:open_transport/features/onboarding/models/onboarding_state.dart';
import 'package:open_transport/features/onboarding/providers/onboarding_providers.dart';

void main() {
  group('preselectedLanguage', () {
    test("picks the country's official language when supported", () {
      const iran = AvailableCountry(
        slug: 'iran',
        isoCode: 'IR',
        name: {'fa': 'ایران', 'en': 'Iran'},
        officialLanguageCode: 'fa',
      );
      expect(preselectedLanguage(iran), 'fa');
    });

    test('falls back to English when the official language is unsupported', () {
      const hypothetical = AvailableCountry(
        slug: 'hypothetical',
        isoCode: 'XX',
        name: {'en': 'Hypothetical'},
        officialLanguageCode: 'xx',
      );
      expect(preselectedLanguage(hypothetical), 'en');
    });

    test('falls back to English when no country is selected', () {
      expect(preselectedLanguage(null), 'en');
    });
  });

  group('OnboardingNotifier', () {
    test('selecting a country immediately pre-fills the language', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(onboardingProvider.notifier);

      notifier.selectCountry('iran');

      expect(container.read(onboardingProvider).languageCode, 'fa');
    });

    test('an explicit language choice survives re-selecting the country', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(onboardingProvider.notifier);

      notifier.selectCountry('iran');
      notifier.selectLanguage('en'); // user overrides the pre-fill
      notifier.selectCountry('iran'); // re-picking the same country

      expect(container.read(onboardingProvider).languageCode, 'en');
    });
  });

  group('stepFillFraction', () {
    test('step 0 is 0, 0.5, or 1 depending on how many fields are set', () {
      const empty = OnboardingState();
      const countryOnly = OnboardingState(countrySlug: 'iran');
      const both = OnboardingState(countrySlug: 'iran', languageCode: 'fa');

      expect(stepFillFraction(empty, 0), 0);
      expect(stepFillFraction(countryOnly, 0), 0.5);
      expect(stepFillFraction(both, 0), 1);
    });

    test('step 1 counts username format validity plus both names', () {
      const usernameOnly = OnboardingState(username: 'arastoo1');
      const usernameAndFirst = OnboardingState(
        username: 'arastoo1',
        firstName: 'Arastoo',
      );
      const allThree = OnboardingState(
        username: 'arastoo1',
        firstName: 'Arastoo',
        lastName: 'Yousefi',
      );

      expect(stepFillFraction(usernameOnly, 1), closeTo(1 / 3, 0.001));
      expect(stepFillFraction(usernameAndFirst, 1), closeTo(2 / 3, 0.001));
      expect(stepFillFraction(allThree, 1), 1);
    });

    test('step 2 counts a valid email plus a long-enough password', () {
      expect(stepFillFraction(const OnboardingState(), 2), 0);
      expect(stepFillFraction(const OnboardingState(email: 'a@b.com'), 2), 0.5);
      expect(
        stepFillFraction(const OnboardingState(password: 'abcdefgh'), 2),
        0.5,
      );
      expect(
        stepFillFraction(
          const OnboardingState(email: 'a@b.com', password: 'abcdefgh'),
          2,
        ),
        1,
      );
    });
  });

  group('stepCircleStateFor', () {
    test('a future step is upcoming', () {
      const state = OnboardingState();
      expect(stepCircleStateFor(state, 1), StepCircleState.upcoming);
    });

    test('the active step is current', () {
      const state = OnboardingState(step: OnboardingStep.profile);
      expect(stepCircleStateFor(state, 1), StepCircleState.current);
    });

    test('a fully-filled past step is completed', () {
      const state = OnboardingState(
        step: OnboardingStep.password,
        username: 'arastoo1',
        firstName: 'Arastoo',
        lastName: 'Yousefi',
      );
      expect(stepCircleStateFor(state, 1), StepCircleState.completed);
    });

    test(
      'a past step left with optional fields empty is skipped/incomplete',
      () {
        const state = OnboardingState(
          step: OnboardingStep.password,
          username: 'arastoo1',
          // firstName/lastName left blank — valid to proceed, but not
          // "complete".
        );
        expect(stepCircleStateFor(state, 1), StepCircleState.skippedIncomplete);
      },
    );
  });
}
