import 'dart:js_interop' as js;
import 'package:web/web.dart' as web;

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
        final dynamic href = (js.globalContext as dynamic)['location']['href'];
        return href is String ? href : '';
    }

    static set jsContextLocationHref(String value)
    // ignore: avoid_dynamic_calls
    => (js.globalContext as dynamic)['location']['href'] = value;

    static String? htmlNavigatorUserAgent()
    => web.window.navigator.userAgent;

    // html.window.history.pushState(data, title, url)
    static void htmlWindowHistoryPushState(String url)
    => web.window.history.pushState(null, '', url);

    static dynamic htmlWindowDocumentGetElementById(String id)
    => web.window.document.getElementById(id);

    static dynamic htmlWindowDocumentGetFirstElementByTagName(String tagName)
    {
        final web.HTMLCollection nodes = web.window.document.getElementsByTagName(tagName);
        if (nodes.length == 0)
            return null;

        return nodes.item(0);
    }
}
