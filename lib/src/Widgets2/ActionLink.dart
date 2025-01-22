// ignore_for_file: diagnostic_describe_all_properties

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../Tools2/PlatformTools/PlatformNonWebTools.dart' if (dart.library.html) '../Tools2/PlatformTools/PlatformWebTools.dart';

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
        super.key,
        this.textStyle,
        this.fontSizeFactor = 1.0
    });

    @override
    Widget build(BuildContext context)
    {
        TextStyle actualTextStyle;

        if (textStyle == null)
        {
            final ThemeData theme = Theme.of(context);
            final TextTheme textTheme = theme.textTheme;
            actualTextStyle = textTheme.bodyMedium!;
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
                // ignore: avoid_dynamic_calls
                => _appContainer.style.cursor = 'pointer',
                onExit: (PointerExitEvent event)
                // ignore: avoid_dynamic_calls
                => _appContainer.style.cursor = 'default'
            ),
            onTap: onTap
        );
    }
}
