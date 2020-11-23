import 'package:eggnstone_flutter/services/analytics/AnalyticsMixin.dart';
import 'package:eggnstone_flutter/services/analytics/IAnalyticsService.dart';
import 'package:url_launcher/url_launcher.dart' as ul;

class UrlLauncherService
    with AnalyticsMixin
{
    static const String URL_LAUNCHER = 'UrlLauncher';

    late IAnalyticsService _analytics;

    UrlLauncherService._internal()
    {
        assert(analytics != null, 'Unable to find via GetIt: Analytics');
        _analytics = analytics!;
    }

    /// Requires [AnalyticsService]
    static Future<UrlLauncherService> create()
    async
    {
        var urlLauncherService = UrlLauncherService._internal();
        return Future.value(urlLauncherService);
    }

    Future launch(String url, String source)
    async
    {
        Map<String, dynamic> params = {'Url': url};

        params['Source'] = source;

        if (await ul.canLaunch(url))
        {
            if (await ul.launch(url))
            {
                params['Action'] = 'LaunchSucceeded';
                _analytics.track(URL_LAUNCHER, params);
            }
            else
            {
                params['Action'] = 'LaunchFailed';
                _analytics.track(URL_LAUNCHER, params);
            }
        }
        else
        {
            params['Action'] = 'CanLaunchFailed';
            _analytics.track(URL_LAUNCHER, params);
        }
    }
}
