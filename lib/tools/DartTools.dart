class DartTools
{
    static bool isDebugBuild()
    {
        bool isDebug = false;
        assert(isDebug = true);

        return isDebug;
    }

    static bool isReleaseBuild()
    {
        bool isRelease = true;
        assert(isRelease = false);

        return isRelease;
    }
}
