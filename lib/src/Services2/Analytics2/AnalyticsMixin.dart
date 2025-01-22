import 'package:get_it/get_it.dart';

import '../../Services2/Analytics2/IAnalyticsService.dart';

mixin AnalyticsMixin
{
    /// Shortcut to access the Analytics service in static methods.
    static IAnalyticsService get staticAnalytics
    => GetIt.instance.get<IAnalyticsService>();

    /// Shortcut to access the Analytics service.
    IAnalyticsService get analytics
    => GetIt.instance.get<IAnalyticsService>();
}
