import 'package:flutter/material.dart';

/// Parses a `#RRGGBB` hex string (as stored in transit data files, e.g.
/// [TransitLine.color]) into a [Color]. Falls back to [fallbackLineColor]
/// for a missing or malformed value, per design.md.
Color colorFromHex(String? hex) {
  if (hex == null) return fallbackLineColor;
  final match = RegExp(r'^#([0-9A-Fa-f]{6})$').firstMatch(hex);
  if (match == null) return fallbackLineColor;
  return Color(int.parse('FF${match.group(1)}', radix: 16));
}

/// A neutral gray used both as [colorFromHex]'s fallback for a missing/
/// malformed line color, and as the Map feature's "dimmed, unselected
/// line" tone (see [SchematicLineView]/`OverviewMapView`) — the same
/// "line color is unknown/de-emphasized" visual role in both cases.
const fallbackLineColor = Color(0xFF9E9E9E);
