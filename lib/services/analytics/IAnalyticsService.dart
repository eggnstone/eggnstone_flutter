abstract class IAnalyticsService
{
    bool get isEnabled;

    set isEnabled(bool newValue);

    String get currentScreen;

    set currentScreen(String newValue);

    Future track(String name, [Map<String, dynamic> params]);

    Future trackWarning(String source, Map<String, dynamic> params);

    Future trackError(String source, Map<String, dynamic> params);

    Future trackErrorWithException(String source, dynamic e, dynamic stackTrace);

    void trackAction(String name, String action);

    void trackValue(String name, Object value);

    void trackActionAndValue(String name, String action, Object value);
}
