import 'package:eggnstone_flutter/services/url_launcher/UrlLauncherService.dart';
import 'package:get_it/get_it.dart';

mixin UrlLauncherMixin
{
    static UrlLauncherService get staticUrlLauncher
    => GetIt.instance.get<UrlLauncherService>();

    UrlLauncherService get urlLauncher
    => GetIt.instance.get<UrlLauncherService>();
}
