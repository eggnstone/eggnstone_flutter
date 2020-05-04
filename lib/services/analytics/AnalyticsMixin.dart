import 'package:eggnstone_flutter/eggnstone_flutter.dart';
import 'package:get_it/get_it.dart';

mixin AnalyticsMixin
{
    @Deprecated('Use staticGoogleAnalytics instead')
    static IAnalyticsService get staticAnalytics
    => GetIt.instance.get<IAnalyticsService>();

    static IAnalyticsService get staticGoogleAnalytics
    => GetIt.instance.get<IAnalyticsService>();

    @Deprecated('Use googleAnalytics instead')
    IAnalyticsService get analytics
    => GetIt.instance.get<IAnalyticsService>();

    IAnalyticsService get googleAnalytics
    => GetIt.instance.get<IAnalyticsService>();
}
