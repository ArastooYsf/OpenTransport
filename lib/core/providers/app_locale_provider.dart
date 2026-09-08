import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/preferences_providers.dart';
import '../../data/repositories/preferences_repository.dart';

/// An explicit locale override — `null` means "use the device's locale,"
/// matching the app's behavior before anything has ever chosen one.
///
/// Initialized from [PreferencesRepository.languageCode] (persisted from a
/// previous launch, if any) rather than always starting `null`; use
/// [select] rather than assigning `.state` directly so a change is never
/// applied without also being saved.
class AppLocaleNotifier extends StateNotifier<Locale?> {
  AppLocaleNotifier(this._repository) : super(_initial(_repository));

  final PreferencesRepository _repository;

  static Locale? _initial(PreferencesRepository repository) {
    final code = repository.languageCode;
    return code == null ? null : Locale(code);
  }

  void select(Locale locale) {
    state = locale;
    _repository.saveLanguageCode(locale.languageCode);
  }
}

final appLocaleProvider = StateNotifierProvider<AppLocaleNotifier, Locale?>((
  ref,
) {
  return AppLocaleNotifier(ref.watch(preferencesRepositoryProvider));
});
