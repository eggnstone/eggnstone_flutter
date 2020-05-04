abstract class IAnalyticsService
{
    bool get isEnabled;

    set isEnabled(bool newValue);

    String get currentScreen;

    set currentScreen(String newValue);

    Future track(String name, [Map<String, dynamic> params]);

    Future trackWarning(String source, String details);

    Future trackError(String source, String details);

    Future trackErrorWithException(String source, dynamic e, dynamic stackTrace);
}
