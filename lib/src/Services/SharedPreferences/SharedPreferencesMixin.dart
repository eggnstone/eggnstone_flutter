import 'package:get_it/get_it.dart';

import '../../Services/SharedPreferences/SharedPreferencesService.dart';

mixin SharedPreferencesMixin
{
    static SharedPreferencesService get staticSharedPreferences
    => GetIt.instance.get<SharedPreferencesService>();

    SharedPreferencesService get sharedPreferences
    => GetIt.instance.get<SharedPreferencesService>();
}
