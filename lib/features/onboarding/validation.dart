/// Validation rules for the onboarding wizard's step 2 and step 3 fields.
/// Kept as plain functions so they're trivially unit-testable and reusable
/// between the step widgets and the stepper's progress calculations.
library;

/// English letters, digits, and underscore; 3–20 characters.
final usernameFormatPattern = RegExp(r'^[a-zA-Z0-9_]{3,20}$');

bool isUsernameFormatValid(String username) =>
    usernameFormatPattern.hasMatch(username);

/// First/last name are optional, so an empty value is always valid — this
/// only rejects a *non-empty* value that's implausible as a name (no
/// letters at all, e.g. "123" or "!!!"). `\p{L}` matches a Unicode letter
/// in any script, so this doesn't privilege Latin names over Persian ones.
final _anyLetterPattern = RegExp(r'\p{L}', unicode: true);

bool looksLikePlausibleName(String name) {
  final trimmed = name.trim();
  if (trimmed.isEmpty) return true;
  return _anyLetterPattern.hasMatch(trimmed);
}

/// A pragmatic, not-fully-RFC-5322 email check — good enough to catch
/// obviously-malformed input without rejecting real addresses.
final _emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

bool isEmailFormatValid(String email) => _emailPattern.hasMatch(email);

const passwordMinLength = 8;

bool isPasswordLongEnough(String password) =>
    password.length >= passwordMinLength;

enum PasswordStrength { weak, good, strong }

/// Counts how many of the three "extra" criteria (beyond the 8-character
/// minimum) a password meets: uppercase letter, digit, special character.
int passwordExtraCriteriaScore(String password) {
  var score = 0;
  if (RegExp(r'[A-Z]').hasMatch(password)) score++;
  if (RegExp(r'[0-9]').hasMatch(password)) score++;
  if (RegExp(r'[^A-Za-z0-9]').hasMatch(password)) score++;
  return score;
}

PasswordStrength passwordStrengthFor(String password) {
  final score = passwordExtraCriteriaScore(password);
  if (score >= 3) return PasswordStrength.strong;
  if (score == 2) return PasswordStrength.good;
  return PasswordStrength.weak;
}

bool passwordHasUppercase(String password) =>
    RegExp(r'[A-Z]').hasMatch(password);
bool passwordHasNumber(String password) => RegExp(r'[0-9]').hasMatch(password);
bool passwordHasSpecialChar(String password) =>
    RegExp(r'[^A-Za-z0-9]').hasMatch(password);
