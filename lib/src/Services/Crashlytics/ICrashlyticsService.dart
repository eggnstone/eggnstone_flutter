abstract class ICrashlyticsService
{
    /// The state of debug messages (if additional logging is on or not).
    bool get isDebugEnabled;

    /// The state of debug messages (if additional logging is on or not).
    set isDebugEnabled(bool newValue);

    void onError(Object error, StackTrace stackTrace);

    void setUserId(String id);

    void setUserProperty(String key, String value);

    void recordError(Object error, StackTrace stackTrace);

    // TODO: log()
    // TODO: crash()
}
