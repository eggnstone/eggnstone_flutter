import 'dart:io';

class PlatformTools
{
    static bool get isAndroid
    => Platform.isAndroid;

    static bool get isFuchsia
    => Platform.isFuchsia;

    static bool get isIos
    => Platform.isIOS;

    static bool get isLinux
    => Platform.isLinux;

    static bool get isMacOs
    => Platform.isMacOS;

    static bool get isWeb
    => false;

    static bool get isWindows
    => Platform.isWindows;

    static String get jsContextLocationHref
    => '';

    static set jsContextLocationHref(String value)
    {
    }

    static String? htmlNavigatorUserAgent()
    => null;

    static void htmlWindowHistoryPushState(String url)
    {
    }

    static dynamic htmlWindowDocumentGetElementById(String id)
    => null;

    static dynamic htmlWindowDocumentGetFirstElementByTagName(String tagName)
    => null;
}
