import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../providers/onboarding_providers.dart';
import '../../validation.dart';
import '../../widgets/continue_button.dart';
import '../../widgets/password_strength_meter.dart';
import '../../widgets/step_back_button.dart';

/// Step 3: password. Only the 8-character minimum blocks Continue — the
/// strength meter and its suggestions are friendly advice, not gates.
class PasswordStep extends ConsumerStatefulWidget {
  const PasswordStep({super.key, required this.onNext, required this.onBack});

  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  ConsumerState<PasswordStep> createState() => _PasswordStepState();
}

class _PasswordStepState extends ConsumerState<PasswordStep> {
  late final _controller = TextEditingController(
    text: ref.read(onboardingProvider).password,
  );
  bool _obscure = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final notifier = ref.read(onboardingProvider.notifier);
    final password = ref.watch(onboardingProvider.select((s) => s.password));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StepBackButton(onPressed: widget.onBack),
        Text(
          l10n.onboardingPasswordStepTitle,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView(
            children: [
              TextField(
                controller: _controller,
                obscureText: _obscure,
                onChanged: notifier.updatePassword,
                decoration: InputDecoration(
                  labelText: l10n.onboardingPasswordLabel,
                  helperText: isPasswordLongEnough(password)
                      ? null
                      : l10n.onboardingPasswordMinLengthNote,
                  helperMaxLines: 2,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscure
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              PasswordStrengthMeter(password: password),
            ],
          ),
        ),
        // A guaranteed minimum gap before the primary action, per
        // design.md's spacing scale (~32dp+) so it reads as separate and
        // final rather than another item in the stack.
        const SizedBox(height: 32),
        ContinueButton(
          label: l10n.onboardingContinueButton,
          enabled: isPasswordLongEnough(password),
          onPressed: widget.onNext,
        ),
      ],
    );
  }
}
