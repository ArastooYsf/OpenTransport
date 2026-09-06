import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_transport/features/home/screens/home_screen.dart';
import 'package:open_transport/l10n/generated/app_localizations.dart';

Widget _appUnderTest(Locale locale) {
  return MaterialApp(
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: const HomeScreen(),
  );
}

void main() {
  testWidgets('renders all three options in English (LTR)', (tester) async {
    await tester.pumpWidget(_appUnderTest(const Locale('en')));

    expect(find.text('Smart'), findsOneWidget);
    expect(
      find.text('The easiest way to any destination or station'),
      findsOneWidget,
    );
    expect(find.text('Metro'), findsOneWidget);
    expect(find.text('BRT'), findsOneWidget);
    expect(find.text('Coming soon'), findsOneWidget);

    final directionality = tester.widget<Directionality>(
      find.byType(Directionality).first,
    );
    expect(directionality.textDirection, TextDirection.ltr);
  });

  testWidgets('renders all three options in Persian (RTL)', (tester) async {
    await tester.pumpWidget(_appUnderTest(const Locale('fa')));

    expect(find.text('همگانی'), findsOneWidget);
    expect(find.text('مترو'), findsOneWidget);
    expect(find.text('BRT'), findsOneWidget);
    expect(find.text('به‌زودی'), findsOneWidget);

    final directionality = tester.widget<Directionality>(
      find.byType(Directionality).first,
    );
    expect(directionality.textDirection, TextDirection.rtl);
  });

  testWidgets('tapping Metro opens a placeholder screen', (tester) async {
    await tester.pumpWidget(_appUnderTest(const Locale('en')));

    await tester.tap(find.text('Metro'));
    await tester.pumpAndSettle();

    expect(find.text("This section is coming soon."), findsOneWidget);
  });

  testWidgets('tapping the muted BRT option still navigates', (tester) async {
    await tester.pumpWidget(_appUnderTest(const Locale('en')));

    await tester.tap(find.text('BRT'));
    await tester.pumpAndSettle();

    expect(find.text("This section is coming soon."), findsOneWidget);
  });
}
