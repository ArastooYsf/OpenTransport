import 'package:flutter_test/flutter_test.dart';
import 'package:open_transport/features/onboarding/widgets/continue_button.dart';

void main() {
  group('glowSegmentRanges', () {
    const total = 156.0; // an arbitrary perimeter length

    test('progress 0: nothing to draw yet', () {
      expect(glowSegmentRanges(progress: 0, total: total), isEmpty);
    });

    test('mid-sweep: one range, fixed length, no wrap needed', () {
      final ranges = glowSegmentRanges(progress: 0.5, total: total);
      expect(ranges, hasLength(1));
      final (start, end) = ranges.single;
      expect(end, greaterThan(start));
      // The segment's length stays fixed mid-sweep: the intended
      // glowSegmentFraction of the perimeter, plus the (imperceptible,
      // always-applied) closure overlap.
      final expectedLength = glowSegmentFraction * total + glowClosureOverlapPx;
      expect(end - start, closeTo(expectedLength, 0.01));
    });

    test(
      'progress 1.0: nothing draws — head and tail meet exactly, which is '
      'itself the correct "no seam" outcome (nothing visible can\'t show a '
      "gap); the closure overlap only matters a hair *before* this point",
      () {
        expect(glowSegmentRanges(progress: 1, total: total), isEmpty);
      },
    );

    test('just before full closure: the closure overlap pushes the head past '
        '`total`, so this must come back as the two-range wrap, not a range '
        'that silently stops short at `total` and leaves a gap', () {
      // Close enough to 1.0 that head clamps to 1.0 (=total px) while
      // tail is still just under 1.0, so head > tail and something
      // still draws — but head*total + overlap now exceeds `total`.
      final ranges = glowSegmentRanges(progress: 0.999, total: total);
      expect(ranges, hasLength(2));

      final (firstStart, firstEnd) = ranges[0];
      final (wrapStart, wrapEnd) = ranges[1];

      // First piece runs to the exact end of the path...
      expect(firstEnd, total);
      expect(firstStart, lessThan(firstEnd));
      // ...and the wrapped piece picks up from the exact start (0),
      // covering exactly the overlap that ran past `total` — together
      // they reach the closure point with no gap in between.
      expect(wrapStart, 0);
      expect(wrapEnd, closeTo(glowClosureOverlapPx, 0.01));
    });

    test('never returns a zero-or-negative-length range', () {
      for (var p = 0.0; p <= 1.0; p += 0.01) {
        for (final (start, end) in glowSegmentRanges(
          progress: p,
          total: total,
        )) {
          expect(
            end,
            greaterThan(start),
            reason: 'progress=$p produced ($start, $end)',
          );
        }
      }
    });
  });
}
