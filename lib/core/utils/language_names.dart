/// A language's English name and its own endonym — e.g. `('Persian',
/// 'فارسی')`. Shared between onboarding's language picker and Home's
/// language switcher (see `core/widgets/autocomplete_field.dart`), so both
/// display the same "English (endonym)" format regardless of the current
/// UI locale — the way a native OS language picker does.
///
/// Neither half is translated UI copy (an endonym is the language's own
/// name for itself; the English name is a fixed label, not a string that
/// changes per locale), so these aren't ARB entries — the same way a
/// station's own-language name in schema.json isn't re-translated.
const languageNames = <String, (String english, String native)>{
  'en': ('English', 'English'),
  'fa': ('Persian', 'فارسی'),
};

/// "English (endonym)" for [code], e.g. `'fa'` → `'Persian (فارسی)'`.
String languageDisplayText(String code) {
  final names = languageNames[code];
  return names == null ? code : '${names.$1} (${names.$2})';
}

/// Just the endonym for [code], e.g. `'fa'` → `'فارسی'` — for compact UI
/// (a chip, a switcher) that doesn't have room for the full "English
/// (endonym)" form.
String languageEndonym(String code) => languageNames[code]?.$2 ?? code;
