import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// An explicit locale override, set once the user picks a language during
/// onboarding. `null` means "use the device's locale," matching the app's
/// behavior before onboarding chooses anything.
final appLocaleProvider = StateProvider<Locale?>((ref) => null);
