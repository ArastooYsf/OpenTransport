import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_icons/phosphor_icons.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../providers/onboarding_providers.dart';
import '../../validation.dart';
import '../../widgets/clearable_text_field.dart';
import '../../widgets/continue_button.dart';
import '../../widgets/password_strength_meter.dart';
import '../../widgets/step_back_button.dart';

/// Step 3: email, then password. Both are required to enable Continue —
/// email needs to look like a valid address, password needs to meet the
/// 8-character minimum (the strength meter below it is advisory only).
class EmailPasswordStep extends ConsumerStatefulWidget {
  const EmailPasswordStep({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  ConsumerState<EmailPasswordStep> createState() => _EmailPasswordStepState();
}

class _EmailPasswordStepState extends ConsumerState<EmailPasswordStep> {
  late final _emailController = TextEditingController(
    text: ref.read(onboardingProvider).email,
  );
  late final _passwordController = TextEditingController(
    text: ref.read(onboardingProvider).password,
  );
  bool _obscure = true;
  bool _emailTouched = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final notifier = ref.read(onboardingProvider.notifier);
    final email = ref.watch(onboardingProvider.select((s) => s.email));
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
            // See profile_step.dart's identical fix: a scroll view's
            // default hardEdge clip cuts off the first field's floating
            // label mid-transition without this.
            clipBehavior: Clip.none,
            padding: const EdgeInsets.only(top: 8),
            children: [
              ClearableTextField(
                controller: _emailController,
                labelText: l10n.onboardingEmailLabel,
                leadingIcon: PhosphorIconsRegular.at,
                onChanged: (value) {
                  notifier.updateEmail(value);
                  setState(() => _emailTouched = true);
                },
                errorText: _emailTouched && !isEmailFormatValid(email)
                    ? l10n.onboardingEmailInvalid
                    : null,
              ),
              const SizedBox(height: 16),
              ClearableTextField(
                controller: _passwordController,
                labelText: l10n.onboardingPasswordLabel,
                leadingIcon: PhosphorIconsRegular.lockKey,
                obscureText: _obscure,
                onChanged: notifier.updatePassword,
                helperText: isPasswordLongEnough(password)
                    ? null
                    : l10n.onboardingPasswordMinLengthNote,
                helperMaxLines: 2,
                trailingStatus: IconButton(
                  icon: Icon(
                    _obscure
                        ? PhosphorIconsRegular.eye
                        : PhosphorIconsRegular.eyeSlash,
                  ),
                  tooltip: _obscure
                      ? l10n.onboardingShowPasswordTooltip
                      : l10n.onboardingHidePasswordTooltip,
                  onPressed: () => setState(() => _obscure = !_obscure),
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
          enabled: isEmailFormatValid(email) && isPasswordLongEnough(password),
          onPressed: widget.onNext,
        ),
      ],
    );
  }
}
