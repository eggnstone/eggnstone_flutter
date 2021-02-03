import 'package:package_info/package_info.dart' as pi;

class PackageInfo
{
    static String version = '?';
    static String buildNumber = '?';

    static Future<void> init()
    async
    {
        final pi.PackageInfo packageInfo = await pi.PackageInfo.fromPlatform();
        version = packageInfo.version;
        buildNumber = packageInfo.buildNumber;
    }
}
