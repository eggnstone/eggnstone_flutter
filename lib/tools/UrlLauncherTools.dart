import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart' as ul;

import '../services/analytics/IAnalyticsService.dart';

class UrlLauncherTools
{
    static const String URL_LAUNCHER = 'UrlLauncher';

    static Future launch(String url, String source)
    async
    {
        Map<String, dynamic> params = {'Url': url};

        params['Source'] = source;

        if (await ul.canLaunch(url))
        {
            if (await ul.launch(url))
            {
                params['Action'] = 'LaunchSucceeded';
                if (GetIt.instance.isRegistered<IAnalyticsService>())
                    GetIt.instance.get<IAnalyticsService>().track(URL_LAUNCHER, params);
            }
            else
            {
                params['Action'] = 'LaunchFailed';
                if (GetIt.instance.isRegistered<IAnalyticsService>())
                    GetIt.instance.get<IAnalyticsService>().track(URL_LAUNCHER, params);
            }
        }
        else
        {
            params['Action'] = 'CanLaunchFailed';
            if (GetIt.instance.isRegistered<IAnalyticsService>())
                GetIt.instance.get<IAnalyticsService>().track(URL_LAUNCHER, params);
        }
    }
}
