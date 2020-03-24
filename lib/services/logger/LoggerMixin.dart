import 'package:get_it/get_it.dart';

import 'LoggerService.dart';

mixin LoggerMixin
{
    LoggerService get logger
    => GetIt.instance.get<LoggerService>();
}
