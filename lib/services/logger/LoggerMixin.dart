import 'package:eggnstone_flutter/eggnstone_flutter.dart';
import 'package:get_it/get_it.dart';

mixin LoggerMixin
{
    static LoggerService get staticLogger
    => GetIt.instance.get<LoggerService>();

    LoggerService get logger
    => GetIt.instance.get<LoggerService>();
}
