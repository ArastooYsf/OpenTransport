import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/navigation/fade_scale_page_route.dart';
import '../../home/screens/home_screen.dart';
import '../dialogs/skip_all_confirm_dialog.dart';
import '../models/onboarding_state.dart';
import '../providers/onboarding_providers.dart';
import '../widgets/onboarding_scaffold.dart';
import '../widgets/onboarding_step_transition.dart';
import 'steps/completion_step.dart';
import 'steps/country_language_step.dart';
import 'steps/password_step.dart';
import 'steps/profile_step.dart';

/// Hosts the first-launch onboarding wizard: owns step navigation, the
/// "skip all" confirmation chain, and the hand-off to [HomeScreen].
class OnboardingFlowScreen extends ConsumerStatefulWidget {
  const OnboardingFlowScreen({super.key});

  @override
  ConsumerState<OnboardingFlowScreen> createState() =>
      _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends ConsumerState<OnboardingFlowScreen> {
  bool _isForward = true;

  void _goNext() {
    setState(() => _isForward = true);
    ref.read(onboardingProvider.notifier).next();
  }

  void _goBack() {
    setState(() => _isForward = false);
    ref.read(onboardingProvider.notifier).back();
  }

  void _goHome({
    bool showWithoutAccountNotice = false,
    bool showTutorialPrompt = false,
  }) {
    Navigator.of(context).pushReplacement(
      fadeScalePageRoute(
        HomeScreen(
          showWithoutAccountNotice: showWithoutAccountNotice,
          showTutorialPrompt: showTutorialPrompt,
        ),
      ),
    );
  }

  Future<void> _handleSkipAll() async {
    final confirmed = await showSkipAllConfirmDialog(context);
    if (confirmed == true && mounted) {
      _goHome(showWithoutAccountNotice: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingProvider);
    final step = state.step;
    final stepIndex = OnboardingStep.values.indexOf(step);

    return OnboardingScaffold(
      stepIndex: stepIndex,
      onSkipAll: _handleSkipAll,
      child: OnboardingStepTransition(
        isForward: _isForward,
        child: KeyedSubtree(key: ValueKey(step), child: _buildStep(step)),
      ),
    );
  }

  Widget _buildStep(OnboardingStep step) {
    switch (step) {
      case OnboardingStep.country:
        return CountryLanguageStep(onNext: _goNext);
      case OnboardingStep.profile:
        return ProfileStep(onNext: _goNext, onBack: _goBack);
      case OnboardingStep.password:
        return PasswordStep(onNext: _goNext, onBack: _goBack);
      case OnboardingStep.completion:
        return CompletionStep(
          onFinished: () => _goHome(showTutorialPrompt: true),
        );
    }
  }
}
