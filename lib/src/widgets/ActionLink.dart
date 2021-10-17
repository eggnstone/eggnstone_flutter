// ignore_for_file: diagnostic_describe_all_properties

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../tools/platform_tools/PlatformNonWebTools.dart' if (dart.library.html) '../tools/platform_tools/PlatformWebTools.dart';

typedef ActionLinkCallback = void Function();

class ActionLink extends StatelessWidget
{
    static final dynamic _appContainer = PlatformTools.htmlWindowDocumentGetFirstElementByTagName('flt-glass-pane');

    final String text;
    final TextStyle? textStyle;
    final double fontSizeFactor;
    final ActionLinkCallback onTap;

    const ActionLink(this.text, {
        required this.onTap,
        Key? key,
        this.textStyle,
        this.fontSizeFactor = 1.0
    }) : super(key: key);

    @override
    Widget build(BuildContext context)
    {
        TextStyle actualTextStyle;

        if (textStyle == null)
        {
            final ThemeData theme = Theme.of(context);
            final TextTheme textTheme = theme.textTheme;
            actualTextStyle = textTheme.bodyText2!;
        }
        else
        {
            actualTextStyle = textStyle!;
        }

        final TextStyle textStyleScaled = actualTextStyle.copyWith(fontSize: actualTextStyle.fontSize == null ? null : actualTextStyle.fontSize! * fontSizeFactor);
        final TextStyle textStyleScaledUnderlined = textStyleScaled.copyWith(decoration: TextDecoration.underline);

        return GestureDetector(
            child: MouseRegion(
                child: Text(text, style: textStyleScaledUnderlined),
                onEnter: (PointerEnterEvent event)
                => _appContainer.style.cursor = 'pointer',
                onExit: (PointerExitEvent event)
                => _appContainer.style.cursor = 'default'
            ),
            onTap: onTap
        );
    }
}
