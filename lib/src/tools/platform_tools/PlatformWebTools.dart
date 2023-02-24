import 'dart:html' as html; // ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js; // ignore: avoid_web_libraries_in_flutter

class PlatformTools
{
    // js.context['location']['pathname']

    // js.context['location']['search']

    static String get jsContextLocationHref
    {
        final dynamic href = js.context['location']['href'];
        return href is String ? href : '';
    }

    static set jsContextLocationHref(String value)
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
