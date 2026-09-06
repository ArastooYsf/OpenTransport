import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_transport/features/onboarding/widgets/continue_button.dart';

void main() {
  group('buttonFxAnchor', () {
    const size = Size(300, 52);

    test('LTR: anchors at the top-right corner', () {
      expect(buttonFxAnchor(size, TextDirection.ltr), const Offset(300, 0));
    });

    test('RTL: anchors at the top-left corner (mirrored)', () {
      expect(buttonFxAnchor(size, TextDirection.rtl), Offset.zero);
    });
  });

  group('revealRadiusFor', () {
    const size = Size(300, 52);
    final anchor = buttonFxAnchor(size, TextDirection.ltr); // (300, 0)

    test('progress 0: no radius yet', () {
      expect(revealRadiusFor(progress: 0, size: size, anchor: anchor), 0);
    });

    test('progress 1: radius reaches exactly the farthest corner from the '
        'anchor, guaranteeing full coverage', () {
      final radius = revealRadiusFor(progress: 1, size: size, anchor: anchor);
      // The anchor is the top-right corner (300, 0), so the farthest
      // corner is bottom-left (0, 52): distance = sqrt(300^2 + 52^2).
      final expected = (const Offset(0, 52) - anchor).distance;
      expect(radius, closeTo(expected, 0.001));
    });

    test('scales linearly with progress', () {
      final full = revealRadiusFor(progress: 1, size: size, anchor: anchor);
      final half = revealRadiusFor(progress: 0.5, size: size, anchor: anchor);
      expect(half, closeTo(full / 2, 0.001));
    });

    test('clamps progress above 1 or below 0', () {
      final full = revealRadiusFor(progress: 1, size: size, anchor: anchor);
      expect(revealRadiusFor(progress: 2, size: size, anchor: anchor), full);
      expect(revealRadiusFor(progress: -1, size: size, anchor: anchor), 0);
    });
  });
}
