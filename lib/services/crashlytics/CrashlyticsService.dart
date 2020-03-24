import 'dart:async';

import 'package:eggnstone_flutter/services/logger/LoggerMixin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_crashlytics/flutter_crashlytics.dart';

/// Requires [ILoggerService]
class CrashlyticsService
    with LoggerMixin
{
    final FlutterCrashlytics _flutterCrashlytics;

    bool _isEnabled;

    CrashlyticsService._internal(this._flutterCrashlytics, this._isEnabled)
    {
        assert(logger != null, 'Unable to find via GetIt: Logger');
    }

    /// Requires [LoggerService]
    static Future<CrashlyticsService> create(bool startEnabled)
    => CrashlyticsService.createMockable(FlutterCrashlytics(), startEnabled);

    /// Requires [LoggerService]
    static Future<CrashlyticsService> createMockable(FlutterCrashlytics flutterCrashlytics, bool startEnabled)
    async
    {
        var instance = CrashlyticsService._internal(flutterCrashlytics, startEnabled);
        await instance._init();
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
            {
                // Report to the application zone to report to Crashlytics.
                Zone.current.handleUncaughtError(details.exception, details.stack);
            }
        };

        if (_isEnabled)
            if (kIsWeb)
                logger.logDebug('Crashlytics not yet supported for web: not calling FlutterCrashlytics.initialize()');
            else
                await _flutterCrashlytics.initialize();
    }

    void setEnabled(bool newValue)
    => _isEnabled = newValue;

    void run(Widget app)
    {
        runZoned<Future<Null>>(()
        async
        {
            runApp(app);
        },
            onError: (dynamic error, StackTrace stackTrace)
            async
            {
                logger.logError('##################################################');
                logger.logError(error.toString());
                logger.logError(stackTrace.toString());
                logger.logError('##################################################');

                if (_isEnabled)
                    if (kIsWeb)
                        logger.logDebug('Crashlytics not yet supported for web: not calling FlutterCrashlytics.reportCrash()');
                    else
                        await _flutterCrashlytics.reportCrash(error, stackTrace, forceCrash: false);
            });
    }

/*
    void reportNonFatalCrash(dynamic e, StackTrace stackTrace)
    {
        if (_isEnabled)
        {
            _flutterCrashlytics.log('Crashlytics.reportNonFatalCrash: ' + e.toString());
            _flutterCrashlytics.reportCrash(e, stackTrace);
        }
    }
*/
}
