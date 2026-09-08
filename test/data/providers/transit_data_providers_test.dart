import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_transport/data/models/city_meta.dart';
import 'package:open_transport/data/models/transit_city_data.dart';
import 'package:open_transport/data/models/transit_line.dart';
import 'package:open_transport/data/providers/transit_data_providers.dart';

TransitLine _line(String id, TransportType type) {
  return TransitLine(
    id: id,
    name: {'en': id},
    color: '#000000',
    transportType: type,
    stationIds: const [],
  );
}

void main() {
  test(
    'availableTransportTypesProvider dedupes and orders by TransportType.values, '
    'not by the order lines happen to appear in the data',
    () {
      final city = TransitCityData(
        meta: const CityMeta(
          country: 'IR',
          city: 'tehran',
          dataVersion: '1.0.0',
          lastUpdated: '2026-01-01',
        ),
        lines: [
          // Deliberately scrambled and repeated: bus appears twice, brt
          // before bus, metro last.
          _line('l1', TransportType.brt),
          _line('l2', TransportType.bus),
          _line('l3', TransportType.bus),
          _line('l4', TransportType.metro),
        ],
        stations: const [],
        calendar: const [],
        trips: const [],
        stopTimes: const [],
      );

      final container = ProviderContainer(
        overrides: [cityDataProvider.overrideWith((ref) => city)],
      );
      addTearDown(container.dispose);

      final types = container.read(availableTransportTypesProvider);

      // TransportType.values order is metro, bus, tram, brt, commuterRail,
      // other — so metro (last in the data) should come first, and bus
      // should appear exactly once despite two lines using it.
      expect(types, [
        TransportType.metro,
        TransportType.bus,
        TransportType.brt,
      ]);
    },
  );

  test('availableTransportTypesProvider is empty while city data has not '
      'loaded yet', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(availableTransportTypesProvider), isEmpty);
  });
}
