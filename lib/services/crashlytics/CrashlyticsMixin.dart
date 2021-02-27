import 'package:eggnstone_flutter/services/crashlytics/ICrashlyticsService.dart';
import 'package:get_it/get_it.dart';

mixin CrashlyticsMixin
{
    /// Shortcut to access the Crashlytics service in static methods.
    static ICrashlyticsService get staticCrashlytics
    => GetIt.instance.get<ICrashlyticsService>();

    /// Shortcut to access the Crashlytics service.
    ICrashlyticsService get crashlytics
    => GetIt.instance.get<ICrashlyticsService>();
}
