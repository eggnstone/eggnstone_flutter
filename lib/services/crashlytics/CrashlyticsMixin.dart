import 'package:eggnstone_flutter/services/crashlytics/ICrashlyticsService.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:get_it/get_it.dart';

mixin CrashlyticsMixin
{
    static ICrashlyticsService? get staticCrashlytics
    => GetIt.instance.get<ICrashlyticsService>();

    ICrashlyticsService? get crashlytics
    => GetIt.instance.get<ICrashlyticsService>();
}
