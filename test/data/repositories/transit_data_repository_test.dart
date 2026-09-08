import 'package:flutter_test/flutter_test.dart';
import 'package:open_transport/data/repositories/transit_data_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('loadCity parses the bundled Tehran data into typed models', () async {
    const repository = TransitDataRepository();

    final city = await repository.loadCity(country: 'iran', city: 'tehran');

    expect(city.meta.country, 'IR');
    expect(city.meta.city, 'tehran');

    expect(city.lines, hasLength(1));
    final line = city.lines.single;
    expect(line.id, 'tehran-line-1');
    expect(line.color, '#ED1C24');
    expect(line.name['en'], 'Tehran Metro Line 1');

    expect(city.stations, hasLength(3));
    final tajrish = city.stations.firstWhere((s) => s.id == 'tehran-tajrish');
    expect(tajrish.name['fa'], 'تجریش');
    expect(tajrish.lineIds, contains('tehran-line-1'));
  });

  test('loadCity merges the companion schedule file (calendar/trips/'
      'stopTimes) from the separate .schedule.json asset', () async {
    const repository = TransitDataRepository();

    final city = await repository.loadCity(country: 'iran', city: 'tehran');

    expect(city.calendar, isNotEmpty);
    expect(city.trips, isNotEmpty);
    expect(city.stopTimes, isNotEmpty);

    final trip = city.trips.first;
    expect(trip.lineId, 'tehran-line-1');
    final tripStopTimes = city.stopTimes.where(
      (stopTime) => stopTime.tripId == trip.id,
    );
    expect(tripStopTimes.map((s) => s.stationId), [
      'tehran-tajrish',
      'tehran-imam-khomeini',
      'tehran-rah-ahan',
    ]);
  });

  test('getDelaySeconds is always zero (no backend algorithm yet)', () async {
    const repository = TransitDataRepository();

    expect(await repository.getDelaySeconds('tehran-line-1-d0-0000'), 0);
  });
}
