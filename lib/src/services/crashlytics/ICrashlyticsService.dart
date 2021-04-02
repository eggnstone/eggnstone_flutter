import 'package:flutter/widgets.dart';

abstract class ICrashlyticsService
{
    void run(Widget app);

    void setUserId(String value);

    void setUserProperty(String key, String value);

// TODO: log()
// TODO: crash()
}
