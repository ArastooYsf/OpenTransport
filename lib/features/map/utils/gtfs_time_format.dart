/// Formats a schedule.schema.json `HH:MM:SS` time (which can exceed
/// `24:00:00` for a trip that runs past midnight, GTFS-style) into a plain
/// 24-hour `HH:MM` clock display, wrapping hours back into 0-23.
///
/// Always Western digits, per design.md's numerals rule ("decide once...
/// apply that rule everywhere consistently") — this is the first place the
/// app displays a real clock time, so there's no existing convention to
/// follow yet; Western digits match the underlying GTFS/24-hour data as-is.
String formatGtfsTime(String hms) {
  final parts = hms.split(':');
  final hour = int.parse(parts[0]) % 24;
  return '${hour.toString().padLeft(2, '0')}:${parts[1]}';
}
