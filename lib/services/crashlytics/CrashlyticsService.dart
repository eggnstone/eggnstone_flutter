import 'dart:async';

import 'package:eggnstone_flutter/eggnstone_flutter.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Requires [IAnalyticsService, LoggerService]
class CrashlyticsService
    with AnalyticsMixin, LoggerMixin
{
    static const String ANALYTICS_KEY__CRASHLYTICS_FOR_WEB = 'CrashlyticsForWeb';

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
                {
                    logger.logDebug('Crashlytics not yet supported for web: not calling Crashlytics.recordFlutterError()');

                    Map<String, dynamic> map = {};

                    if (details.exception != null)
                        map['Exception'] = StringTools.shortenForAnalytics(details.exception.toString());

                    if (details.stack != null)
                        map['StackTrace'] = StringTools.shortenForAnalytics(details.stack.toString());

                    analytics.log(ANALYTICS_KEY__CRASHLYTICS_FOR_WEB, map);
                }
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
                    {
                        logger.logDebug('Crashlytics not yet supported for web: not calling Crashlytics.recordError()');

                        Map<String, dynamic> map = {};

                        if (exception != null)
                            map['Exception'] = StringTools.shortenForAnalytics(exception.toString());

                        if (stackTrace != null)
                            map['StackTrace'] = StringTools.shortenForAnalytics(stackTrace.toString());

                        analytics.log(ANALYTICS_KEY__CRASHLYTICS_FOR_WEB, map);
                    }
                    else
                        _crashlytics.recordError(exception, stackTrace);
            });
    }
}
