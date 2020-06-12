import 'package:flutter/material.dart';

class BusyDialog
{
    static void show(BuildContext context, String text, {double textScaleFactor})
    {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context)
            {
                return Material(
                    color: Colors.transparent,
                    child: Center(
                        child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
                            child: Padding(
                                padding: const EdgeInsets.all(32),
                                child: LayoutBuilder(
                                    builder: (BuildContext context, BoxConstraints constraints)
                                    {
                                        return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                                SizedBox(height: 32),
                                                CircularProgressIndicator(),
                                                SizedBox(height: 32),
                                                Text(text, textScaleFactor: textScaleFactor),
                                                SizedBox(height: 32)
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
