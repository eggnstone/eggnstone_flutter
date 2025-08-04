import 'dart:async';
import 'dart:convert';

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

    Date getDate(String key, Date def)
    {
        try
        {
            if (!_sharedPreferences.containsKey(key))
                return def;

            final String? s = _sharedPreferences.getString(key);
            if (s == null)
                return def;

            return Date.fromString(s);
        }
        catch (e)
        {
            logInfo(e.toString());
            logInfo('${_sharedPreferences.get(key)}');
            return def;
        }
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

    Date? getNullableDate(String key, Date? def)
    {
        try
        {
            if (!_sharedPreferences.containsKey(key))
                return def;

            final String? s = _sharedPreferences.getString(key);
            if (s == null)
                return def;

            return Date.fromString(s);
        }
        catch (e)
        {
            logInfo(e.toString());
            logInfo('${_sharedPreferences.get(key)}');
            return def;
        }
    }

    DateTime? getNullableDateTime(String key, DateTime? def)
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

    Map<K, V>? getNullableMap<K, V>(String key, Map<K, V>? def)
    {
        try
        {
            if (!_sharedPreferences.containsKey(key))
                return def;

            final String? s = _sharedPreferences.getString(key);
            if (s == null)
                return def;

            final Map<String, dynamic> dynamicMap = jsonDecode(s) as Map<String, dynamic>;
            final Map<K, V> map = <K, V>{};
            for (final MapEntry<String, dynamic> entry in dynamicMap.entries)
            {
                final K k = entry.key as K;
                final V v = entry.value as V;
                map[k] = v;
            }

            return map;
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

    // ignore: avoid_positional_boolean_parameters
    Future<bool> setBool(String key, bool value)
    => _sharedPreferences.setBool(key, value);

    Future<bool> setDate(String key, Date value)
    => _sharedPreferences.setString(key, value.toString());

    Future<bool> setDateTime(String key, DateTime value)
    => _sharedPreferences.setString(key, value.toIso8601String());

    Future<bool> setDouble(String key, double value)
    => _sharedPreferences.setDouble(key, value);

    Future<bool> setInt(String key, int value)
    => _sharedPreferences.setInt(key, value);

    Future<bool> setIntList(String key, List<int> intList, {bool removeIfEmpty = true})
    {
        if (intList.isEmpty && removeIfEmpty)
            return _sharedPreferences.remove(key);

        final List<String> stringList = <String>[];
        for (final int i in intList)
            stringList.add(i.toString());

        return _sharedPreferences.setStringList(key, stringList);
    }

    // ignore: avoid_positional_boolean_parameters
    Future<bool> setNullableBool(String key, bool? value)
    {
        if (value == null)
            return _sharedPreferences.remove(key);

        return setBool(key, value);
    }

    Future<bool> setNullableDate(String key, Date? value)
    {
        if (value == null)
            return _sharedPreferences.remove(key);

        return setDate(key, value);
    }

    Future<bool> setNullableDateTime(String key, DateTime? value)
    {
        if (value == null)
            return _sharedPreferences.remove(key);

        return setDateTime(key, value);
    }

    Future<bool> setNullableInt(String key, int? value)
    {
        if (value == null)
            return _sharedPreferences.remove(key);

        return setInt(key, value);
    }

    Future<bool> setNullableMap<K, V>(String key, Map<K, V>? value)
    {
        if (value == null)
            return _sharedPreferences.remove(key);

        return setString(key, jsonEncode(value));
    }

    Future<bool> setNullableString(String key, String? value)
    {
        if (value == null)
            return _sharedPreferences.remove(key);

        return setString(key, value);
    }

    Future<bool> setString(String key, String value)
    => _sharedPreferences.setString(key, value);

    Future<bool> setStringList(String key, List<String> stringList, {bool removeIfEmpty = true})
    {
        if (stringList.isEmpty && removeIfEmpty)
            return _sharedPreferences.remove(key);

        return _sharedPreferences.setStringList(key, stringList);
    }
}
