import 'dart:async';

import 'package:eggnstone_flutter/services/logger/LoggerMixin.dart';
import 'package:shared_preferences/shared_preferences.dart' as sp;

/// Requires [LoggerService]
class SharedPreferencesService
    with LoggerMixin
{
    late sp.SharedPreferences _sharedPreferences;

    SharedPreferencesService._internal();

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
            if (_sharedPreferences.containsKey(key) == false)
                return def;

            bool? b = _sharedPreferences.getBool(key);
            if (b == null)
                return def;

            return b;
        }
        catch (e)
        {
            logger.logInfo(e.toString());
            logger.logInfo('${_sharedPreferences.get(key)}');
            return def;
        }
    }

    void setBool(String key, bool value)
    {
        _sharedPreferences.setBool(key, value);
    }

    DateTime getDateTime(String key, DateTime def)
    {
        try
        {
            if (_sharedPreferences.containsKey(key) == false)
                return def;

            String? s = _sharedPreferences.getString(key);
            if (s == null)
                return def;

            return DateTime.parse(s);
        }
        catch (e)
        {
            logger.logInfo(e.toString());
            logger.logInfo('${_sharedPreferences.get(key)}');
            return def;
        }
    }

    void setDateTime(String key, DateTime value)
    {
        _sharedPreferences.setString(key, value.toIso8601String());
    }

    int getInt(String key, int def)
    {
        try
        {
            if (_sharedPreferences.containsKey(key) == false)
                return def;

            int? i = _sharedPreferences.getInt(key);
            if (i == null)
                return def;

            return i;
        }
        catch (e)
        {
            logger.logInfo(e.toString());
            logger.logInfo('${_sharedPreferences.get(key)}');
            return def;
        }
    }

    void setInt(String key, int value)
    {
        _sharedPreferences.setInt(key, value);
    }

    List<int> getIntList(String key, List<int> def)
    {
        try
        {
            if (_sharedPreferences.containsKey(key) == false)
                return def;

            List<String>? stringList = _sharedPreferences.getStringList(key);
            if (stringList == null)
                return def;

            var intList = List<int>.empty();
            for (String s in stringList)
                intList.add(int.parse(s));

            return intList;
        }
        catch (e)
        {
            logger.logInfo(e.toString());
            logger.logInfo('${_sharedPreferences.get(key)}');
            return def;
        }
    }

    void setIntList(String key, List<int> intList, {bool removeIfEmpty = true})
    {
        if (intList.length == 0 && removeIfEmpty)
            _sharedPreferences.remove(key);
        else
        {
            var stringList = List<String>.empty();
            for (int i in intList)
                stringList.add(i.toString());

            _sharedPreferences.setStringList(key, stringList);
        }
    }

    String getString(String key, String def)
    {
        try
        {
            if (_sharedPreferences.containsKey(key) == false)
                return def;

            String? s = _sharedPreferences.getString(key);
            if (s == null)
                return def;

            return s;
        }
        catch (e)
        {
            logger.logInfo(e.toString());
            logger.logInfo('${_sharedPreferences.get(key)}');
            return def;
        }
    }

    void setString(String key, String value)
    {
        _sharedPreferences.setString(key, value);
    }

    List<String> getStringList(String key, List<String> def)
    {
        try
        {
            if (_sharedPreferences.containsKey(key) == false)
                return def;

            List<String>? stringList = _sharedPreferences.getStringList(key);
            if (stringList == null)
                return def;

            return stringList;
        }
        catch (e)
        {
            logger.logInfo(e.toString());
            logger.logInfo('${_sharedPreferences.get(key)}');
            return def;
        }
    }

    void setStringList(String key, List<String> stringList, {bool removeIfEmpty = true})
    {
        if (stringList.length == 0 && removeIfEmpty)
            _sharedPreferences.remove(key);
        else
            _sharedPreferences.setStringList(key, stringList);
    }
}
