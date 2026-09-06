import 'package:flutter/material.dart';

import '../../../core/navigation/fade_scale_page_route.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../widgets/continue_button.dart';
import 'onboarding_flow_screen.dart';

/// One word of [GreetingScreen]'s sequence, paired with the script pairing
/// font it needs (see design.md's Typography section) and its own text
/// direction — set explicitly per word rather than inherited from the
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
/// pairing (Shabnam FD + Rubik, see design.md) rather than a system font
/// with broad built-in script coverage. That's also why the word list below
/// is limited to scripts those two fonts actually cover (Persian and
/// Latin-alphabet languages) instead of Apple's much wider script mix —
/// showing a word in a font that lacks its glyphs would just render boxes.
///
/// Plays through [_words] exactly once — each word fades and scales in,
/// holds, then fades out before the next one starts — followed by a single
/// waving-hand flourish, then enables the "ادامه"/"Continue" button (which
/// starts disabled the whole time, so the sequence can't be skipped) with
/// its own soft fade/scale-in.
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

  static const _fadeInDuration = Duration(milliseconds: 500);
  static const _holdDuration = Duration(milliseconds: 1200);
  static const _fadeOutDuration = Duration(milliseconds: 400);
  static const _waveDuration = Duration(milliseconds: 1600);
  static const _buttonRevealDuration = Duration(milliseconds: 300);

  late final AnimationController _wordController = AnimationController(
    vsync: this,
  );
  late final AnimationController _waveController = AnimationController(
    vsync: this,
    duration: _waveDuration,
  );
  late final Animation<double> _waveAngle = TweenSequence<double>([
    TweenSequenceItem(tween: Tween(begin: 0, end: -15), weight: 1),
    TweenSequenceItem(tween: Tween(begin: -15, end: 15), weight: 2),
    TweenSequenceItem(tween: Tween(begin: 15, end: -12), weight: 2),
    TweenSequenceItem(tween: Tween(begin: -12, end: 0), weight: 1),
  ]).animate(CurvedAnimation(parent: _waveController, curve: Curves.easeInOut));

  int _wordIndex = 0;
  bool _sequenceFinished = false;

  @override
  void initState() {
    super.initState();
    _playSequence();
  }

  Future<void> _playSequence() async {
    for (var i = 0; i < _words.length; i++) {
      if (!mounted) return;
      setState(() => _wordIndex = i);
      _wordController.value = 0;
      await _wordController.animateTo(
        1,
        duration: _fadeInDuration,
        curve: Curves.easeOut,
      );
      if (!mounted) return;
      await Future<void>.delayed(_holdDuration);
      if (!mounted) return;
      await _wordController.animateTo(
        0,
        duration: _fadeOutDuration,
        curve: Curves.easeIn,
      );
    }
    if (!mounted) return;
    await _waveController.forward(from: 0);
    if (!mounted) return;
    setState(() => _sequenceFinished = true);
  }

  @override
  void dispose() {
    _wordController.dispose();
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
              AnimatedBuilder(
                animation: _wordController,
                builder: (context, child) {
                  final t = _wordController.value;
                  return Opacity(
                    opacity: t,
                    child: Transform.scale(scale: 0.9 + 0.1 * t, child: child),
                  );
                },
                child: Directionality(
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
                animation: _waveAngle,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _waveAngle.value * 3.14159265 / 180,
                    alignment: AlignmentDirectional.bottomCenter.resolve(
                      Directionality.of(context),
                    ),
                    child: child,
                  );
                },
                child: const Text('👋', style: TextStyle(fontSize: 40)),
              ),
              const Spacer(flex: 4),
              AnimatedOpacity(
                opacity: _sequenceFinished ? 1 : 0.4,
                duration: _buttonRevealDuration,
                curve: Curves.easeOut,
                child: AnimatedScale(
                  scale: _sequenceFinished ? 1 : 0.94,
                  duration: _buttonRevealDuration,
                  curve: Curves.easeOut,
                  child: ContinueButton(
                    label: l10n.onboardingContinueButton,
                    enabled: _sequenceFinished,
                    onPressed: _handleContinue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
