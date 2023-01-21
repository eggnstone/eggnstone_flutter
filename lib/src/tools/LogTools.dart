import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

DateFormat _dateFormat = DateFormat('HH:mm:ss');

bool isLoggerEnabled = true;
bool useNewLogger = kDebugMode;
String? logColors;

void logDebug(String message)
=> _log('Debug', message);

void logInfo(String message)
=> _log('Info', message);

void logWarning(String message)
=> _log('Warn', message);

void logError(String message, [Object? error])
=> _log('Error', message, error);

void _log(String level, String message, [Object? error])
{
    if (!isLoggerEnabled)
        return;

    if (useNewLogger && !kIsWeb)
    {
        final String levelPadded = level.padRight(5);
        developer.log('${_dateFormat.format(DateTime.now())} $message', name: levelPadded, error: error);
    }
    else
    {
        final String levelWithColonPadded = '$level:'.padRight(6);
        String messageForPrint = '${_dateFormat.format(DateTime.now())} $levelWithColonPadded $message';

        if (logColors == 'Ansi')
        {
            switch (level)
            {
                case 'Debug':
                //messageForPrint = '\x1B[32m$messageForPrint\x1B[0m';
                    break;
                case 'Info':
                    messageForPrint = '\x1B[34m$messageForPrint\x1B[0m';
                    break;
                case 'Warn':
                    messageForPrint = '\x1B[33m$messageForPrint\x1B[0m';
                    break;
                case 'Error':
                    messageForPrint = '\x1B[31m$messageForPrint\x1B[0m';
                    break;
            }
        }

        // ignore: avoid_print
        print(messageForPrint);
        if (error != null)
        {
            // ignore: avoid_print
            print('         $error');
        }
    }
}
