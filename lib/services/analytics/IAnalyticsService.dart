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

    /// Track an event.
    /// @param name The name of the event.
    /// @param params The optional parameters.
    Future track(String name, [Map<String, dynamic>? params]);

    /// Track a warning.
    /// @param message The warning message.
    /// @param params The optional parameters.
    Future trackWarning(String message, [Map<String, dynamic>? params]);

    /// Track an error.
    /// @param message The error message.
    /// @param params The optional parameters.
    Future trackError(String message, [Map<String, dynamic>? params]);

    /// Track a warning with an exception.
    /// @param source The source of the warning.
    /// @param stackTrace The stack trace.
    Future trackWarningWithException(String source, dynamic e, dynamic stackTrace);

    /// Track an error with an exception.
    /// @param source The source of the error.
    /// @param stackTrace The stack trace.
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
