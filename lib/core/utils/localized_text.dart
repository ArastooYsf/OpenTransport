import 'package:flutter/widgets.dart';

/// Resolves a schema.json-style `{ "fa": "...", "en": "..." }` localized-text
/// map for [locale], falling back to English, then to whatever entry exists.
String resolveLocalizedText(Map<String, String> text, Locale locale) {
  return text[locale.languageCode] ??
      text['en'] ??
      (text.isNotEmpty ? text.values.first : '');
}
