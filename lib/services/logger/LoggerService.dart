import 'package:intl/intl.dart';

class LoggerService
{
    static DateFormat _dateFormat = DateFormat('HH:mm:ss');

    bool _isEnabled;

    LoggerService(bool isEnabled)
        : _isEnabled = isEnabled;

    @override
    // ignore: unnecessary_getters_setters
    bool get isEnabled
    => _isEnabled;

    @override
    // ignore: unnecessary_getters_setters
    set isEnabled(bool newValue)
    => _isEnabled = newValue;

    @override
    void logDebug(String message)
    => _log('Debug: ' + message);

    @override
    void logInfo(String message)
    => _log('Info:  ' + message);

    @override
    void logWarning(String message)
    => _log('Warn:  ' + message);

    @override
    void logError(String message)
    => _log('ERROR: ' + message);

    void _log(String message)
    {
        if (_isEnabled)
            print(_dateFormat.format(DateTime.now()) + ' ' + message);
    }
}
