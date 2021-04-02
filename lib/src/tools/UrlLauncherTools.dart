import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart' as ul;

import '../services/analytics/IAnalyticsService.dart';

class UrlLauncherTools
{
    static const String URL_LAUNCHER = 'UrlLauncher';

    static Future<bool> launch(String url, String source)
    async
    {
        Map<String, dynamic> params = {'Url': url, 'Source': source};

        if (await ul.launch(url))
        {
            params['Action'] = 'LaunchSucceeded';
            if (GetIt.instance.isRegistered<IAnalyticsService>())
                GetIt.instance.get<IAnalyticsService>().track(URL_LAUNCHER, params);
            return true;
        }

        params['Action'] = 'LaunchFailed';
        if (GetIt.instance.isRegistered<IAnalyticsService>())
            GetIt.instance.get<IAnalyticsService>().track(URL_LAUNCHER, params);
        return false;
    }
}
