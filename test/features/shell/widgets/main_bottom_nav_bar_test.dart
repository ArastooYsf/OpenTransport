import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_transport/core/theme/app_theme.dart';
import 'package:open_transport/features/shell/widgets/main_bottom_nav_bar.dart';
import 'package:open_transport/l10n/generated/app_localizations.dart';
import 'package:phosphor_icons/phosphor_icons.dart';

Widget _appUnderTest({
  required ShellTab selected,
  required ValueChanged<ShellTab> onSelected,
  Locale locale = const Locale('en'),
}) {
  return MaterialApp(
    theme: AppTheme.light(locale),
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      bottomNavigationBar: MainBottomNavBar(
        selected: selected,
        onSelected: onSelected,
      ),
    ),
  );
}

void main() {
  testWidgets('is icon-only (no visible labels), each tab reachable by its '
      'accessibility label, and the selected tab shows fill weight, the '
      'rest outline', (tester) async {
    await tester.pumpWidget(
      _appUnderTest(selected: ShellTab.home, onSelected: (_) {}),
    );

    // No persistent text labels under the icons.
    expect(find.text('Home'), findsNothing);
    expect(find.text('Settings'), findsNothing);

    for (final label in ['Home', 'Map', 'Saved', 'Account', 'Settings']) {
      expect(find.bySemanticsLabel(label), findsOneWidget);
    }

    expect(find.byIcon(PhosphorIconsFill.house), findsOneWidget);
    expect(find.byIcon(PhosphorIconsRegular.house), findsNothing);
    expect(find.byIcon(PhosphorIconsRegular.mapTrifold), findsOneWidget);
    expect(find.byIcon(PhosphorIconsFill.mapTrifold), findsNothing);
  });

  testWidgets('tapping a tab reports it via onSelected', (tester) async {
    ShellTab? tapped;
    await tester.pumpWidget(
      _appUnderTest(selected: ShellTab.home, onSelected: (tab) => tapped = tab),
    );

    await tester.tap(find.bySemanticsLabel('Saved'));
    await tester.pump();

    expect(tapped, ShellTab.saved);
  });

  testWidgets(
    'switching the selected tab crossfades icons and slides the indicator '
    'without throwing',
    (tester) async {
      ShellTab selected = ShellTab.home;
      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) => _appUnderTest(
            selected: selected,
            onSelected: (tab) => setState(() => selected = tab),
          ),
        ),
      );

      await tester.tap(find.bySemanticsLabel('Account'));
      // Mid-flight: bounce/crossfade/indicator-slide all in progress at
      // once (AppMotion.base = 250ms) — nothing should throw.
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.takeException(), isNull);

      await tester.pump(const Duration(milliseconds: 300));
      expect(tester.takeException(), isNull);
      expect(find.byIcon(PhosphorIconsFill.user), findsOneWidget);
      expect(find.byIcon(PhosphorIconsFill.house), findsNothing);
    },
  );

  testWidgets('the liquid indicator stretches mid-travel but stays within the '
      "20-30% 'subtle, not glitchy' bound, and settles back to its resting "
      'width once the tab switch completes', (tester) async {
    ShellTab selected = ShellTab.home;
    await tester.pumpWidget(
      StatefulBuilder(
        builder: (context, setState) => _appUnderTest(
          selected: selected,
          onSelected: (tab) => setState(() => selected = tab),
        ),
      ),
    );

    double indicatorWidth() => tester
        .widget<PositionedDirectional>(find.byType(PositionedDirectional))
        .width!;

    const restWidth = MainBottomNavBar.indicatorDiameter;
    expect(indicatorWidth(), restWidth);

    await tester.tap(find.bySemanticsLabel('Settings'));
    // Register the tap and let the transition actually start (a fresh
    // AnimationController reads as "at rest" on the very frame it starts)
    // before sampling ~40% into AppMotion.base (250ms), where the stretch
    // peaks.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    final peakWidth = indicatorWidth();
    expect(peakWidth, greaterThan(restWidth));
    expect(peakWidth, lessThanOrEqualTo(restWidth * 1.3));

    await tester.pump(const Duration(milliseconds: 400));
    expect(indicatorWidth(), closeTo(restWidth, 0.5));
  });

  testWidgets('tab order mirrors in RTL — Home renders on the opposite '
      'side from LTR', (tester) async {
    await tester.pumpWidget(
      _appUnderTest(selected: ShellTab.home, onSelected: (_) {}),
    );
    final ltrHomeX = tester.getCenter(find.bySemanticsLabel('Home')).dx;

    await tester.pumpWidget(
      _appUnderTest(
        selected: ShellTab.home,
        onSelected: (_) {},
        locale: const Locale('fa'),
      ),
    );
    final rtlHomeX = tester.getCenter(find.bySemanticsLabel('خانه')).dx;

    // Home is first in reading order either way — start-to-end, not a
    // hardcoded side — so it sits near the *opposite* physical edge once
    // the reading direction flips.
    expect(ltrHomeX, lessThan(400));
    expect(rtlHomeX, greaterThan(400));
  });

  testWidgets('no overflow at a small phone width', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 568));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _appUnderTest(selected: ShellTab.settings, onSelected: (_) {}),
    );
    await tester.pump(const Duration(milliseconds: 300));

    expect(tester.takeException(), isNull);
  });
}
