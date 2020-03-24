import 'dart:async';

import 'package:eggnstone_flutter/services/logger/LoggerMixin.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Requires [ILoggerService]
class CrashlyticsService
    with LoggerMixin
{
    final Crashlytics _crashlytics;

    bool _isEnabled;

    CrashlyticsService._internal(this._crashlytics, this._isEnabled)
    {
        assert(logger != null, 'Unable to find via GetIt: Logger');
    }

    /// Requires [LoggerService]
    static Future<CrashlyticsService> create(bool startEnabled)
    => CrashlyticsService.createMockable(Crashlytics(), startEnabled);

    /// Requires [LoggerService]
    static Future<CrashlyticsService> createMockable(Crashlytics crashlytics, bool startEnabled)
    async
    {
        var instance = CrashlyticsService._internal(crashlytics, startEnabled);
        instance._init();
        return instance;
    }

    Future<void> _init()
    async
    {
        FlutterError.onError = (FlutterErrorDetails details)
        {
            logger.logError('##################################################');
            logger.logError(_isEnabled ? 'Crashlytics:' : 'Disabled-Crashlytics:');

            if (logger.isEnabled)
            {
                // TODO: move to LoggerService
                FlutterError.dumpErrorToConsole(details);
            }

            if (details.stack == null)
                logger.logError('No stacktrace available.');
            else
                logger.logError(details.stack.toString());

            logger.logError('##################################################');

            if (_isEnabled)
                if (kIsWeb)
                    logger.logDebug('Crashlytics not yet supported for web: not calling Crashlytics.recordFlutterError()');
                else
                    _crashlytics.recordFlutterError(details);
        };
    }

    void setEnabled(bool newValue)
    => _isEnabled = newValue;

    void run(Widget app)
    {
        runZoned<Future<void>>(()
        async
        {
            runApp(app);
        },
            onError: (dynamic exception, StackTrace stackTrace)
            {
                logger.logError('##################################################');
                logger.logError(exception.toString());
                logger.logError(stackTrace.toString());
                logger.logError('##################################################');

                if (_isEnabled)
                    if (kIsWeb)
                        logger.logDebug('Crashlytics not yet supported for web: not calling Crashlytics.recordError()');
                    else
                        _crashlytics.recordError(exception, stackTrace);
            });
    }
}
