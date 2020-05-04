import 'dart:async';

import 'package:eggnstone_flutter/eggnstone_flutter.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

typedef CrashReporterCallback = Function(Map<String, dynamic> params);

/// Requires [LoggerService]
class CrashlyticsService
    with LoggerMixin
{
    static const String ANALYTICS_KEY__CRASHLYTICS_FOR_WEB = 'CrashlyticsForWeb';

    final Crashlytics _crashlytics;
    final CrashReporterCallback _additionalCrashReporterCallback;

    bool _isEnabled;

    CrashlyticsService._internal(this._crashlytics, this._additionalCrashReporterCallback, this._isEnabled)
    {
        assert(logger != null, 'Unable to find via GetIt: Logger');
    }

    /// Requires [LoggerService]
    static Future<CrashlyticsService> create(bool startEnabled)
    => CrashlyticsService.createMockable(Crashlytics(), null, startEnabled);

    /// Requires [LoggerService]
    static Future<CrashlyticsService> createMockable(Crashlytics crashlytics, CrashReporterCallback alternativeCrashReporter, bool startEnabled)
    async
    {
        var instance = CrashlyticsService._internal(crashlytics, alternativeCrashReporter, startEnabled);
        instance._init();
        return instance;
    }

    void _init()
    {
        FlutterError.onError = (FlutterErrorDetails details)
        {
            logger.logError('##################################################');
            logger.logError('# CrashlyticsService/FlutterError.onError ');

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
                try
                {
                    _crashlytics.recordFlutterError(details);
                }
                catch (e2, stackTrace2)
                {
                    logger.logError('##################################################');
                    logger.logError('# CrashlyticsService/FlutterError.onError._crashlytics.recordFlutterError');
                    logger.logError(e2.toString());

                    if (stackTrace2 == null)
                        logger.logError('No stacktrace available.');
                    else
                        logger.logError(stackTrace2.toString());

                    logger.logError('##################################################');
                }

                if (_additionalCrashReporterCallback != null)
                {
                    Map<String, dynamic> map =
                    {
                        'Exception': details.exception.toString()
                    };

                    if (details.stack != null)
                        map['StackTrace'] = details.stack.toString();

                    try
                    {
                        _additionalCrashReporterCallback(map);
                    }
                    catch (e2, stackTrace2)
                    {
                        logger.logError('##################################################');
                        logger.logError('# CrashlyticsService/FlutterError.onError._additionalCrashReporterCallback');
                        logger.logError(e2.toString());

                        if (stackTrace2 == null)
                            logger.logError('No stacktrace available.');
                        else
                            logger.logError(stackTrace2.toString());

                        logger.logError('##################################################');
                    }
                }
            }
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
            onError: (e, stackTrace)
            {
                logger.logError('##################################################');
                logger.logError('# CrashlyticsService.run.runZoned.onError');
                logger.logError(e.toString());

                if (stackTrace == null)
                    logger.logError('No stacktrace available.');
                else
                    logger.logError(stackTrace.toString());

                logger.logError('##################################################');

                if (_isEnabled)
                {
                    try
                    {
                        _crashlytics.recordError(e, stackTrace);
                    }
                    catch (e2, stackTrace2)
                    {
                        logger.logError('##################################################');
                        logger.logError('# CrashlyticsService.run.runZoned.onError._crashlytics.recordError');
                        logger.logError(e2.toString());

                        if (stackTrace2 == null)
                            logger.logError('No stacktrace available.');
                        else
                            logger.logError(stackTrace2.toString());

                        logger.logError('##################################################');
                    }

                    if (_additionalCrashReporterCallback != null)
                    {
                        Map<String, dynamic> map =
                        {
                            'Exception': e.toString()
                        };

                        if (stackTrace != null)
                            map['StackTrace'] = stackTrace.toString();

                        try
                        {
                            _additionalCrashReporterCallback(map);
                        }
                        catch (e2, stackTrace2)
                        {
                            logger.logError('##################################################');
                            logger.logError('# CrashlyticsService.run.runZoned.onError._additionalCrashReporterCallback');
                            logger.logError(e2.toString());

                            if (stackTrace2 == null)
                                logger.logError('No stacktrace available.');
                            else
                                logger.logError(stackTrace2.toString());

                            logger.logError('##################################################');
                        }
                    }
                }
            });
    }
}
