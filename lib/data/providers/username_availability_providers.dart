import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/username_availability_repository.dart';

final usernameAvailabilityRepositoryProvider =
    Provider<UsernameAvailabilityRepository>((ref) {
      return const UsernameAvailabilityRepository();
    });
