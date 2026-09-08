import 'package:flutter_test/flutter_test.dart';
import 'package:open_transport/data/models/city_meta.dart';
import 'package:open_transport/data/models/schedule.dart';
import 'package:open_transport/data/models/station.dart';
import 'package:open_transport/data/models/transit_city_data.dart';
import 'package:open_transport/data/models/transit_line.dart';
import 'package:open_transport/features/map/providers/vehicle_position_provider.dart';

Station _station(String id, double lat, double lng) {
  return Station(
    id: id,
    name: {'en': id},
    lat: lat,
    lng: lng,
    lineIds: const ['line-1'],
  );
}

void main() {
  // Deriving the test day's weekday dynamically (rather than assuming a
  // real calendar date's weekday) keeps this test correct regardless of
  // which date is picked.
  final testDay = DateTime(2026, 3, 10);
  final testWeekday = DayOfWeek.values[testDay.weekday - 1];
  final otherWeekday =
      DayOfWeek.values[(testDay.weekday % 7)]; // any different weekday

  final stationA = _station('a', 35.0, 51.0);
  final stationB = _station('b', 35.1, 51.0); // 1 lat-degree segment
  final stationC = _station('c', 35.2, 51.0);

  final line = TransitLine(
    id: 'line-1',
    name: const {'en': 'Line 1'},
    color: '#FF0000',
    transportType: TransportType.metro,
    stationIds: const ['a', 'b', 'c'],
  );

  TransitCityData cityWith({
    required CalendarEntry calendar,
    required List<StopTime> stopTimes,
  }) {
    return TransitCityData(
      meta: const CityMeta(
        country: 'IR',
        city: 'test',
        dataVersion: '1.0.0',
        lastUpdated: '2026-01-01',
      ),
      lines: [line],
      stations: [stationA, stationB, stationC],
      calendar: [calendar],
      trips: const [
        Trip(id: 'trip-1', lineId: 'line-1', direction: 0, calendarId: 'cal-1'),
      ],
      stopTimes: stopTimes,
    );
  }

  final activeCalendar = CalendarEntry(id: 'cal-1', daysOfWeek: [testWeekday]);
  final stopTimes = const [
    StopTime(
      tripId: 'trip-1',
      stationId: 'a',
      arrivalTime: '10:00:00',
      stopSequence: 0,
    ),
    StopTime(
      tripId: 'trip-1',
      stationId: 'b',
      arrivalTime: '10:10:00',
      stopSequence: 1,
    ),
    StopTime(
      tripId: 'trip-1',
      stationId: 'c',
      arrivalTime: '10:20:00',
      stopSequence: 2,
    ),
  ];

  test('no active positions before the trip\'s first stopTime', () {
    final city = cityWith(calendar: activeCalendar, stopTimes: stopTimes);
    final now = DateTime(2026, 3, 10, 9, 59, 59);

    expect(computeActivePositions(city, now), isEmpty);
  });

  test('no active positions after the trip\'s last stopTime', () {
    final city = cityWith(calendar: activeCalendar, stopTimes: stopTimes);
    final now = DateTime(2026, 3, 10, 10, 20, 1);

    expect(computeActivePositions(city, now), isEmpty);
  });

  test('interpolates halfway through the first segment', () {
    final city = cityWith(calendar: activeCalendar, stopTimes: stopTimes);
    final now = DateTime(2026, 3, 10, 10, 5, 0); // halfway between a and b

    final positions = computeActivePositions(city, now);

    expect(positions, hasLength(1));
    final position = positions.single;
    expect(position.tripId, 'trip-1');
    expect(position.lineId, 'line-1');
    expect(position.fromStationId, 'a');
    expect(position.toStationId, 'b');
    expect(position.progress, closeTo(0.5, 1e-9));
    expect(position.position.latitude, closeTo(35.05, 1e-9));
    expect(position.position.longitude, closeTo(51.0, 1e-9));
    expect(position.etaToNextStation, const Duration(minutes: 5));
  });

  test('picks the correct (second) segment, not always the first', () {
    final city = cityWith(calendar: activeCalendar, stopTimes: stopTimes);
    final now = DateTime(2026, 3, 10, 10, 15, 0); // halfway between b and c

    final position = computeActivePositions(city, now).single;

    expect(position.fromStationId, 'b');
    expect(position.toStationId, 'c');
    expect(position.progress, closeTo(0.5, 1e-9));
  });

  test('not active on a day not in the calendar\'s daysOfWeek', () {
    final calendar = CalendarEntry(id: 'cal-1', daysOfWeek: [otherWeekday]);
    final city = cityWith(calendar: calendar, stopTimes: stopTimes);
    final now = DateTime(2026, 3, 10, 10, 5, 0);

    expect(computeActivePositions(city, now), isEmpty);
  });

  test('a "removed" exception overrides an otherwise-matching weekday', () {
    final calendar = CalendarEntry(
      id: 'cal-1',
      daysOfWeek: [testWeekday],
      exceptions: const [
        CalendarException(
          date: '2026-03-10',
          type: CalendarExceptionType.removed,
        ),
      ],
    );
    final city = cityWith(calendar: calendar, stopTimes: stopTimes);
    final now = DateTime(2026, 3, 10, 10, 5, 0);

    expect(computeActivePositions(city, now), isEmpty);
  });

  test('an "added" exception activates a day not in daysOfWeek', () {
    final calendar = CalendarEntry(
      id: 'cal-1',
      daysOfWeek: [otherWeekday],
      exceptions: const [
        CalendarException(
          date: '2026-03-10',
          type: CalendarExceptionType.added,
        ),
      ],
    );
    final city = cityWith(calendar: calendar, stopTimes: stopTimes);
    final now = DateTime(2026, 3, 10, 10, 5, 0);

    expect(computeActivePositions(city, now), hasLength(1));
  });

  test('respects startDate/endDate bounds', () {
    final calendar = CalendarEntry(
      id: 'cal-1',
      daysOfWeek: [testWeekday],
      startDate: '2026-04-01',
    );
    final city = cityWith(calendar: calendar, stopTimes: stopTimes);
    final now = DateTime(2026, 3, 10, 10, 5, 0);

    expect(computeActivePositions(city, now), isEmpty);
  });
}
