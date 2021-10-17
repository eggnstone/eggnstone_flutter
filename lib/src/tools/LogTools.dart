import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

DateFormat _dateFormat = DateFormat('HH:mm:ss');

bool isLoggerEnabled = true;
bool useNewLogger = true;

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
        // ignore: prefer_interpolation_to_compose_strings
        developer.log(_dateFormat.format(DateTime.now()) + ' ' + message, name: levelPadded, error: error);
    }
    else
    {
        // ignore: prefer_interpolation_to_compose_strings
        final String levelWithColonPadded = (level + ':').padRight(6);
        // ignore: prefer_interpolation_to_compose_strings, avoid_print
        print(_dateFormat.format(DateTime.now()) + ' ' + levelWithColonPadded + ' ' + message);
        if (error != null)
        {
            // ignore: avoid_print
            print('         $error');
        }
    }
}
