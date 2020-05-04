import 'package:eggnstone_flutter/eggnstone_flutter.dart';
import 'package:get_it/get_it.dart';

mixin GoogleAnalyticsMixin
{
    static IGoogleAnalyticsService get staticGoogleAnalytics
    => GetIt.instance.get<IGoogleAnalyticsService>();

    IGoogleAnalyticsService get googleAnalytics
    => GetIt.instance.get<IGoogleAnalyticsService>();
}
