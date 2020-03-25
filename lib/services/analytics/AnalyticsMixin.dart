import 'package:eggnstone_flutter/eggnstone_flutter.dart';
import 'package:get_it/get_it.dart';

mixin AnalyticsMixin
{
    static IAnalyticsService get staticAnalytics
    => GetIt.instance.get<IAnalyticsService>();

    IAnalyticsService get analytics
    => GetIt.instance.get<IAnalyticsService>();
}
