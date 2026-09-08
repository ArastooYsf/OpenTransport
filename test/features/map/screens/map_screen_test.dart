import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_transport/core/theme/app_theme.dart';
import 'package:open_transport/features/map/models/simulated_vehicle_position.dart';
import 'package:open_transport/features/map/providers/map_providers.dart';
import 'package:open_transport/features/map/providers/vehicle_position_provider.dart';
import 'package:open_transport/features/map/screens/map_screen.dart';
import 'package:open_transport/features/map/widgets/layer_toggle_chips.dart';
import 'package:open_transport/features/map/widgets/mode_segmented_control.dart';
import 'package:open_transport/features/map/widgets/schematic_line_view.dart';
import 'package:open_transport/l10n/generated/app_localizations.dart';

import '../../../test_utils/fake_preferences_repository.dart';
import '../../../test_utils/pump_until_found.dart';

Widget _appUnderTest(ProviderContainer container, Locale locale) {
  return UncontrolledProviderScope(
    container: container,
    child: MaterialApp(
      theme: AppTheme.light(locale),
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const MapScreen(),
    ),
  );
}

/// Every test overrides [vehiclePositionsProvider] with a fixed, single-
/// event stream rather than letting its real `Timer.periodic` implementation
/// run — these are widget tests for [MapScreen]'s rendering/interaction,
/// not for the ticking mechanism itself (see vehicle_position_provider_test
/// .dart for that). A real periodic timer left running past a test's own
/// teardown trips flutter_test's "pending timer" invariant check.
List<Override> _overrides({
  List<SimulatedVehiclePosition> positions = const [],
}) {
  return [
    fakePreferencesOverride(),
    vehiclePositionsProvider.overrideWith((ref) => Stream.value(positions)),
  ];
}

void main() {
  setUp(() {
    // See station_list_screen_test.dart's identical setUp: without this,
    // rootBundle's internal string cache can hand a later test a Future
    // tied to an already-torn-down test zone, which then never resolves.
    rootBundle.clear();
  });

  testWidgets('defaults to the "Overview" tab, showing the real OSM map', (
    tester,
  ) async {
    final container = ProviderContainer(overrides: _overrides());
    addTearDown(container.dispose);

    await tester.pumpWidget(_appUnderTest(container, const Locale('en')));
    await pumpUntilFound(tester, find.text('Metro')); // segmented tab

    expect(find.text('Overview'), findsOneWidget);
    expect(find.byType(FlutterMap), findsOneWidget);
    expect(find.byType(SchematicLineView), findsNothing);
    expect(find.byType(LayerToggleChips), findsOneWidget);
  });

  testWidgets('tapping a mode tab switches to its schematic diagram', (
    tester,
  ) async {
    final container = ProviderContainer(overrides: _overrides());
    addTearDown(container.dispose);

    await tester.pumpWidget(_appUnderTest(container, const Locale('en')));
    await pumpUntilFound(tester, find.text('Metro'));

    final modeTab = find.descendant(
      of: find.byType(ModeSegmentedControl),
      matching: find.text('Metro'),
    );
    await tester.tap(modeTab);
    await tester.pump();

    expect(find.byType(FlutterMap), findsNothing);
    expect(find.byType(SchematicLineView), findsOneWidget);
    expect(container.read(mapModeProvider), isNotNull);
  });

  testWidgets('the layer toggle chip hides and re-shows that layer', (
    tester,
  ) async {
    final container = ProviderContainer(overrides: _overrides());
    addTearDown(container.dispose);

    await tester.pumpWidget(_appUnderTest(container, const Locale('en')));
    await pumpUntilFound(tester, find.text('Metro'));

    expect(container.read(visibleMapLayersProvider), isNotEmpty);

    final layerChip = find.descendant(
      of: find.byType(LayerToggleChips),
      matching: find.text('Metro'),
    );
    await tester.tap(layerChip);
    await tester.pump();

    expect(container.read(visibleMapLayersProvider), isEmpty);

    await tester.tap(layerChip);
    await tester.pump();

    expect(container.read(visibleMapLayersProvider), isNotEmpty);
  });

  testWidgets('renders "کامل"/"مترو" tabs in Persian (RTL)', (tester) async {
    final container = ProviderContainer(overrides: _overrides());
    addTearDown(container.dispose);

    await tester.pumpWidget(_appUnderTest(container, const Locale('fa')));
    await pumpUntilFound(tester, find.text('مترو'));

    expect(find.text('کامل'), findsOneWidget);

    final directionality = tester.widget<Directionality>(
      find.byType(Directionality).first,
    );
    expect(directionality.textDirection, TextDirection.rtl);
  });

  testWidgets(
    'an active vehicle position is passed through to the schematic view',
    (tester) async {
      final container = ProviderContainer(
        overrides: _overrides(
          positions: const [
            SimulatedVehiclePosition(
              tripId: 'trip-1',
              lineId: 'tehran-line-1',
              position: LatLng(35.75, 51.42),
              fromStationId: 'tehran-tajrish',
              toStationId: 'tehran-imam-khomeini',
              progress: 0.5,
              etaToNextStation: Duration(minutes: 3),
            ),
          ],
        ),
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(_appUnderTest(container, const Locale('en')));
      await pumpUntilFound(tester, find.text('Metro'));

      final modeTab = find.descendant(
        of: find.byType(ModeSegmentedControl),
        matching: find.text('Metro'),
      );
      await tester.tap(modeTab);
      await tester.pump();

      final schematic = tester.widget<SchematicLineView>(
        find.byType(SchematicLineView),
      );
      expect(schematic.positions, hasLength(1));
      expect(schematic.positions.single.tripId, 'trip-1');
    },
  );
}
