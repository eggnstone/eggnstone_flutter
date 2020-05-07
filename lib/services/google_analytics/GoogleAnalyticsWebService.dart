import 'dart:async';

import 'package:eggnstone_flutter/eggnstone_flutter.dart';
import 'package:firebase/firebase.dart' as FirebaseWeb;

/// Requires [LoggerService]
class GoogleAnalyticsService
    with LoggerMixin
    implements IGoogleAnalyticsService
{
    static const String EVENT_NAME__TUTORIAL_BEGIN = 'tutorial_begin';
    static const String EVENT_NAME__TUTORIAL_COMPLETE = 'tutorial_complete';
    static const int MAX_EVENT_NAME_LENGTH = 40;
    static const int MAX_PARAM_NAME_LENGTH = 40;
    static const int MAX_PARAM_VALUE_LENGTH = 100;

    final FirebaseWeb.Analytics _firebaseAnalytics;

    bool _isEnabled;
    String _currentScreen;

    GoogleAnalyticsService._internal(this._firebaseAnalytics, this._isEnabled)
    {
        assert(logger != null, 'Unable to find via GetIt: Logger');
        //logger.logDebug('AnalyticsService for Web created.');
    }

    /// Requires [LoggerService]
    static Future<IGoogleAnalyticsService> create(bool startEnabled)
    => GoogleAnalyticsService.createMockable(FirebaseWeb.analytics(), startEnabled);

    /// Requires [LoggerService]
    static Future<IGoogleAnalyticsService> createMockable(FirebaseWeb.Analytics firebaseWebAnalytics, bool startEnabled)
    async
    {
        var instance = GoogleAnalyticsService._internal(firebaseWebAnalytics, startEnabled);
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
        logger.logInfo((_isEnabled ? 'GoogleAnalytics' : 'Disabled-GoogleAnalytics') + ': setCurrentScreen: ' + newValue);

        _currentScreen = newValue;

        if (_isEnabled)
            _firebaseAnalytics.setCurrentScreen(newValue);
    }

    @override
    Future track(String name, [Map<String, dynamic> params])
    async
    {
        assert(name != null);

        if (name.length == 0)
            return;

        // Check limits (https://support.google.com/firebase/answer/9237506?hl=en)

        if (name.length > GoogleAnalyticsService.MAX_EVENT_NAME_LENGTH)
            name = name.substring(0, GoogleAnalyticsService.MAX_EVENT_NAME_LENGTH);

        Map<String, dynamic> safeParams;
        if (params != null)
        {
            safeParams = {};

            for (String key in params.keys)
            {
                Object value = params[key];
                if (value == null)
                    continue;

                if (key.length > GoogleAnalyticsService.MAX_PARAM_NAME_LENGTH)
                    key = key.substring(0, GoogleAnalyticsService.MAX_PARAM_NAME_LENGTH);

                if (value is String)
                {
                    String valueString = value;
                    if (valueString.length > GoogleAnalyticsService.MAX_PARAM_VALUE_LENGTH)
                        valueString = valueString.substring(0, GoogleAnalyticsService.MAX_PARAM_VALUE_LENGTH);

                    safeParams[key] = valueString;
                }
                else
                    safeParams[key] = value;
            }
        }

        String s = (_isEnabled ? 'GoogleAnalytics' : 'Disabled-GoogleAnalytics') + ': ' + name;

        if (safeParams != null)
            for (String key in safeParams.keys)
                s += ' $key=${safeParams[key]}';

        logger.logInfo(s);

        if (_isEnabled)
            _firebaseAnalytics.logEvent(name, safeParams);
    }

    @override
    void trackAction(String name, String action)
    => track(name, {'Action': action});

    @override
    void trackValue(String name, Object value)
    => track(name, {'Value': value});

    @override
    void trackActionAndValue(String name, String action, Object value)
    => track(name, {'Action': action, 'Value': value});

    @override
    Future trackWarning(String message, [Map<String, dynamic> params])
    async
    {
        logger.logInfo((_isEnabled ? 'GoogleAnalytics' : 'Disabled-GoogleAnalytics') + ': trackWarning: $message / $params');

        if (params == null)
            params = {};

        params['Message'] = message;

        if (_isEnabled)
            await track('Warning', params);
    }

    @override
    Future trackError(String message, [Map<String, dynamic> params])
    async
    {
        logger.logInfo((_isEnabled ? 'GoogleAnalytics' : 'Disabled-GoogleAnalytics') + ': trackError: $message / $params');

        if (params == null)
            params = {};

        params['Message'] = message;

        if (_isEnabled)
            await track('Error', params);
    }

    @override
    Future trackWarningWithException(String source, dynamic e, dynamic stackTrace)
    async
    {
        logger.logInfo((_isEnabled ? 'GoogleAnalytics' : 'Disabled-GoogleAnalytics') + ': trackWarningWithException: $source / $e / $stackTrace');

        if (_isEnabled)
            await track('Warning', {'Message': e.toString(), 'StackTrace': stackTrace?.toString()});
    }

    @override
    Future trackErrorWithException(String source, dynamic e, dynamic stackTrace)
    async
    {
        logger.logInfo((_isEnabled ? 'GoogleAnalytics' : 'Disabled-GoogleAnalytics') + ': trackErrorWithException: $source / $e / $stackTrace');

        if (_isEnabled)
            await track('Error', {'Message': e.toString(), 'StackTrace': stackTrace?.toString()});
    }

    @override
    void setUserProperty(String name, String value, {bool force = false})
    {
        logger.logInfo((_isEnabled ? 'GoogleAnalytics' : 'Disabled-GoogleAnalytics') + ': setUserProperty: name=$name value=$value force=$force');

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
        logger.logInfo((_isEnabled ? 'GoogleAnalytics' : 'Disabled-GoogleAnalytics') + ': setUserId: $value');

        if (_isEnabled)
            _firebaseAnalytics.setUserId(value);
    }
}
