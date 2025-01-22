import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart' as ul;

import '../Services/Analytics/IAnalyticsService.dart';

class UrlLauncherTools
{
    static const String URL_LAUNCHER = 'UrlLauncher';

    static Future<bool> launch(String url, String source)
    async
    {
        final Map<String, Object> params = <String, Object>{'Url': url, 'Source': source};

        if (await ul.launchUrl(Uri.parse(url)))
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
