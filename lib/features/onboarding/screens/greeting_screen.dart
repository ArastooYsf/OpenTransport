import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/navigation/fade_scale_page_route.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../widgets/continue_button.dart';
import 'onboarding_flow_screen.dart';

/// One word of [GreetingScreen]'s cycling greeting, paired with the script
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

/// A first-launch multilingual greeting, closely following the mechanics
/// and pacing of Apple's multi-language boot animation (plain centered
/// background, one large word at a time, snappy overlapping crossfades) —
/// built with Flutter's own animation APIs and our own font pairing
/// (Shabnam FD + Rubik, see design.md) rather than copying any Apple asset
/// or code. The word list is limited to scripts those two fonts actually
/// cover (Persian and Latin-alphabet languages) instead of Apple's much
/// wider script mix — showing a word in a font that lacks its glyphs would
/// just render boxes.
///
/// Cycles through [_words] forever, each one crossfading directly into the
/// next (no gap of empty background), with a waving-hand flourish playing
/// concurrently the whole time. The "ادامه"/"Continue" button is enabled
/// from the first frame — this is a decorative brand moment, not a gate.
class GreetingScreen extends StatefulWidget {
  const GreetingScreen({super.key});

  @override
  State<GreetingScreen> createState() => _GreetingScreenState();
}

class _GreetingScreenState extends State<GreetingScreen>
    with TickerProviderStateMixin {
  static const _words = [
    _GreetingWord('سلام', AppTheme.persianFontFamily, TextDirection.rtl),
    _GreetingWord('Hello', AppTheme.latinFontFamily, TextDirection.ltr),
    _GreetingWord('Bonjour', AppTheme.latinFontFamily, TextDirection.ltr),
    _GreetingWord('Hola', AppTheme.latinFontFamily, TextDirection.ltr),
    _GreetingWord('Ciao', AppTheme.latinFontFamily, TextDirection.ltr),
  ];

  // Snappy and continuous, per Apple's actual pacing: each word gets one
  // cycle (hold + the crossfade into the next), not a lingering hold.
  static const _crossFadeDuration = Duration(milliseconds: 180);
  static const _wordCycleInterval = Duration(milliseconds: 800);

  // The hand-wave gesture itself (a few quick overshooting swings) plus a
  // pause before it repeats — bundled into one repeating controller so it
  // keeps playing concurrently for as long as the greeting is on screen,
  // Telegram-big-emoji energy rather than a slow sway.
  static const _waveSwingDuration = Duration(milliseconds: 690);
  static const _wavePause = Duration(milliseconds: 2400);

  Timer? _wordTimer;
  int _wordIndex = 0;

  late final AnimationController _waveController = AnimationController(
    vsync: this,
    duration: _waveSwingDuration + _wavePause,
  )..repeat();

  late final Animation<double> _waveAngleDegrees = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween(
        begin: 0.0,
        end: 20.0,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 200,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 20.0,
        end: -18.0,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 180,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: -18.0,
        end: 12.0,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 160,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 12.0,
        end: 0.0,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 150,
    ),
    // Rest at 0° until the next repeat — the pause between waves.
    TweenSequenceItem(
      tween: ConstantTween(0.0),
      weight: _wavePause.inMilliseconds.toDouble(),
    ),
  ]).animate(_waveController);

  @override
  void initState() {
    super.initState();
    // An infinite-repeat Timer/AnimationController pair — same as
    // PulsingLogo on the splash screen — so widget tests must use bounded
    // `tester.pump(duration)`, never pumpAndSettle.
    _wordTimer = Timer.periodic(_wordCycleInterval, (_) {
      setState(() => _wordIndex = (_wordIndex + 1) % _words.length);
    });
  }

  @override
  void dispose() {
    _wordTimer?.cancel();
    _waveController.dispose();
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
    final word = _words[_wordIndex];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(flex: 3),
              AnimatedSwitcher(
                duration: _crossFadeDuration,
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                // The default transitionBuilder already fades the outgoing
                // and incoming children simultaneously over the same
                // window — exactly the "next word's fade-in overlaps the
                // current word's fade-out" behavior, no dead gap.
                child: Directionality(
                  key: ValueKey(_wordIndex),
                  textDirection: word.direction,
                  child: Text(
                    word.text,
                    style: TextStyle(
                      fontFamily: word.fontFamily,
                      fontSize: 48,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              AnimatedBuilder(
                animation: _waveAngleDegrees,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _waveAngleDegrees.value * math.pi / 180,
                    alignment: AlignmentDirectional.bottomCenter.resolve(
                      Directionality.of(context),
                    ),
                    child: child,
                  );
                },
                child: const Text('👋', style: TextStyle(fontSize: 40)),
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
