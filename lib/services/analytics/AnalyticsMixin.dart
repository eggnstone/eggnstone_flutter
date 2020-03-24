import 'package:eggnstone_flutter/services/analytics/AnalyticsService.dart';
import 'package:get_it/get_it.dart';

mixin AnalyticsMixin
{
    static AnalyticsService get staticAnalytics
    => GetIt.instance.get<AnalyticsService>();

    AnalyticsService get analytics
    => GetIt.instance.get<AnalyticsService>();
}
