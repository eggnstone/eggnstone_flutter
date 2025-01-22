import 'dart:ui';

import 'package:eggnstone_dart/eggnstone_dart.dart';
import 'package:intl/intl.dart';

extension TimeExtension on Time
{
    String toShortString(Locale locale)
    => DateFormat.jm(locale.languageCode).format(toDateTime());
}
