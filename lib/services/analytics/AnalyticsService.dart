import 'dart:async';

import 'package:eggnstone_flutter/eggnstone_flutter.dart';
import 'package:eggnstone_flutter/services/logger/LoggerMixin.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';

/// Requires [LoggerService]
class AnalyticsService
    with LoggerMixin
{
    static const String EVENT_NAME__TUTORIAL_BEGIN = 'tutorial_begin';
    static const String EVENT_NAME__TUTORIAL_COMPLETE = 'tutorial_complete';
    static const int MAX_EVENT_NAME_LENGTH = 40;
    static const int MAX_PARAM_NAME_LENGTH = 40;
    static const int MAX_PARAM_VALUE_LENGTH = 100;

    final FirebaseAnalytics _firebaseAnalytics;
    final FirebaseAnalyticsObserver _firebaseAnalyticsObserver;

    bool _isEnabled;
    String _currentScreen;

    AnalyticsService._internal(this._firebaseAnalytics, this._firebaseAnalyticsObserver, this._isEnabled)
    {
        assert(logger != null, 'Unable to find via GetIt: Logger');
    }

    /// Requires [LoggerService]
    static Future<AnalyticsService> create(bool startEnabled)
    => AnalyticsService.createMockable(FirebaseAnalytics(), startEnabled);

    /// Requires [LoggerService]
    static Future<AnalyticsService> createMockable(FirebaseAnalytics firebaseAnalytics, bool startEnabled)
    async
    {
        var instance = AnalyticsService._internal(firebaseAnalytics, FirebaseAnalyticsObserver(analytics: firebaseAnalytics), startEnabled);

        if (kIsWeb)
            instance.logger.logDebug('Analytics not fully supported for web: not calling FirebaseAnalytics.setAnalyticsCollectionEnabled()');
        else
            instance._firebaseAnalytics.setAnalyticsCollectionEnabled(startEnabled);

        return instance;
    }

    FirebaseAnalyticsObserver getObserver()
    => _firebaseAnalyticsObserver;

    bool get isEnabled
    => _isEnabled;

    set isEnabled(bool newValue)
    {
        _isEnabled = newValue;

        if (kIsWeb)
            logger.logDebug('Analytics not fully supported for web: not calling FirebaseAnalytics.setAnalyticsCollectionEnabled()');
        else
            _firebaseAnalytics.setAnalyticsCollectionEnabled(newValue);
    }

    String get currentScreen
    => _currentScreen;

    set currentScreen(String newValue)
    {
        logger.logInfo((_isEnabled ? 'Analytics' : 'Disabled-Analytics') + ': setCurrentScreen: ' + newValue);

        _currentScreen = newValue;

        if (_isEnabled)
            if (kIsWeb)
                logger.logDebug('Analytics not fully supported for web: not calling FirebaseAnalytics.setCurrentScreen()');
            else
                _firebaseAnalytics.setCurrentScreen(screenName: newValue, screenClassOverride: newValue);
    }

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
                    name: 'AnalyticsError',
                    parameters: {
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
                            name: 'AnalyticsError',
                            parameters: {
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
                            name: 'AnalyticsError',
                            parameters: {
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
                _firebaseAnalytics.logEvent(name: name, parameters: params);
        }
    }

    void logAction(String name, String action)
    => log(name, {'Action': action});

    void logValue(String name, Object value)
    => log(name, {'Value': value});

    void logActionAndValue(String name, String action, Object value)
    => log(name, {'Action': action, 'Value': value});

    void setUserProperty(String name, String value, {bool force = false})
    {
        logger.logInfo((_isEnabled ? 'Analytics' : 'Disabled-Analytics') + ': setUserProperty: name=$name value=$value force=$force');

        if (_isEnabled || force)
            _firebaseAnalytics.setUserProperty(name: name, value: value);
    }

    void setUserId(String value)
    {
        logger.logInfo((_isEnabled ? 'Analytics' : 'Disabled-Analytics') + ': setUserId: $value');

        if (_isEnabled)
            _firebaseAnalytics.setUserId(value);
    }
}
