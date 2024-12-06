import 'package:eggnstone_dart/eggnstone_dart.dart';

import 'ILoggerAnalyticsService.dart';

class LoggerAnalyticsService implements ILoggerAnalyticsService
{
    String _currentScreen = '';

    @override
    String get currentScreen
    {
        logDebug('### get currentScreen: $_currentScreen');
        return _currentScreen;
    }

    @override
    set currentScreen(String value)
    {
        logDebug('### set currentScreen: $value');
        _currentScreen = value;
    }

    bool _isDebugEnabled = false;

    @override
    bool get isDebugEnabled
    {
        logDebug('### get isDebugEnabled: $_isDebugEnabled');
        return _isDebugEnabled;
    }

    @override
    set isDebugEnabled(bool value)
    {
        logDebug('### set isDebugEnabled: $value');
        _isDebugEnabled = value;
    }

    bool _isEnabled = false;

    @override
    bool get isEnabled
    {
        logDebug('### get isEnabled: $_isEnabled');
        return _isEnabled;
    }

    @override
    set isEnabled(bool value)
    {
        logDebug('### set isEnabled: $value');
        _isEnabled = value;
    }

    @override
    void setUserId(String id)
    {
        logDebug('### setUserId: $id');
    }

    @override
    void setUserProperty(String key, String value)
    {
        logDebug('### setUserProperty: $key, $value');
    }

    @override
    void track(String name, [Map<String, Object>? params])
    {
        logDebug('### track: $name');
    }

    @override
    void trackAction(String name, String action)
    {
        logDebug('### trackAction: $name, $action');
    }

    @override
    void trackActionAndNumberValue(String name, String action, Object numberValue)
    {
        logDebug('### trackActionAndNumberValue: $name, $action, $numberValue');
    }

    @override
    void trackActionAndTextValue(String name, String action, Object textValue)
    {
        logDebug('### trackActionAndTextValue: $name, $action, $textValue');
    }

    @override
    void trackActionAndValue(String name, String action, Object value)
    {
        logDebug('### trackActionAndValue: $name, $action, $value');
    }

    @override
    void trackError(String message, [Map<String, Object>? params])
    {
        logDebug('### trackError: $message');
    }

    @override
    void trackErrorWithException(String source, dynamic e, [StackTrace? stackTrace])
    {
        logDebug('### trackErrorWithException: $source');
    }

    @override
    void trackNumberValue(String name, Object numberValue)
    {
        logDebug('### trackNumberValue: $name, $numberValue');
    }

    @override
    void trackTextValue(String name, Object textValue)
    {
        logDebug('### trackTextValue: $name, $textValue');
    }

    @override
    void trackValue(String name, Object value)
    {
        logDebug('### trackValue: $name, $value');
    }

    @override
    void trackWarning(String message, [Map<String, Object>? params])
    {
        logDebug('### trackWarning: $message');
    }

    @override
    void trackWarningWithException(String source, dynamic e, [StackTrace? stackTrace])
    {
        logDebug('### trackWarningWithException: $source');
    }
}
