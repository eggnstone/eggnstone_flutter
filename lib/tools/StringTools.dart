class StringTools
{
    static bool isNullOrEmpty(String? s)
    => (s == null || s.isEmpty);

    static bool isNotNullAndNotEmpty(String? s)
    => (s != null && s.isNotEmpty);
}
