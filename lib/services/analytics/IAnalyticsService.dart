abstract class IAnalyticsService
{
    void log(String name, [Map<String, dynamic> params]);

    set currentScreen(String newValue);

    void setUserProperty(String name, String value, {bool force = false});
}
