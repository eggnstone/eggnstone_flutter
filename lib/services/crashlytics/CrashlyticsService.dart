import 'dart:async';

import 'package:eggnstone_flutter/services/logger/LoggerMixin.dart';
import 'package:eggnstone_flutter/tools/DartTools.dart';
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
            logger.logInfo('FlutterError.onError');
            if (DartTools.isDebugBuild())
            {
                // In development mode simply print to console.
                logger.logError('##################################################');
                logger.logError(_isEnabled ? 'Crashlytics: ' : 'Dummy-Crashlytics: ');

                FlutterError.dumpErrorToConsole(details);

                if (details.stack == null)
                    logger.logInfo('No stacktrace available.');
                else
                    logger.logInfo(details.stack.toString());

                logger.logError('##################################################');
            }
            else
            {
                // In production mode report to the application zone to report to Crashlytics.
                if (_isEnabled)
                    Zone.current.handleUncaughtError(details.exception, details.stack);
            }
        };

        if (_isEnabled)
            await _flutterCrashlytics.initialize();
    }

    void setEnabled(bool newValue)
    {
        logger.logInfo('Crashlytics.setEnabled($newValue)');
        _isEnabled = newValue;
    }

    void run(Widget app)
    {
        if (_isEnabled)
            runZoned<Future<Null>>(()
            async
            {
                runApp(app);
            },
                onError: (dynamic error, StackTrace stackTrace)
                async
                {
                    // Whenever an error occurs, call the `reportCrash` function. This will send
                    // Dart errors to our dev console or Crashlytics depending on the environment.
                    if (DartTools.isDebugBuild())
                    {
                        logger.logError('##################################################');
                        logger.logError(error.toString());
                        logger.logError(stackTrace.toString());
                        logger.logError('##################################################');
                    }
                    else
                        await _flutterCrashlytics.reportCrash(error, stackTrace, forceCrash: false);
                });
        else
            runApp(app);
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
