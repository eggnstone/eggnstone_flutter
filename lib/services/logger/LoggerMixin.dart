import 'package:eggnstone_flutter/services/logger/LoggerService.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:get_it/get_it.dart';

mixin LoggerMixin
{
    static LoggerService? get staticLogger
    => GetIt.instance.get<LoggerService>();

    LoggerService? get logger
    => GetIt.instance.get<LoggerService>();
}
