import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/transit_data_repository.dart';

/// Shared instance of [TransitDataRepository] — the only way UI/feature
/// code should reach bundled transit data, per CLAUDE.md's architecture
/// rules.
final transitDataRepositoryProvider = Provider<TransitDataRepository>((ref) {
  return const TransitDataRepository();
});
