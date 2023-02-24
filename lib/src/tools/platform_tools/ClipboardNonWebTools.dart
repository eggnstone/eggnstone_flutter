import 'package:flutter/services.dart';

class ClipboardTools
{
    static Future<void> setData(String text)
    => Clipboard.setData(ClipboardData(text: text));
}
