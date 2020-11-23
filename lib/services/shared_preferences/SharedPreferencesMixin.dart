import 'package:eggnstone_flutter/services/shared_preferences/SharedPreferencesService.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:get_it/get_it.dart';

mixin SharedPreferencesMixin
{
    static SharedPreferencesService? get staticSharedPreferences
    => GetIt.instance.get<SharedPreferencesService>();

    SharedPreferencesService? get sharedPreferences
    => GetIt.instance.get<SharedPreferencesService>();
}
