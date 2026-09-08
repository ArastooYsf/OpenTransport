import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_icons/phosphor_icons.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../data/providers/username_availability_providers.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../providers/onboarding_providers.dart';
import '../../validation.dart';
import '../../widgets/clearable_text_field.dart';
import '../../widgets/continue_button.dart';
import '../../widgets/step_back_button.dart';

enum _UsernameStatus { idle, invalidFormat, checking, available, taken }

/// Step 2: username (required — format-validated and checked for
/// duplicates), then first/last name (optional, plausibility-checked only,
/// never blocking).
class ProfileStep extends ConsumerStatefulWidget {
  const ProfileStep({super.key, required this.onNext, required this.onBack});

  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  ConsumerState<ProfileStep> createState() => _ProfileStepState();
}

class _ProfileStepState extends ConsumerState<ProfileStep> {
  late final _usernameController = TextEditingController(
    text: ref.read(onboardingProvider).username,
  );
  late final _firstNameController = TextEditingController(
    text: ref.read(onboardingProvider).firstName,
  );
  late final _lastNameController = TextEditingController(
    text: ref.read(onboardingProvider).lastName,
  );

  _UsernameStatus _usernameStatus = _UsernameStatus.idle;
  Timer? _debounce;
  int _checkGeneration = 0;
  bool _firstNameTouched = false;
  bool _lastNameTouched = false;

  @override
  void initState() {
    super.initState();
    // Restore a proper status if returning to this step with a value
    // already filled in, rather than showing nothing.
    if (_usernameController.text.isNotEmpty) {
      _onUsernameChanged(_usernameController.text, debounce: false);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _onUsernameChanged(String value, {bool debounce = true}) {
    ref.read(onboardingProvider.notifier).updateProfile(username: value);
    _debounce?.cancel();

    if (value.isEmpty) {
      setState(() => _usernameStatus = _UsernameStatus.idle);
      return;
    }
    if (!isUsernameFormatValid(value)) {
      setState(() => _usernameStatus = _UsernameStatus.invalidFormat);
      return;
    }

    final generation = ++_checkGeneration;
    void runCheck() async {
      setState(() => _usernameStatus = _UsernameStatus.checking);
      final repository = ref.read(usernameAvailabilityRepositoryProvider);
      final isTaken = await repository.isTaken(value);
      if (!mounted || generation != _checkGeneration) return;
      setState(() {
        _usernameStatus = isTaken
            ? _UsernameStatus.taken
            : _UsernameStatus.available;
      });
    }

    if (debounce) {
      _debounce = Timer(const Duration(milliseconds: 500), runCheck);
    } else {
      runCheck();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final notifier = ref.read(onboardingProvider.notifier);
    final firstName = ref.watch(onboardingProvider.select((s) => s.firstName));
    final lastName = ref.watch(onboardingProvider.select((s) => s.lastName));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StepBackButton(onPressed: widget.onBack),
        Text(
          l10n.onboardingProfileStepTitle,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.onboardingProfileStepSubtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView(
            // Clip.none + a little top padding: the OutlineInputBorder's
            // floating label transition briefly overshoots the field's own
            // top edge, and a scroll view's default hardEdge clip cuts that
            // off right at the viewport boundary for whichever field sits
            // first — this only ever showed up on ListView-based steps.
            clipBehavior: Clip.none,
            padding: const EdgeInsets.only(top: 8),
            children: [
              ClearableTextField(
                controller: _usernameController,
                labelText: l10n.onboardingUsernameLabel,
                leadingIcon: PhosphorIconsRegular.user,
                helperText: l10n.onboardingUsernameFormatHint,
                onChanged: _onUsernameChanged,
                trailingStatus: _UsernameStatusIcon(status: _usernameStatus),
                errorText: switch (_usernameStatus) {
                  _UsernameStatus.invalidFormat =>
                    l10n.onboardingUsernameFormatHint,
                  _UsernameStatus.taken => l10n.onboardingUsernameTaken,
                  _ => null,
                },
              ),
              const SizedBox(height: 16),
              ClearableTextField(
                controller: _firstNameController,
                labelText: l10n.onboardingFirstNameLabel,
                leadingIcon: PhosphorIconsRegular.user,
                onChanged: (value) {
                  notifier.updateProfile(firstName: value);
                  setState(() => _firstNameTouched = true);
                },
                errorText:
                    _firstNameTouched && !looksLikePlausibleName(firstName)
                    ? l10n.onboardingNamePlausibilityHint
                    : null,
              ),
              const SizedBox(height: 16),
              ClearableTextField(
                controller: _lastNameController,
                labelText: l10n.onboardingLastNameLabel,
                leadingIcon: PhosphorIconsRegular.user,
                onChanged: (value) {
                  notifier.updateProfile(lastName: value);
                  setState(() => _lastNameTouched = true);
                },
                errorText: _lastNameTouched && !looksLikePlausibleName(lastName)
                    ? l10n.onboardingNamePlausibilityHint
                    : null,
              ),
            ],
          ),
        ),
        // A guaranteed minimum gap before the primary action, per
        // design.md's spacing scale (~32dp+, noticeably more than the
        // 16dp between fields above) so it reads as separate and final.
        const SizedBox(height: 32),
        ContinueButton(
          label: l10n.onboardingContinueButton,
          enabled: _usernameStatus == _UsernameStatus.available,
          onPressed: widget.onNext,
        ),
      ],
    );
  }
}

class _UsernameStatusIcon extends StatelessWidget {
  const _UsernameStatusIcon({required this.status});

  final _UsernameStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    // Screen-reader announcement for the two states that have no other
    // accessible surface — "taken"/"invalidFormat" already reach a screen
    // reader via the field's own errorText below.
    final String? liveAnnouncement = switch (status) {
      _UsernameStatus.checking => l10n.onboardingUsernameCheckingStatus,
      _UsernameStatus.available => l10n.onboardingUsernameAvailableStatus,
      _UsernameStatus.taken ||
      _UsernameStatus.invalidFormat ||
      _UsernameStatus.idle => null,
    };

    final child = switch (status) {
      _UsernameStatus.checking => const Padding(
        key: ValueKey('checking'),
        padding: EdgeInsets.all(14),
        child: SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      _UsernameStatus.available => Icon(
        key: const ValueKey('available'),
        PhosphorIconsFill.checkCircle,
        color: scheme.primary,
      ),
      _UsernameStatus.taken || _UsernameStatus.invalidFormat => Icon(
        key: const ValueKey('rejected'),
        PhosphorIconsFill.xCircle,
        color: scheme.error,
      ),
      _UsernameStatus.idle => const SizedBox.shrink(key: ValueKey('idle')),
    };

    return Semantics(
      liveRegion: liveAnnouncement != null,
      label: liveAnnouncement,
      child: AnimatedSwitcher(
        duration: AppMotion.fast,
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: FadeTransition(opacity: animation, child: child),
        ),
        child: child,
      ),
    );
  }
}
