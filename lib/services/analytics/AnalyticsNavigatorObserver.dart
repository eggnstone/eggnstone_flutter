import 'package:eggnstone_flutter/eggnstone_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

typedef String ScreenNameExtractor(RouteSettings settings);

String defaultNameExtractor(RouteSettings settings)
=> settings.name;

class AnalyticsNavigatorObserver extends NavigatorObserver
{
    final ScreenNameExtractor nameExtractor = defaultNameExtractor;

    @override
    void didPush(Route<dynamic> route, Route<dynamic> previousRoute)
    {
        super.didPush(route, previousRoute);

        if (route is PageRoute)
            _setCurrentScreen(route);
    }

    @override
    void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute})
    {
        super.didReplace(newRoute: newRoute, oldRoute: oldRoute);

        if (newRoute is PageRoute)
            _setCurrentScreen(newRoute);
    }

    @override
    void didPop(Route<dynamic> route, Route<dynamic> previousRoute)
    {
        super.didPop(route, previousRoute);

        if (previousRoute is PageRoute && route is PageRoute)
            _setCurrentScreen(previousRoute);
    }

    void _setCurrentScreen(PageRoute<dynamic> route)
    {
        String screenName = nameExtractor(route.settings);
        if (screenName != null)
            GetIt.instance
                .get<IAnalyticsService>()
                .currentScreen = screenName;
    }
}
