class DartTools
{
    static bool isDebugBuild()
    {
        bool isDebug = false;
        assert(isDebug = true);

        return isDebug;
    }

    static bool isReleaseBuild()
    => isDebugBuild() == false;
}
