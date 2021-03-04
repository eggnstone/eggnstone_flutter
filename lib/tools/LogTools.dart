import 'package:intl/intl.dart';

DateFormat _dateFormat = DateFormat('HH:mm:ss');

bool isLoggerEnabled = true;

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
    if (isLoggerEnabled)
        print(_dateFormat.format(DateTime.now()) + ' ' + message);
}
