import 'package:eggnstone_flutter/services/logger/ILoggerService.dart';
import 'package:get_it/get_it.dart';

mixin LoggerMixin
{
    ILoggerService get logger
    => GetIt.instance.get<ILoggerService>();
}
