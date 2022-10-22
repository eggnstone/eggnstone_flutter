import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart' as sp;

import '../../tools/LogTools.dart';

class SharedPreferencesService
{
    late sp.SharedPreferences _sharedPreferences;

    SharedPreferencesService._internal();

    static Future<SharedPreferencesService> create()
    async
    {
        final SharedPreferencesService sharedPreferences = SharedPreferencesService._internal();
        await sharedPreferences._init();
        return sharedPreferences;
    }

    Future<void> _init()
    async
    {
        _sharedPreferences = await sp.SharedPreferences.getInstance();
    }

    // ignore: avoid_positional_boolean_parameters
    bool getBool(String key, bool def)
    {
        try
        {
            if (_sharedPreferences.containsKey(key) == false)
                return def;

            final bool? b = _sharedPreferences.getBool(key);
            if (b == null)
                return def;

            return b;
        }
        catch (e)
        {
            logInfo(e.toString());
            logInfo('${_sharedPreferences.get(key)}');
            return def;
        }
    }

    // ignore: avoid_positional_boolean_parameters
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

            final String? s = _sharedPreferences.getString(key);
            if (s == null)
                return def;

            return DateTime.parse(s);
        }
        catch (e)
        {
            logInfo(e.toString());
            logInfo('${_sharedPreferences.get(key)}');
            return def;
        }
    }

    void setDateTime(String key, DateTime value)
    {
        _sharedPreferences.setString(key, value.toIso8601String());
    }

    double getDouble(String key, double def)
    {
        try
        {
            if (_sharedPreferences.containsKey(key) == false)
                return def;

            final double? d = _sharedPreferences.getDouble(key);
            if (d == null)
                return def;

            return d;
        }
        catch (e)
        {
            logInfo(e.toString());
            logInfo('${_sharedPreferences.get(key)}');
            return def;
        }
    }

    void setDouble(String key, double value)
    {
        _sharedPreferences.setDouble(key, value);
    }

    int getInt(String key, int def)
    {
        try
        {
            if (_sharedPreferences.containsKey(key) == false)
                return def;

            final int? i = _sharedPreferences.getInt(key);
            if (i == null)
                return def;

            return i;
        }
        catch (e)
        {
            logInfo(e.toString());
            logInfo('${_sharedPreferences.get(key)}');
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

            final List<String>? stringList = _sharedPreferences.getStringList(key);
            if (stringList == null)
                return def;

            final List<int> intList = <int>[];
            for (final String s in stringList)
                intList.add(int.parse(s));

            return intList;
        }
        catch (e)
        {
            logInfo(e.toString());
            logInfo('${_sharedPreferences.get(key)}');
            return def;
        }
    }

    void setIntList(String key, List<int> intList, {bool removeIfEmpty = true})
    {
        if (intList.isEmpty && removeIfEmpty)
            _sharedPreferences.remove(key);
        else
        {
            final List<String> stringList = <String>[];
            for (final int i in intList)
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

            final String? s = _sharedPreferences.getString(key);
            if (s == null)
                return def;

            return s;
        }
        catch (e)
        {
            logInfo(e.toString());
            logInfo('${_sharedPreferences.get(key)}');
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

            final List<String>? stringList = _sharedPreferences.getStringList(key);
            if (stringList == null)
                return def;

            return stringList;
        }
        catch (e)
        {
            logInfo(e.toString());
            logInfo('${_sharedPreferences.get(key)}');
            return def;
        }
    }

    void setStringList(String key, List<String> stringList, {bool removeIfEmpty = true})
    {
        if (stringList.isEmpty && removeIfEmpty)
            _sharedPreferences.remove(key);
        else
            _sharedPreferences.setStringList(key, stringList);
    }
}
