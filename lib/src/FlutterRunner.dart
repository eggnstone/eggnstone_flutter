import 'dart:async';

import 'package:flutter/material.dart';

class FlutterRunner
{
    final Function(Object error, StackTrace? stackTrace) onError;

    FlutterRunner(this.onError);

    Future<void> run(Future<void> Function() startApp)
    async
    {
        FlutterError.onError = _onFlutterError;
        await runZonedGuarded<Future<void>>(startApp, _onRunZonedGuardedError);
    }

    void _onFlutterError(FlutterErrorDetails details)
    {
        // Examples for errors caught here:
        // ProviderScope is missing: "Bad state: No ProviderScope found"
        // "A RenderFlex overflowed by X pixels on the bottom."
        // Exceptions from synchronous code, e.g. non-async _onPressed
        onError(details.exception, details.stack);
    }

    void _onRunZonedGuardedError(Object error, StackTrace stack)
    {
        // Examples for errors caught here:
        // Exceptions from synchronous code, e.g. async _onPressed
        onError(error, stack);
    }
}
