import 'package:eggnstone_flutter/services/logger/LoggerService.dart';
import 'package:get_it/get_it.dart';

mixin LoggerMixin
{
    /// Shortcut to access the Logger service in static methods.
    static LoggerService get staticLogger
    => GetIt.instance.get<LoggerService>();

    /// Shortcut to access the Logger service.
    LoggerService get logger
    => GetIt.instance.get<LoggerService>();
}
