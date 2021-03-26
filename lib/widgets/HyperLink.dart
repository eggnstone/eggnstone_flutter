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
        Key? key,
        this.textStyle,
        this.fontSizeFactor = 1.0,
        required this.url,
        required this.source
    }) : super(key: key);

    @override
    Widget build(BuildContext context)
    {
        return ActionLink(text,
            textStyle: textStyle,
            fontSizeFactor: fontSizeFactor,
            onTap: ()
            => UrlLauncherTools.launch(url, source)
        );
    }
}
