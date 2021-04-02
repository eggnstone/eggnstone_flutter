import 'package:package_info_plus/package_info_plus.dart' as pi;

class PackageInfo
{
    static String appName = '?';
    static String buildNumber = '?';
    static String packageName = '?';
    static String version = '?';

    static Future<void> init()
    async
    {
        final pi.PackageInfo packageInfo = await pi.PackageInfo.fromPlatform();
        appName = packageInfo.appName;
        buildNumber = packageInfo.buildNumber;
        packageName = packageInfo.packageName;
        version = packageInfo.version;
    }
}
