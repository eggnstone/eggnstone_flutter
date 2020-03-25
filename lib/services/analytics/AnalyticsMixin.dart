import 'package:eggnstone_flutter/services/analytics/IAnalyticsService.dart';
import 'package:get_it/get_it.dart';

mixin AnalyticsMixin
{
    static IAnalyticsService get staticAnalytics
    => GetIt.instance.get<IAnalyticsService>();

    IAnalyticsService get analytics
    => GetIt.instance.get<IAnalyticsService>();
}
