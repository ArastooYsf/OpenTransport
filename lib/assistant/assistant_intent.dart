/// A user request the assistant layer can act on (e.g. from Siri Shortcuts
/// or Google Assistant App Actions).
///
/// This is a stable interface only — no voice/AI SDK is wired in yet. Keep
/// it dependency-free so feature code can be built against it now without
/// churn when a real implementation lands later.
sealed class AssistantIntent {
  const AssistantIntent();
}

/// "How do I get from A to B?"
final class FindRouteIntent extends AssistantIntent {
  const FindRouteIntent({
    required this.originStationId,
    required this.destinationStationId,
  });

  final String originStationId;
  final String destinationStationId;
}

/// "When's the next train at station X?"
final class NextDepartureIntent extends AssistantIntent {
  const NextDepartureIntent({required this.stationId});

  final String stationId;
}
