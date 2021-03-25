import 'package:flutter/services.dart';

class ClipboardTools
{
    static void setData(String text)
    => Clipboard.setData(ClipboardData(text: text));
}
