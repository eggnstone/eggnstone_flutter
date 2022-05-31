import 'package:flutter/widgets.dart';

abstract class ICrashlyticsService
{
    @Deprecated('Use runAsync instead.')
    void run(Widget app);

    Future<void> runAsync(Function prepareFunction, Widget app);

    void setUserId(String id);

    void setUserProperty(String key, String value);

    void recordError(Object error, StackTrace stackTrace);

// TODO: log()
// TODO: crash()
}
