import 'package:intl/intl.dart';

class LoggerService
{
    static DateFormat _dateFormat = DateFormat('HH:mm:ss');

    bool isEnabled;

    LoggerService(bool startEnabled)
        : isEnabled = startEnabled;

    void logDebug(String message)
    => _log('Debug: ' + message);

    void logInfo(String message)
    => _log('Info:  ' + message);

    void logWarning(String message)
    => _log('Warn:  ' + message);

    void logError(String message)
    => _log('ERROR: ' + message);

    void _log(String message)
    {
        if (isEnabled)
            print(_dateFormat.format(DateTime.now()) + ' ' + message);
    }
}
