// TODO: rename Analytics to GoogleAnalytics

abstract class IGoogleAnalyticsService
{
    bool get isEnabled;

    set isEnabled(bool newValue);

    String get currentScreen;

    set currentScreen(String newValue);

    // TODO: shorten strings instead of expecting shortened strings

    // TODO: replace log* with track*

    void log(String name, [Map<String, dynamic> params]);

    void logAction(String name, String action);

    void logValue(String name, Object value);

    void logActionAndValue(String name, String action, Object value);

    void setUserProperty(String name, String value, {bool force = false});

    void setUserId(String value);
}
