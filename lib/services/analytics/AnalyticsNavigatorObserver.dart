import 'package:eggnstone_flutter/services/analytics/AnalyticsMixin.dart';
import 'package:eggnstone_flutter/services/analytics/IAnalyticsService.dart';
import 'package:flutter/widgets.dart';

// ignore: import_of_legacy_library_into_null_safe
//import 'package:get_it/get_it.dart';

typedef String? ScreenNameExtractor(RouteSettings settings);

String? defaultNameExtractor(RouteSettings settings)
=> settings.name;

class AnalyticsNavigatorObserver extends NavigatorObserver
    with AnalyticsMixin
{
    final ScreenNameExtractor nameExtractor = defaultNameExtractor;

    late IAnalyticsService _analytics;

    AnalyticsNavigatorObserver._internal()
    {
        assert(analytics != null, 'Unable to find via GetIt: Analytics');
        _analytics = analytics!;
    }

    /// Requires [AnalyticsService]
    static Future<AnalyticsNavigatorObserver> create()
    async
    {
        var analyticsNavigatorObserver = AnalyticsNavigatorObserver._internal();
        return Future.value(analyticsNavigatorObserver);
    }

    @override
    void didPush(Route<dynamic> route, Route<dynamic>? previousRoute)
    {
        super.didPush(route, previousRoute);

        if (route is PageRoute)
            _setCurrentScreen(route);
    }

    @override
    void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute})
    {
        super.didReplace(newRoute: newRoute, oldRoute: oldRoute);

        if (newRoute is PageRoute)
            _setCurrentScreen(newRoute);
    }

    @override
    void didPop(Route<dynamic> route, Route<dynamic>? previousRoute)
    {
        super.didPop(route, previousRoute);

        if (previousRoute is PageRoute && route is PageRoute)
            _setCurrentScreen(previousRoute);
    }

    void _setCurrentScreen(PageRoute<dynamic> route)
    {
        String? screenName = nameExtractor(route.settings);
        if (screenName != null)
            _analytics.currentScreen = screenName;
    }
}
