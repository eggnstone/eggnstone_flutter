import 'dart:async';

import 'package:eggnstone_flutter/services/logger/LoggerMixin.dart';
import 'package:shared_preferences/shared_preferences.dart' as sp;

/// Requires [LoggerService]
class SharedPreferencesService
    with LoggerMixin
{
    sp.SharedPreferences _sharedPreferences;

    SharedPreferencesService._internal()
    {
        assert(logger != null, 'Unable to find via GetIt: Logger');
    }

    /// Requires [LoggerService]
    static Future<SharedPreferencesService> create()
    async
    {
        var sharedPreferences = SharedPreferencesService._internal();
        await sharedPreferences._init();
        return Future.value(sharedPreferences);
    }

    Future<void> _init()
    async
    {
        _sharedPreferences = await sp.SharedPreferences.getInstance();
    }

    bool getBool(String key, bool def)
    {
        try
        {
            return _sharedPreferences?.getBool(key) ?? def;
        }
        catch (e)
        {
            logger.logInfo(e.toString());
            logger.logInfo(_sharedPreferences?.get(key));
            return def;
        }
    }

    void setBool(String key, bool value)
    {
        if (_sharedPreferences == null)
            return;

        if (value == null)
            _sharedPreferences.remove(key);
        else
            _sharedPreferences.setBool(key, value);
    }

    DateTime getDateTime(String key, DateTime def)
    {
        try
        {
            String s = _sharedPreferences?.getString(key);
            if (s == null)
                return def;

            return DateTime.parse(s);
        }
        catch (e)
        {
            logger.logInfo(e.toString());
            logger.logInfo(_sharedPreferences?.get(key));
            return def;
        }
    }

    void setDateTime(String key, DateTime value)
    {
        if (_sharedPreferences == null)
            return;

        if (value == null)
            _sharedPreferences.remove(key);
        else
            _sharedPreferences.setString(key, value.toIso8601String());
    }

    int getInt(String key, int def)
    {
        try
        {
            return _sharedPreferences?.getInt(key) ?? def;
        }
        catch (e)
        {
            logger.logInfo(e.toString());
            logger.logInfo(_sharedPreferences?.get(key));
            return def;
        }
    }

    void setInt(String key, int value)
    {
        if (_sharedPreferences == null)
            return;

        if (value == null)
            _sharedPreferences.remove(key);
        else
            _sharedPreferences.setInt(key, value);
    }

    List<int> getIntList(String key, List<int> def)
    {
        try
        {
            List<String> stringList = _sharedPreferences?.getStringList(key);
            if (stringList == null)
                return def;

            var intList = List<int>();
            for (String s in stringList)
                intList.add(int.parse(s));

            return intList;
        }
        catch (e)
        {
            logger.logInfo(e.toString());
            logger.logInfo(_sharedPreferences?.get(key));
            return def;
        }
    }

    void setIntList(String key, List<int> intList, {bool removeIfEmpty = true})
    {
        if (_sharedPreferences == null)
            return;

        if (intList == null)
            _sharedPreferences.remove(key);
        else if (intList.length == 0 && removeIfEmpty)
            _sharedPreferences.remove(key);
        else
        {
            var stringList = List<String>();

            for (int i in intList)
                stringList.add(i.toString());

            _sharedPreferences.setStringList(key, stringList);
        }
    }

    String getString(String key, String def)
    {
        try
        {
            return _sharedPreferences?.getString(key) ?? def;
        }
        catch (e)
        {
            logger.logInfo(e.toString());
            logger.logInfo(_sharedPreferences?.get(key));
            return def;
        }
    }

    void setString(String key, String value)
    {
        if (_sharedPreferences == null)
            return;

        if (value == null)
            _sharedPreferences.remove(key);
        else
            _sharedPreferences.setString(key, value);
    }

    List<String> getStringList(String key, List<String> def)
    {
        try
        {
            return _sharedPreferences?.getStringList(key) ?? def;
        }
        catch (e)
        {
            logger.logInfo(e.toString());
            logger.logInfo(_sharedPreferences?.get(key));
            return def;
        }
    }

    void setStringList(String key, List<String> stringList, {bool removeIfEmpty = true})
    {
        if (_sharedPreferences == null)
            return;

        if (stringList == null)
            _sharedPreferences.remove(key);
        else if (stringList.length == 0 && removeIfEmpty)
            _sharedPreferences.remove(key);
        else
            _sharedPreferences.setStringList(key, stringList);
    }
}
