import 'package:eggnstone_flutter/services/shared_preferences/SharedPreferencesService.dart';
import 'package:get_it/get_it.dart';

mixin SharedPreferencesMixin
{
    SharedPreferencesService get sharedPreferences
    => GetIt.instance.get<SharedPreferencesService>();
}
