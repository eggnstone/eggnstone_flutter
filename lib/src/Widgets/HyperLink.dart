import 'dart:async';

import 'package:flutter/widgets.dart';

import '../Tools/UrlLauncherTools.dart';
import '../Widgets/ActionLink.dart';

class HyperLink extends StatelessWidget
{
    final String text;
    final TextStyle? textStyle;
    final double fontSizeFactor;
    final String url;
    final String source;

    const HyperLink(this.text, 
        {
            required this.url,
            required this.source,
            super.key,
            this.textStyle,
            this.fontSizeFactor = 1.0
        }
    );

    @override
    Widget build(BuildContext context)
    // ignore: prefer_expression_function_bodies
    {
        return ActionLink(text,
            textStyle: textStyle,
            fontSizeFactor: fontSizeFactor,
            onTap: ()
            => unawaited(UrlLauncherTools.launch(url, source))
        );
    }
}
