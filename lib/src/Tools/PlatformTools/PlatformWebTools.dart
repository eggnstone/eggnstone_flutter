import 'dart:html' as html; // ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js; // ignore: avoid_web_libraries_in_flutter

class PlatformTools
{
    static bool get isAndroid
    => false;

    static bool get isFuchsia
    => false;

    static bool get isIos
    => false;

    static bool get isLinux
    => false;

    static bool get isMacOs
    => false;

    static bool get isWeb
    => true;

    static bool get isWindows
    => false;

    // js.context['location']['pathname']

    // js.context['location']['search']

    static String get jsContextLocationHref
    {
        // ignore: avoid_dynamic_calls
        final dynamic href = js.context['location']['href'];
        return href is String ? href : '';
    }

    static set jsContextLocationHref(String value)
    // ignore: avoid_dynamic_calls
    => js.context['location']['href'] = value;

    static String? htmlNavigatorUserAgent()
    => html.window.navigator.userAgent;

    // html.window.history.pushState(data, title, url)
    static void htmlWindowHistoryPushState(String url)
    => html.window.history.pushState(null, '', url);

    static dynamic htmlWindowDocumentGetElementById(String id)
    => html.window.document.getElementById(id);

    static dynamic htmlWindowDocumentGetFirstElementByTagName(String tagName)
    {
        final List<html.Node> nodes = html.window.document.getElementsByTagName(tagName);
        if (nodes.isEmpty)
            return null;

        return nodes[0];
    }
}
