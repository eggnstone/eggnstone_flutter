abstract class IAnalyticsService
{
    /// The state of the service (if it reports to Analytics or not).
    bool get isEnabled;

    /// The state of the service (if it reports to Analytics or not).
    set isEnabled(bool newValue);

    /// The current screen.
    String get currentScreen;

    /// The current screen.
    set currentScreen(String newValue);

    /// Track an event using a @name and optional @params.
    Future track(String name, [Map<String, dynamic>? params]);

    /// Track a warning using a warning @message and optional @params.
    Future trackWarning(String message, [Map<String, dynamic>? params]);

    /// Track an error using an error @message and optional @params.
    Future trackError(String message, [Map<String, dynamic>? params]);

    /// Track a warning specifying its @source, with exception @e and @stackTrace.
    Future trackWarningWithException(String source, dynamic e, dynamic stackTrace);

    /// Track an error specifying its @source, with exception @e and @stackTrace.
    Future trackErrorWithException(String source, dynamic e, dynamic stackTrace);

    /// Track an action event.
    /// @param name The name of the event.
    /// @param action The name of the action.
    void trackAction(String name, String action);

    /// Track a value event.
    /// @param name The name of the event.
    /// @param value The name of the value.
    void trackValue(String name, Object value);

    /// Track an action-and-value event.
    /// @param name The name of the event.
    /// @param action The name of the action.
    /// @param value The name of the value.
    void trackActionAndValue(String name, String action, Object value);
}
