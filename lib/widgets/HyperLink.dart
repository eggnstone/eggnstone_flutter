import 'package:flutter/material.dart';

import '../tools/UrlLauncherTools.dart';
import '../tools/platform_tools/PlatformNonWebTools.dart' if (dart.library.html) '../tools/platform_tools/PlatformWebTools.dart';

class HyperLink extends StatelessWidget
{
    static dynamic appContainer = PlatformTools.htmlWindowDocumentGetFirstElementByTagName('flt-glass-pane');

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
        TextStyle actualTextStyle;

        if (textStyle == null)
        {
            ThemeData theme = Theme.of(context);
            TextTheme textTheme = theme.textTheme;
            actualTextStyle = textTheme.bodyText2!;
        }
        else
        {
            actualTextStyle = textStyle!;
        }

        TextStyle textStyleScaled = actualTextStyle.copyWith(fontSize: actualTextStyle.fontSize == null ? null : actualTextStyle.fontSize! * fontSizeFactor);
        TextStyle textStyleScaledUnderlined = textStyleScaled.copyWith(decoration: TextDecoration.underline);

        return GestureDetector(
            child: MouseRegion(
                child: Text(text, style: textStyleScaledUnderlined),
                onEnter: (event)
                => appContainer.style.cursor = 'pointer',
                onExit: (event)
                => appContainer.style.cursor = 'default'
            ),
            onTap: ()
            => UrlLauncherTools.launch(url, source));
    }
}
