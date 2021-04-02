@Deprecated('Use extensions')
class StringTools
{
    @Deprecated('Use extensions')
    static bool isNullOrEmpty(String? s)
    => StringX.isNullOrEmpty(s);

    @Deprecated('Use extensions')
    static bool isNotNullAndNotEmpty(String? s)
    => StringX.isNotNullAndNotEmpty(s);
}

extension StringX on String
{
    static String get empty
    => '';

    static bool isNullOrEmpty(String? s)
    => (s == null || s.isEmpty);

    static bool isNotNullAndNotEmpty(String? s)
    => (s != null && s.isNotEmpty);
}
