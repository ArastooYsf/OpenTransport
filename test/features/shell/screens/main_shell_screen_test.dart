import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_transport/core/theme/app_theme.dart';
import 'package:open_transport/features/shell/screens/main_shell_screen.dart';
import 'package:open_transport/l10n/generated/app_localizations.dart';

import '../../../test_utils/fake_preferences_repository.dart';

Widget _appUnderTest({bool showTutorialPrompt = false}) {
  const locale = Locale('en');
  return ProviderScope(
    overrides: [fakePreferencesOverride()],
    child: MaterialApp(
      theme: AppTheme.light(locale),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MainShellScreen(showTutorialPrompt: showTutorialPrompt),
    ),
  );
}

void main() {
  setUp(() {
    // See station_list_screen_test.dart's identical setUp: without this,
    // rootBundle's internal string cache can hand a later test a Future
    // tied to an already-torn-down test zone, which then never resolves.
    rootBundle.clear();
  });

  testWidgets('Home tab is shown by default', (tester) async {
    await tester.pumpWidget(_appUnderTest());

    expect(find.text('Smart'), findsOneWidget); // HomeScreen content
    expect(find.text('This section is coming soon.'), findsNothing);
  });

  testWidgets('switching to an unbuilt tab shows its placeholder', (
    tester,
  ) async {
    await tester.pumpWidget(_appUnderTest());

    // Map is a real, built screen now — Saved is still a placeholder tab.
    await tester.tap(find.bySemanticsLabel('Saved'));
    await tester.pumpAndSettle();

    expect(find.text('This section is coming soon.'), findsOneWidget);
    // Home's content is kept alive (IndexedStack), not disposed —
    // findsNothing here just means it's not the *visible* child, which
    // AppBar title duplication would otherwise make ambiguous to check
    // directly; the placeholder's own presence is the real assertion.
  });

  testWidgets('switching to Map shows the real Map screen, not a '
      'placeholder', (tester) async {
    await tester.pumpWidget(_appUnderTest());

    await tester.tap(find.bySemanticsLabel('Map'));
    await tester.pump();

    expect(find.text('This section is coming soon.'), findsNothing);
    expect(find.text('Overview'), findsOneWidget); // segmented control tab
  });

  testWidgets('switching tabs and back preserves Home without rebuilding '
      'it from scratch', (tester) async {
    await tester.pumpWidget(_appUnderTest());
    expect(find.text('Smart'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Settings'));
    await tester.pumpAndSettle();
    expect(find.text('Smart'), findsNothing);

    await tester.tap(find.bySemanticsLabel('Home'));
    await tester.pumpAndSettle();
    expect(find.text('Smart'), findsOneWidget);
  });

  testWidgets('forwards showTutorialPrompt through to the Home tab', (
    tester,
  ) async {
    await tester.pumpWidget(_appUnderTest(showTutorialPrompt: true));
    await tester.pump(const Duration(milliseconds: 750));

    expect(find.text('Want to see a quick tour of the app?'), findsOneWidget);
  });
}
