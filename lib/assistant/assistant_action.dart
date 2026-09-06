import 'assistant_intent.dart';

/// The outcome of handling an [AssistantIntent] — enough for a voice
/// surface to speak a result or deep-link into the app.
sealed class AssistantAction {
  const AssistantAction();
}

final class NavigateToScreen extends AssistantAction {
  const NavigateToScreen(this.route);

  final String route;
}

final class SpeakResult extends AssistantAction {
  const SpeakResult(this.text);

  final String text;
}

/// Implemented later by a real handler; kept here so feature code can
/// depend on this contract without touching real voice/AI SDKs yet.
abstract interface class AssistantIntentHandler {
  Future<AssistantAction> handle(AssistantIntent intent);
}
