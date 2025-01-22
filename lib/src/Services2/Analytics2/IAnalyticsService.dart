abstract class IAnalyticsService
{
    /// The state of the service (if it reports to Analytics or not).
    bool get isEnabled;

    /// The state of the service (if it reports to Analytics or not).
    set isEnabled(bool newValue);

    /// The state of debug messages (if additional logging is on or not).
    bool get isDebugEnabled;

    /// The state of debug messages (if additional logging is on or not).
    set isDebugEnabled(bool newValue);

    /// The current screen.
    String get currentScreen;

    /// The current screen.
    set currentScreen(String newValue);

    void setUserId(String id);

    void setUserProperty(String key, String value);

    /// Track an event using a [name] and optional [params].
    void track(String name, [Map<String, Object>? params]);

    /// Track an action event with [name] and [action].
    void trackAction(String name, String action);

    /// Track a value event with [name] and [value].
    @Deprecated('Use trackTextValue or trackNumberValue instead.')
    void trackValue(String name, Object value);

    /// Track a value event with [name] and [numberValue].
    void trackNumberValue(String name, Object numberValue);

    /// Track a value event with [name] and [textValue].
    void trackTextValue(String name, Object textValue);

    /// Track an action-and-value event with [name] and [action] and [value].
    @Deprecated('Use trackActionAndTextValue or trackActionAndNumberValue instead.')
    void trackActionAndValue(String name, String action, Object value);

    /// Track an action-and-value event with [name] and [action] and [numberValue].
    void trackActionAndNumberValue(String name, String action, Object numberValue);

    /// Track an action-and-value event with [name] and [action] and [textValue].
    void trackActionAndTextValue(String name, String action, Object textValue);

    /// Track a warning using a warning [message] and optional [params].
    void trackWarning(String message, [Map<String, Object>? params]);

    /// Track an error using an error [message] and optional [params].
    void trackError(String message, [Map<String, Object>? params]);

    /// Track a warning specifying its [source], with exception [e] and optional [stackTrace].
    void trackWarningWithException(String source, dynamic e, [StackTrace? stackTrace]);

    /// Track an error specifying its [source], with exception [e] and optional [stackTrace].
    void trackErrorWithException(String source, dynamic e, [StackTrace? stackTrace]);
}
