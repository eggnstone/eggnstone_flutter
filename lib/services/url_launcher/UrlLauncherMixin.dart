import 'package:eggnstone_flutter/services/url_launcher/UrlLauncher.dart';
import 'package:get_it/get_it.dart';

mixin UrlLauncherMixin
{
    static UrlLauncher get staticUrlLauncherTools
    => GetIt.instance.get<UrlLauncher>();

    UrlLauncher get urlLauncher
    => GetIt.instance.get<UrlLauncher>();
}
