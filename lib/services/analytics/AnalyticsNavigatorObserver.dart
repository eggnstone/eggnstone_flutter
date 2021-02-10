import 'package:eggnstone_flutter/services/analytics/AnalyticsMixin.dart';
import 'package:flutter/widgets.dart';

typedef String? ScreenNameExtractor(RouteSettings settings);

String? defaultNameExtractor(RouteSettings settings)
=> settings.name;

class AnalyticsNavigatorObserver extends NavigatorObserver
    with AnalyticsMixin
{
    final ScreenNameExtractor nameExtractor = defaultNameExtractor;

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

        // From navigator.dart:
        // If null, the route is anonymous.
        if (screenName == null)
            screenName = '<anonymous>';

        analytics.currentScreen = screenName;
    }
}
