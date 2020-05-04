abstract class IAnalyticsService
{
    bool get isEnabled;

    set isEnabled(bool newValue);

    String get currentScreen;

    set currentScreen(String newValue);

    void log(String name, [Map<String, dynamic> params]);
}
