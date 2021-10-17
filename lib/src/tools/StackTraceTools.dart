class StackTraceTools
{
    static String getOrCreateStackTrace(StackTrace? stackTrace, {int removeLevelsBefore = 2, int removeLevelsAfter = 10})
    {
        int pos;

        final StackTrace safeStackTrace = stackTrace ?? StackTrace.current;

        String s = safeStackTrace.toString();

        final String prefix = '#$removeLevelsBefore'.padRight(7);
        pos = s.indexOf(prefix);
        if (pos >= 0)
            s = s.substring(pos);

        final String postfix = '#${removeLevelsAfter + 1}'.padRight(7);
        pos = s.indexOf(postfix);
        if (pos >= 0)
            s = s.substring(0, pos);

        return s;
    }
}
