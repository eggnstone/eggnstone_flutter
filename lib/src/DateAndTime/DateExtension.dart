import 'dart:ui';

import 'package:eggnstone_dart/eggnstone_dart.dart';
import 'package:intl/intl.dart';

extension DateExtension on Date
{
    String toShortString(Locale locale)
    => DateFormat.yMd(locale.languageCode).format(toUtcDateTime());

    String toShortTextMonthAndDayString(Locale locale)
    => DateFormat.MMMd(locale.languageCode).format(toUtcDateTime());
}
