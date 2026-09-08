import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../data/models/schedule.dart';
import '../../../data/models/station.dart';
import '../../../data/models/transit_city_data.dart';
import '../../../data/providers/transit_data_providers.dart';
import '../models/simulated_vehicle_position.dart';

/// Every currently-active trip's simulated position, recomputed once a
/// second from the current city's static schedule — see
/// [computeActivePositions]. No live GPS exists; this is what design.md's
/// "live train position" motion and the Map feature's moving-vehicle
/// rendering are driven by instead.
final vehiclePositionsProvider = StreamProvider<List<SimulatedVehiclePosition>>(
  (ref) {
    final city = ref.watch(cityDataProvider).valueOrNull;
    if (city == null) {
      return Stream.value(const <SimulatedVehiclePosition>[]);
    }
    return _tick(city);
  },
);

/// Emits once immediately, then once a second via an explicit [Timer.
/// periodic] — not a bare `while (true) { ...; await Future.delayed(...);
/// }` loop, since a plain [Future.delayed] can't be cancelled: if this
/// stream's subscription is cancelled while paused at that `await`, the
/// pending real [Timer] leaks until it fires anyway regardless. A
/// [StreamController] with an explicit `onCancel` guarantees the timer is
/// cancelled synchronously the moment the subscription is (e.g. on
/// provider disposal) rather than however many event-loop turns an
/// `async*`/`yield*`-delegated [Stream.periodic] might take to forward
/// cancellation through.
Stream<List<SimulatedVehiclePosition>> _tick(TransitCityData city) {
  late final StreamController<List<SimulatedVehiclePosition>> controller;
  Timer? timer;

  void emit() => controller.add(computeActivePositions(city, DateTime.now()));

  controller = StreamController<List<SimulatedVehiclePosition>>(
    onListen: () {
      emit();
      timer = Timer.periodic(const Duration(seconds: 1), (_) => emit());
    },
    onCancel: () => timer?.cancel(),
  );
  return controller.stream;
}

/// Finds every trip active at [now] and interpolates its position between
/// the two stopTimes bracketing [now] — the last station passed and the
/// next one coming up — rather than jumping discretely station to station.
///
/// A trip is active on a given calendar day if its [Trip.calendarId] entry
/// runs that day (weekday, date range, and exceptions all apply, GTFS-
/// style) and [now] falls between its first and last stopTime. Since a
/// stopTime's `arrivalTime` can exceed `24:00:00` for a trip that runs past
/// midnight (GTFS convention, see schedule.schema.json), both *today* and
/// *yesterday* are checked as the trip's calendar day — a trip that started
/// yesterday and is still running now is exactly as active as one that
/// starts today.
List<SimulatedVehiclePosition> computeActivePositions(
  TransitCityData city,
  DateTime now,
) {
  final stationsById = {
    for (final station in city.stations) station.id: station,
  };
  final calendarById = {for (final entry in city.calendar) entry.id: entry};

  final stopTimesByTrip = <String, List<StopTime>>{};
  for (final stopTime in city.stopTimes) {
    (stopTimesByTrip[stopTime.tripId] ??= []).add(stopTime);
  }
  for (final stopTimes in stopTimesByTrip.values) {
    stopTimes.sort((a, b) => a.stopSequence.compareTo(b.stopSequence));
  }

  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));

  final positions = <SimulatedVehiclePosition>[];
  for (final referenceDay in [today, yesterday]) {
    final nowSeconds = now.difference(referenceDay).inSeconds;

    for (final trip in city.trips) {
      final calendar = calendarById[trip.calendarId];
      if (calendar == null || !_isActiveOn(calendar, referenceDay)) continue;

      final stopTimes = stopTimesByTrip[trip.id];
      if (stopTimes == null || stopTimes.length < 2) continue;

      final firstSeconds = _parseTimeSeconds(stopTimes.first.arrivalTime);
      final lastSeconds = _parseTimeSeconds(stopTimes.last.arrivalTime);
      if (nowSeconds < firstSeconds || nowSeconds > lastSeconds) continue;

      final position = _positionWithin(
        stopTimes,
        nowSeconds,
        stationsById,
        trip,
      );
      if (position != null) positions.add(position);
    }
  }
  return positions;
}

SimulatedVehiclePosition? _positionWithin(
  List<StopTime> stopTimes,
  int nowSeconds,
  Map<String, Station> stationsById,
  Trip trip,
) {
  for (var i = 0; i < stopTimes.length - 1; i++) {
    final from = stopTimes[i];
    final to = stopTimes[i + 1];
    final fromSeconds = _parseTimeSeconds(
      from.departureTime ?? from.arrivalTime,
    );
    final toSeconds = _parseTimeSeconds(to.arrivalTime);
    if (nowSeconds < fromSeconds || nowSeconds > toSeconds) continue;

    final fromStation = stationsById[from.stationId];
    final toStation = stationsById[to.stationId];
    if (fromStation == null || toStation == null) return null;

    final span = toSeconds - fromSeconds;
    final progress = span <= 0
        ? 1.0
        : ((nowSeconds - fromSeconds) / span).clamp(0.0, 1.0);

    return SimulatedVehiclePosition(
      tripId: trip.id,
      lineId: trip.lineId,
      position: LatLng(
        fromStation.lat + (toStation.lat - fromStation.lat) * progress,
        fromStation.lng + (toStation.lng - fromStation.lng) * progress,
      ),
      fromStationId: from.stationId,
      toStationId: to.stationId,
      progress: progress,
      etaToNextStation: Duration(
        seconds: (toSeconds - nowSeconds).clamp(0, toSeconds),
      ),
    );
  }
  return null;
}

bool _isActiveOn(CalendarEntry entry, DateTime day) {
  final dateStr = _formatDate(day);

  for (final exception in entry.exceptions ?? const []) {
    if (exception.date == dateStr) {
      return exception.type == CalendarExceptionType.added;
    }
  }

  if (entry.startDate != null && dateStr.compareTo(entry.startDate!) < 0) {
    return false;
  }
  if (entry.endDate != null && dateStr.compareTo(entry.endDate!) > 0) {
    return false;
  }

  final weekday = DayOfWeek.values[day.weekday - 1];
  return entry.daysOfWeek.contains(weekday);
}

int _parseTimeSeconds(String hms) {
  final parts = hms.split(':');
  return int.parse(parts[0]) * 3600 +
      int.parse(parts[1]) * 60 +
      int.parse(parts[2]);
}

String _formatDate(DateTime date) {
  final year = date.year.toString().padLeft(4, '0');
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  return '$year-$month-$day';
}
