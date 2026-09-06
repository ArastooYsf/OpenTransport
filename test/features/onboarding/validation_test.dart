import 'package:flutter_test/flutter_test.dart';
import 'package:open_transport/features/onboarding/validation.dart';

void main() {
  group('isUsernameFormatValid', () {
    test('accepts letters, digits, underscore within 3-20 chars', () {
      expect(isUsernameFormatValid('arastoo_1'), isTrue);
    });

    test('rejects too short', () {
      expect(isUsernameFormatValid('ab'), isFalse);
    });

    test('rejects too long', () {
      expect(isUsernameFormatValid('a' * 21), isFalse);
    });

    test('rejects disallowed characters', () {
      expect(isUsernameFormatValid('bad name!'), isFalse);
      expect(isUsernameFormatValid('کاربر'), isFalse);
    });
  });

  group('looksLikePlausibleName', () {
    test('empty is always valid (optional field)', () {
      expect(looksLikePlausibleName(''), isTrue);
      expect(looksLikePlausibleName('   '), isTrue);
    });

    test('accepts a name with letters, Latin or Persian', () {
      expect(looksLikePlausibleName('Arastoo'), isTrue);
      expect(looksLikePlausibleName('آرستو'), isTrue);
    });

    test('rejects purely numeric or symbolic input', () {
      expect(looksLikePlausibleName('12345'), isFalse);
      expect(looksLikePlausibleName('!!!'), isFalse);
    });
  });

  group('password strength', () {
    test('8-char minimum is independent of strength', () {
      expect(isPasswordLongEnough('short'), isFalse);
      expect(isPasswordLongEnough('12345678'), isTrue);
    });

    test('weak: 0-1 extra criteria', () {
      expect(passwordStrengthFor('alllowercase'), PasswordStrength.weak);
      expect(passwordStrengthFor('Alllowercase'), PasswordStrength.weak);
    });

    test('good: 2 extra criteria', () {
      expect(passwordStrengthFor('Alllower1'), PasswordStrength.good);
    });

    test('strong: 3 extra criteria', () {
      expect(passwordStrengthFor('Alllower1!'), PasswordStrength.strong);
    });

    test('criteria are independent of the 8-char minimum', () {
      // Under 8 chars but meets all 3 extra criteria.
      expect(passwordStrengthFor('A1!'), PasswordStrength.strong);
      expect(isPasswordLongEnough('A1!'), isFalse);
    });
  });
}
