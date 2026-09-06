import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/navigation/fade_scale_page_route.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../widgets/continue_button.dart';
import 'onboarding_flow_screen.dart';

/// One word of [GreetingScreen]'s cycling "hello," paired with the script
/// pairing font it needs (see design.md's Typography section) and its own
/// text direction — set explicitly per word rather than inherited from the
/// ambient locale, since each word is a self-contained script sample, not
/// UI copy that follows the app's current language.
class _GreetingWord {
  const _GreetingWord(this.text, this.fontFamily, this.direction);

  final String text;
  final String fontFamily;
  final TextDirection direction;
}

/// A first-launch multilingual greeting, loosely inspired by (not a copy
/// of) Apple's multi-language boot animation — but built on our own font
/// pairing (Vazirmatn + Inter, see design.md) rather than a system font
/// with broad built-in script coverage. That's also why the word list below
/// is limited to scripts those two fonts actually cover (Persian and
/// Latin-alphabet languages) instead of Apple's much wider script mix —
/// showing a word in a font that lacks its glyphs would just render boxes.
///
/// Cycles through [_words] on a fixed rhythm with a soft cross-fade between
/// each, forever, until the user taps the single "ادامه"/"Continue" button
/// below — which hands off into the onboarding wizard.
class GreetingScreen extends StatefulWidget {
  const GreetingScreen({super.key});

  @override
  State<GreetingScreen> createState() => _GreetingScreenState();
}

class _GreetingScreenState extends State<GreetingScreen> {
  static const _words = [
    _GreetingWord('سلام', AppTheme.persianFontFamily, TextDirection.rtl),
    _GreetingWord('Hello', AppTheme.latinFontFamily, TextDirection.ltr),
    _GreetingWord('Bonjour', AppTheme.latinFontFamily, TextDirection.ltr),
    _GreetingWord('Hola', AppTheme.latinFontFamily, TextDirection.ltr),
    _GreetingWord('Ciao', AppTheme.latinFontFamily, TextDirection.ltr),
    _GreetingWord('Olá', AppTheme.latinFontFamily, TextDirection.ltr),
    _GreetingWord('Hallo', AppTheme.latinFontFamily, TextDirection.ltr),
    _GreetingWord('Merhaba', AppTheme.latinFontFamily, TextDirection.ltr),
  ];

  static const _wordInterval = Duration(milliseconds: 1100);
  static const _crossFadeDuration = Duration(milliseconds: 400);

  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // A word list this short cycling forever is exactly the kind of
    // infinite-repeat ticker `pumpAndSettle()` can't resolve in tests
    // (same issue as the splash screen's PulsingLogo) — tests must use
    // bounded `tester.pump(duration)` instead.
    _timer = Timer.periodic(_wordInterval, (_) {
      setState(() => _index = (_index + 1) % _words.length);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _handleContinue() {
    Navigator.of(
      context,
    ).pushReplacement(fadeScalePageRoute(const OnboardingFlowScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final word = _words[_index];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(flex: 3),
              SizedBox(
                height: 64,
                child: AnimatedSwitcher(
                  duration: _crossFadeDuration,
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeOut,
                  child: Directionality(
                    key: ValueKey(_index),
                    textDirection: word.direction,
                    child: Text(
                      word.text,
                      style: TextStyle(
                        fontFamily: word.fontFamily,
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 4),
              ContinueButton(
                label: l10n.onboardingContinueButton,
                enabled: true,
                onPressed: _handleContinue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
