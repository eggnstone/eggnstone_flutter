class StringTools
{
    // TODO: use extension method
    static bool isNullOrEmpty(String s)
    => (s == null || s.length == 0);

    // TODO: use extension method
    static bool isNotNullNorEmpty(String s)
    => (s != null && s.length > 0);

    // TODO: deprecate
    static shortenForAnalytics(Object o)
    {
        if (o == null)
            return null;

        String s = o.toString();
        if (s == null)
            return null;

        // Limit to 100 chars (https://support.google.com/firebase/answer/9237506?hl=en)
        return s.length <= 100 ? s : s.substring(0, 100);
    }

    // TODO: deprecate
    static shortenUrlForAnalytics(String url)
    {
        if (url == null)
            return null;

        url = Uri.decodeFull(url);

        if (url.contains('?'))
            url = url.substring(0, url.lastIndexOf('?'));

        while (url.length > 100 && url.contains('/'))
            url = url.substring(url.indexOf('/') + 1);

        // Limit to 100 chars (https://support.google.com/firebase/answer/9237506?hl=en)
        // cut, preserving the tail
        return url.length <= 100 ? url : url.substring(url.length - 100);
    }
}
