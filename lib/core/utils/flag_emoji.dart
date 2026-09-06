/// Builds a flag emoji from an ISO 3166-1 alpha-2 code (e.g. `'IR'` → 🇮🇷)
/// by mapping each letter to its Regional Indicator Symbol. This scales to
/// any future country in the catalog automatically — no per-country emoji
/// to hand-maintain.
String flagEmoji(String isoCode) {
  final codeUnits = isoCode.toUpperCase().codeUnits;
  return String.fromCharCodes(codeUnits.map((unit) => 0x1F1E6 + (unit - 0x41)));
}
