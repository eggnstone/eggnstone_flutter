import 'package:eggnstone_flutter/services/crashlytics/CrashlyticsService.dart';
import 'package:get_it/get_it.dart';

mixin CrashlyticsMixin
{
    CrashlyticsService get crashlytics
    => GetIt.instance.get<CrashlyticsService>();
}
