abstract class ILoggerService
{
    bool get isEnabled;

    set isEnabled(bool newValue);

    void logDebug(String message);

    void logInfo(String message);

    void logWarning(String message);

    void logError(String message);
}
