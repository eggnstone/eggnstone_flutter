import 'package:get_it/get_it.dart';

import 'AnalyticsService.dart';

mixin AnalyticsMixin
{
    static AnalyticsService get staticAnalytics
    => GetIt.instance.get<AnalyticsService>();

    AnalyticsService get analytics
    => GetIt.instance.get<AnalyticsService>();
}
