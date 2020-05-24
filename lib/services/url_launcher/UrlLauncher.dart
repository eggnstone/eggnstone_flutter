import 'package:eggnstone_flutter/services/analytics/AnalyticsMixin.dart';
import 'package:url_launcher/url_launcher.dart' as ul;

class UrlLauncher
    with AnalyticsMixin
{
    static const String URL_LAUNCHER = 'UrlLauncher';

    void launch(String url, String source)
    async
    {
        Map<String, dynamic> params = { 'Url': url};

        if (source != null)
            params['Source'] = source;

        if (await ul.canLaunch(url))
        {
            if (await ul.launch(url))
            {
                params['Action'] = 'LaunchSucceeded';
                analytics.track(URL_LAUNCHER, params);
                // TODO: analytics.trackUrl()
            }
            else
            {
                params['Action'] = 'LaunchFailed';
                analytics.track(URL_LAUNCHER, params);
            }
        }
        else
        {
            params['Action'] = 'CanLaunchFailed';
            analytics.track(URL_LAUNCHER, params);
        }
    }
}
