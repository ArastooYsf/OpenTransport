/// Normalizes text for search matching: lowercases and folds a couple of
/// Arabic/Persian glyph variants that different keyboards produce for "the
/// same" letter (Arabic Yeh/Kaf → Persian Yeh/Keheh), plus the zero-width
/// non-joiner some Persian input methods insert.
///
/// This does NOT transliterate between scripts — "iran" won't be turned
/// into "ایران" or vice versa. Script-insensitive matching (typing either
/// "iran" or "ایران" and finding Iran) instead comes from searching across
/// *all* of a catalog entry's localized names at once — see
/// `AutocompleteField._filter`. Every substitution here maps one character
/// to exactly one character, so indices into the normalized string stay
/// aligned with the original — needed for bold-match highlighting.
String normalizeSearchText(String input) {
  return input
      .toLowerCase()
      .replaceAll('‌', ' ') // zero-width non-joiner
      .replaceAll('ي', 'ی') // Arabic Yeh -> Persian Yeh
      .replaceAll('ك', 'ک'); // Arabic Kaf -> Persian Keheh
}
