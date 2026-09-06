import 'package:flutter/material.dart';

import '../../../core/navigation/fade_scale_page_route.dart';
import '../../onboarding/screens/greeting_screen.dart';
import '../widgets/pulsing_logo.dart';
import '../widgets/splash_loading_bar.dart';

/// The app's entry screen: logo + loading bar while the app initializes,
/// then a hand-off into the first-launch greeting (which itself hands off
/// into onboarding).
///
/// There's no "has onboarding been completed before" check yet — that
/// needs a persistence layer (Hive, per CLAUDE.md) this app doesn't have
/// wired up yet. Until then, every launch goes through onboarding; add
/// that check here, in one place, once preferences are persisted.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp().then((_) {
      if (!mounted) return;
      Navigator.of(
        context,
      ).pushReplacement(fadeScalePageRoute(const GreetingScreen()));
    });
  }

  /// Everything the app needs before it's usable.
  ///
  /// This is a fake delay for now — the seam is deliberately just this one
  /// method, so real work (e.g. warming the bundled city-data provider,
  /// checking Hive for cached preferences) can replace the body later
  /// without touching the splash screen's UI or navigation at all.
  Future<void> _initializeApp() {
    return Future<void>.delayed(const Duration(milliseconds: 1800));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [PulsingLogo(), SizedBox(height: 32), SplashLoadingBar()],
        ),
      ),
    );
  }
}
