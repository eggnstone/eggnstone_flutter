import 'dart:async';

import 'package:eggnstone_flutter/eggnstone_flutter.dart';
import 'package:firebase/firebase.dart' as FirebaseWeb;

/// Requires [LoggerService]
class AnalyticsService
    with LoggerMixin
    implements IAnalyticsService
{
    static const String EVENT_NAME__TUTORIAL_BEGIN = 'tutorial_begin';
    static const String EVENT_NAME__TUTORIAL_COMPLETE = 'tutorial_complete';
    static const int MAX_EVENT_NAME_LENGTH = 40;
    static const int MAX_PARAM_NAME_LENGTH = 40;
    static const int MAX_PARAM_VALUE_LENGTH = 100;

    final FirebaseWeb.Analytics _firebaseAnalytics;

    //final RouteObserver<PageRoute<dynamic>> _firebaseAnalyticsObserver;

    bool _isEnabled;
    String _currentScreen;

    AnalyticsService._internal(this._firebaseAnalytics, /*this._firebaseAnalyticsObserver,*/ this._isEnabled)
    {
        assert(logger != null, 'Unable to find via GetIt: Logger');
        //logger.logDebug('AnalyticsService for Web created.');
    }

    /// Requires [LoggerService]
    static Future<IAnalyticsService> create(bool startEnabled)
    => AnalyticsService.createMockable(FirebaseWeb.analytics(), startEnabled);

    /// Requires [LoggerService]
    static Future<IAnalyticsService> createMockable(FirebaseWeb.Analytics firebaseWebAnalytics, bool startEnabled)
    async
    {
        //var firebaseWebAnalyticsObserver = FirebaseWebAnalyticsObserver(analytics: firebaseWebAnalytics);
        var instance = AnalyticsService._internal(firebaseWebAnalytics, /*firebaseWebAnalyticsObserver,*/ startEnabled);
        instance._firebaseAnalytics.setAnalyticsCollectionEnabled(startEnabled);
        return instance;
    }

    @override
    bool get isEnabled
    => _isEnabled;

    @override
    set isEnabled(bool newValue)
    {
        _isEnabled = newValue;
        _firebaseAnalytics.setAnalyticsCollectionEnabled(newValue);
    }

    @override
    String get currentScreen
    => _currentScreen;

    @override
    set currentScreen(String newValue)
    {
        logger.logInfo((_isEnabled ? 'Analytics' : 'Disabled-Analytics') + ': setCurrentScreen: ' + newValue);

        _currentScreen = newValue;

        if (_isEnabled)
        {
            _firebaseAnalytics.setCurrentScreen(newValue);
            //_firebaseAnalytics.setCurrentScreen(screenName: newValue, screenClassOverride: newValue);
        }
    }

    /*@override
    RouteObserver<PageRoute<dynamic>> getObserver()
    => _firebaseAnalyticsObserver;*/

    @override
    void log(String name, [Map<String, dynamic> params])
    {
        assert(name != null);

        if (name.length == 0)
            return;

        if (params != null)
        {
            // remove null params as they prevent the logging
            List<String> keys = params.keys.toList(growable: false);
            for (int i = 0; i < keys.length; i++)
            {
                String key = keys[i];
                if (params[key] == null)
                {
                    params.remove(key);
                    logger.logInfo('Analytics: Removed key with null value: $key');
                }
            }
        }

        // Check limits (https://support.google.com/firebase/answer/9237506?hl=en)
        bool foundError = false;

        if (name.length > AnalyticsService.MAX_EVENT_NAME_LENGTH)
        {
            foundError = true;
            logger.logError('##################################################');
            logger.logError('# Error: Event name "$name" is too long! Is=${name.length} Max=${AnalyticsService.MAX_EVENT_NAME_LENGTH}');

            if (_isEnabled)
                _firebaseAnalytics.logEvent(
                    'AnalyticsError',
                    {
                        'EventName': name.length <= AnalyticsService.MAX_PARAM_VALUE_LENGTH ? name : name.substring(0, AnalyticsService.MAX_PARAM_VALUE_LENGTH),
                        'Message': 'Event name is too long! Is=${name.length} Max=${AnalyticsService.MAX_EVENT_NAME_LENGTH}'
                    }
                );
        }

        if (params != null)
        {
            for (String key in params.keys)
            {
                if (key.length > AnalyticsService.MAX_PARAM_NAME_LENGTH)
                {
                    foundError = true;
                    logger.logError('##################################################');
                    logger.logError('# Error: Param name "$key" is too long! Is=${key.length} Max=${AnalyticsService.MAX_PARAM_NAME_LENGTH}');

                    if (_isEnabled)
                        _firebaseAnalytics.logEvent(
                            'AnalyticsError',
                            {
                                'EventName': name.length <= AnalyticsService.MAX_PARAM_VALUE_LENGTH ? name : name.substring(0, AnalyticsService.MAX_PARAM_VALUE_LENGTH),
                                'ParamName': key.length <= AnalyticsService.MAX_PARAM_VALUE_LENGTH ? key : key.substring(0, AnalyticsService.MAX_PARAM_VALUE_LENGTH),
                                'Message': 'Param name is too long! Is=${key.length} Max=${AnalyticsService.MAX_PARAM_NAME_LENGTH}'
                            }
                        );
                }

                Object value = params[key];
                if (value is String && value.length > AnalyticsService.MAX_PARAM_VALUE_LENGTH)
                {
                    foundError = true;
                    logger.logError('##################################################');
                    logger.logError('# Error: Param value of "$key" is too long! Is=${value.length} Max=${AnalyticsService.MAX_PARAM_VALUE_LENGTH} Value: $value');

                    if (_isEnabled)
                        _firebaseAnalytics.logEvent(
                            'AnalyticsError',
                            {
                                'EventName': name.length <= AnalyticsService.MAX_PARAM_VALUE_LENGTH ? name : name.substring(0, AnalyticsService.MAX_PARAM_VALUE_LENGTH),
                                'ParamName': key.length <= AnalyticsService.MAX_PARAM_VALUE_LENGTH ? key : key.substring(0, AnalyticsService.MAX_PARAM_VALUE_LENGTH),
                                'ParamValue': value.substring(0, AnalyticsService.MAX_PARAM_VALUE_LENGTH),
                                'Message': 'Param value is too long! Is=${value.length} Max=${AnalyticsService.MAX_PARAM_VALUE_LENGTH}'
                            }
                        );
                }
            }
        }

        if (foundError == false)
        {
            String s = (_isEnabled ? 'Analytics' : 'Disabled-Analytics') + ': ' + name;

            if (params != null)
                for (String key in params.keys)
                    s += ' $key=${params[key]}';

            logger.logInfo(s);

            if (_isEnabled)
                _firebaseAnalytics.logEvent(name, params);
        }
    }

    @override
    void logAction(String name, String action)
    => log(name, {'Action': action});

    @override
    void logValue(String name, Object value)
    => log(name, {'Value': value});

    @override
    void logActionAndValue(String name, String action, Object value)
    => log(name, {'Action': action, 'Value': value});

    @override
    void setUserProperty(String name, String value, {bool force = false})
    {
        logger.logInfo((_isEnabled ? 'Analytics' : 'Disabled-Analytics') + ': setUserProperty: name=$name value=$value force=$force');

        if (_isEnabled || force)
        {
            //_firebaseAnalytics.setUserProperty(name: name, value: value);
            //FirebaseWeb.CustomParams myCustomParams = MyCustomParams(name, value);
            //_firebaseAnalytics.setUserProperties(myCustomParams);
            //_firebaseAnalytics.setUserProperties({name:value} as  FirebaseWeb.CustomParams);
            logger.logWarning('setUserProperty() is not available for Web.');
        }
    }

    @override
    void setUserId(String value)
    {
        logger.logInfo((_isEnabled ? 'Analytics' : 'Disabled-Analytics') + ': setUserId: $value');

        if (_isEnabled)
            _firebaseAnalytics.setUserId(value);
    }
}

/*class FirebaseWebAnalyticsObserver extends RouteObserver<PageRoute<dynamic>>
{
    final FirebaseWeb.Analytics analytics;

    FirebaseWebAnalyticsObserver({@required this.analytics});
}*/

/*
class MyCustomParamsJsImpl extends analytics_interop.CustomParamsJsImpl
{
    final String name;
    final String value;

    MyCustomParamsJsImpl(this.name, this.value);
}

class MyCustomParams
    implements FirebaseWeb.CustomParams
{
    final String name;
    final Object value;

    MyCustomParams(this.name, this.value);

    @override
    analytics_interop.CustomParamsJsImpl get jsObject
    {
        return MyCustomParamsJsImpl(name, value);
    }
}
*/
