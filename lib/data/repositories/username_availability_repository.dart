/// Checks whether a username is already taken.
///
/// No real backend exists yet — this simulates one (a fixed reserved list
/// plus network-like latency) so the UI's debounce/spinner/result flow is
/// real and testable now. Same "stable interface, fake implementation
/// until a backend exists" pattern as `assistant/` in CLAUDE.md: swap the
/// body for a real API call later without touching any calling code.
class UsernameAvailabilityRepository {
  const UsernameAvailabilityRepository();

  static const _reservedForDemo = {'admin', 'test', 'opentransport', 'support'};

  Future<bool> isTaken(String username) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return _reservedForDemo.contains(username.toLowerCase());
  }
}
