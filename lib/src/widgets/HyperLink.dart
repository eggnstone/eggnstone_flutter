// ignore_for_file: diagnostic_describe_all_properties

import 'package:flutter/widgets.dart';

import '../tools/UrlLauncherTools.dart';
import 'ActionLink.dart';

class HyperLink extends StatelessWidget
{
    final String text;
    final TextStyle? textStyle;
    final double fontSizeFactor;
    final String url;
    final String source;

    const HyperLink(this.text, {
        required this.url,
        required this.source,
        Key? key,
        this.textStyle,
        this.fontSizeFactor = 1.0
    }) : super(key: key);

    @override
    Widget build(BuildContext context)
    // ignore: prefer_expression_function_bodies
    {
        return ActionLink(text,
            textStyle: textStyle,
            fontSizeFactor: fontSizeFactor,
            onTap: ()
            => UrlLauncherTools.launch(url, source)
        );
    }
}
