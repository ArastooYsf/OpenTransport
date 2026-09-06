import 'package:flutter/material.dart';

/// Parses a `#RRGGBB` hex string (as stored in transit data files, e.g.
/// [TransitLine.color]) into a [Color]. Falls back to neutral gray for a
/// missing or malformed value, per design.md.
Color colorFromHex(String? hex) {
  if (hex == null) return _fallbackGray;
  final match = RegExp(r'^#([0-9A-Fa-f]{6})$').firstMatch(hex);
  if (match == null) return _fallbackGray;
  return Color(int.parse('FF${match.group(1)}', radix: 16));
}

const _fallbackGray = Color(0xFF9E9E9E);
