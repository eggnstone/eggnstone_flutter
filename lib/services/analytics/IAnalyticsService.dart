abstract class IAnalyticsService
{
    bool get isEnabled;

    set isEnabled(bool newValue);

    String get currentScreen;

    set currentScreen(String newValue);

    //RouteObserver<PageRoute<dynamic>> getObserver();

    void log(String name, [Map<String, dynamic> params]);

    void logAction(String name, String action);

    void logValue(String name, Object value);

    void logActionAndValue(String name, String action, Object value);

    void setUserProperty(String name, String value, {bool force = false});

    void setUserId(String value);
}
