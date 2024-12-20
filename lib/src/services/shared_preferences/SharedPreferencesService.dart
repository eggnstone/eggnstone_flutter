import 'dart:async';

import 'package:eggnstone_dart/eggnstone_dart.dart';
import 'package:shared_preferences/shared_preferences.dart' as sp;

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
            if (!_sharedPreferences.containsKey(key))
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
    bool? getNullableBool(String key, bool? def)
    {
        try
        {
            if (!_sharedPreferences.containsKey(key))
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
    Future<bool> setBool(String key, bool value)
    => _sharedPreferences.setBool(key, value);

    // ignore: avoid_positional_boolean_parameters
    Future<bool> setNullableBool(String key, bool? value)
    {
        if (value == null)
            return _sharedPreferences.remove(key);

        return _sharedPreferences.setBool(key, value);
    }

    DateTime getDateTime(String key, DateTime def)
    {
        try
        {
            if (!_sharedPreferences.containsKey(key))
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

    Future<bool> setDateTime(String key, DateTime value)
    => _sharedPreferences.setString(key, value.toIso8601String());

    double getDouble(String key, double def)
    {
        try
        {
            if (!_sharedPreferences.containsKey(key))
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

    Future<bool> setDouble(String key, double value)
    => _sharedPreferences.setDouble(key, value);

    int getInt(String key, int def)
    {
        try
        {
            if (!_sharedPreferences.containsKey(key))
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

    int? getNullableInt(String key, int? def)
    {
        try
        {
            if (!_sharedPreferences.containsKey(key))
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

    Future<bool> setInt(String key, int value)
    => _sharedPreferences.setInt(key, value);

    Future<bool> setNullableInt(String key, int? value)
    {
        if (value == null)
            return _sharedPreferences.remove(key);

        return _sharedPreferences.setInt(key, value);
    }

    List<int> getIntList(String key, List<int> def)
    {
        try
        {
            if (!_sharedPreferences.containsKey(key))
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

    Future<bool> setIntList(String key, List<int> intList, {bool removeIfEmpty = true})
    async
    {
        if (intList.isEmpty && removeIfEmpty) 
            return _sharedPreferences.remove(key);

        final List<String> stringList = <String>[];
        for (final int i in intList)
            stringList.add(i.toString());

        return _sharedPreferences.setStringList(key, stringList);
    }

    String getString(String key, String def)
    {
        try
        {
            if (!_sharedPreferences.containsKey(key))
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

    String? getNullableString(String key, String? def)
    {
        try
        {
            if (!_sharedPreferences.containsKey(key))
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

    Future<bool> setString(String key, String value)
    => _sharedPreferences.setString(key, value);

    Future<bool> setNullableString(String key, String? value)
    {
        if (value == null)
            return _sharedPreferences.remove(key);

        return _sharedPreferences.setString(key, value);
    }

    List<String> getStringList(String key, List<String> def)
    {
        try
        {
            if (!_sharedPreferences.containsKey(key))
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

    Future<bool> setStringList(String key, List<String> stringList, {bool removeIfEmpty = true})
    {
        if (stringList.isEmpty && removeIfEmpty)
            return _sharedPreferences.remove(key);

        return _sharedPreferences.setStringList(key, stringList);
    }
}
