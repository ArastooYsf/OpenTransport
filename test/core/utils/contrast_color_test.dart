import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_transport/core/utils/contrast_color.dart';

void main() {
  test('white background picks near-black text', () {
    expect(readableTextColorFor(Colors.white), const Color(0xFF1A1A1A));
  });

  test('near-black background picks white text', () {
    expect(readableTextColorFor(const Color(0xFF1A202C)), Colors.white);
  });

  // Regression: a naive "luminance > 0.5 -> black else white" split picks
  // white for every one of these — the objectively *worse*-contrast
  // choice, confirmed against the real WCAG contrast ratio for each. These
  // are design.md's exact accent/semantic tokens, so this is the same
  // check the accessibility audit ran, pinned so it can't regress.
  for (final MapEntry(key: name, value: hex) in {
    'light accent': 0xFF0891B2,
    'light success': 0xFF16A34A,
    'light danger': 0xFFEF4444,
    'light info': 0xFF3B82F6,
    'dark success': 0xFF22C55E,
    'dark danger': 0xFFF87171,
    'dark info': 0xFF60A5FA,
  }.entries) {
    test('$name (#${hex.toRadixString(16)}) picks near-black, not white', () {
      expect(readableTextColorFor(Color(hex)), const Color(0xFF1A1A1A));
    });
  }
}
