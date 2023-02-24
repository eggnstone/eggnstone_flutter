import 'package:flutter/material.dart';

class BusyDialog
{
    static Future<void> show(BuildContext context, String text, {double? textScaleFactor})
    async
    {
        await showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context)
            // ignore: prefer_expression_function_bodies
            {
                return Material(
                    color: Colors.transparent,
                    child: Center(
                        child: Card(
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
                            child: Padding(
                                padding: const EdgeInsets.all(32),
                                child: LayoutBuilder(
                                    builder: (BuildContext context, BoxConstraints constraints)
                                    // ignore: prefer_expression_function_bodies
                                    {
                                        return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                                const SizedBox(height: 32),
                                                const CircularProgressIndicator(),
                                                const SizedBox(height: 32),
                                                Text(text, textScaleFactor: textScaleFactor),
                                                const SizedBox(height: 32)
                                            ]
                                        );
                                    }
                                )
                            )
                        )
                    )
                );
            }
        );
    }

    static void hide(BuildContext context)
    => Navigator.pop(context);
}
