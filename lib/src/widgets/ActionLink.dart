import 'package:flutter/material.dart';

import '../tools/platform_tools/PlatformNonWebTools.dart' if (dart.library.html) '../tools/platform_tools/PlatformWebTools.dart';

typedef ActionLinkCallback = void Function();

class ActionLink extends StatelessWidget
{
    static dynamic _appContainer = PlatformTools.htmlWindowDocumentGetFirstElementByTagName('flt-glass-pane');

    final String text;
    final TextStyle? textStyle;
    final double fontSizeFactor;
    final ActionLinkCallback onTap;

    const ActionLink(this.text, {
        Key? key,
        this.textStyle,
        this.fontSizeFactor = 1.0,
        required this.onTap
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
                => _appContainer.style.cursor = 'pointer',
                onExit: (event)
                => _appContainer.style.cursor = 'default'
            ),
            onTap: onTap
        );
    }
}
