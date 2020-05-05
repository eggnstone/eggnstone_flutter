import 'package:eggnstone_flutter/eggnstone_flutter.dart';
import 'package:get_it/get_it.dart';

mixin SharedPreferencesMixin
{
    static SharedPreferencesService get staticSharedPreferences
    => GetIt.instance.get<SharedPreferencesService>();

    SharedPreferencesService get sharedPreferences
    => GetIt.instance.get<SharedPreferencesService>();
}
