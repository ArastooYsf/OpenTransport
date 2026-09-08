import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/preferences_repository.dart';

/// The already-opened Hive box wrapped by [HivePreferencesRepository] — see
/// `main.dart`, which overrides this with the real repository *before*
/// `runApp`, so every provider that reads it (directly or via
/// [PreferencesRepository]) can do so synchronously.
///
/// Deliberately has no default implementation: unlike
/// `usernameAvailabilityRepositoryProvider` (a fully self-contained fake
/// with nothing to wire up), this one wraps a real external resource that
/// must exist before the widget tree builds. Tests override this with an
/// in-memory fake — see `test/test_utils/fake_preferences_repository.dart`.
final preferencesRepositoryProvider = Provider<PreferencesRepository>((ref) {
  throw UnimplementedError(
    'preferencesRepositoryProvider must be overridden — with the '
    'Hive-backed repository in main.dart, or a fake in tests — before '
    'anything reads it.',
  );
});
