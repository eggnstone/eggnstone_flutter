import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import '../logger/LoggerMixin.dart';

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

    /// Requires [LoggerService]
    factory AnalyticsService(bool startEnabled)
    => AnalyticsService.mockable(FirebaseAnalytics(), startEnabled);

    /// Requires [LoggerService]
    AnalyticsService.mockable(FirebaseAnalytics firebaseAnalytics, bool startEnabled)
        : _firebaseAnalytics = firebaseAnalytics,
            _firebaseAnalyticsObserver = FirebaseAnalyticsObserver(analytics: firebaseAnalytics)
    {
        assert(logger != null, 'Unable to find via GetIt: Logger');
        _isEnabled = startEnabled;
        _firebaseAnalytics.setAnalyticsCollectionEnabled(startEnabled);
    }

    FirebaseAnalyticsObserver getObserver()
    => _firebaseAnalyticsObserver;

    bool get isEnabled
    => _isEnabled;

    set isEnabled(bool newValue)
    {
        logger.logInfo('Analytics.isEnabled($newValue)');
        _isEnabled = newValue;
        _firebaseAnalytics.setAnalyticsCollectionEnabled(newValue);
    }

    String get currentScreen
    => _currentScreen;

    set currentScreen(String newValue)
    {
        _currentScreen = newValue;

        String s = _isEnabled ? 'Analytics: ' : 'Dummy-Analytics: ';
        logger.logInfo(s + 'setCurrentScreen: ' + newValue);

        if (_isEnabled)
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
            String s = (_isEnabled ? 'Analytics: ' : 'Dummy-Analytics: ') + name;

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
        if (_isEnabled || force)
            _firebaseAnalytics.setUserProperty(name: name, value: value);

        logger.logInfo((_isEnabled ? 'Analytics' : 'Dummy-Analytics') + ': setUserProperty: name=$name value=$value force=$force');
    }

    void setUserId(String value)
    {
        if (_isEnabled)
            _firebaseAnalytics.setUserId(value);

        logger.logInfo((_isEnabled ? 'Analytics' : 'Dummy-Analytics') + ': setUserId: $value');
    }
}
