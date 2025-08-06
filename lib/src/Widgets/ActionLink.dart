import 'package:flutter/material.dart';

typedef ActionLinkCallback = void Function();

class ActionLink extends StatelessWidget
{
    final String text;
    final TextScaler? textScaler;
    final TextStyle? textStyle;
    final double fontSizeFactor;
    final ActionLinkCallback onTap;

    const ActionLink(
        this.text,
        {
            required this.onTap,
            super.key,
            this.textScaler,
            this.textStyle,
            this.fontSizeFactor = 1.0
        }
    );

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
                child: Text(
                    text,
                    textScaler: textScaler,
                    style: textStyleScaledUnderlined
                ),
                cursor: SystemMouseCursors.click
            ),
            onTap: onTap
        );
    }
}
