import 'dart:async';

import 'package:flutter/material.dart';

import 'AppContext.dart';

class FlutterRunner
{
    final AppContext _appContext = AppContext();

    Future<void> run(Future<void> Function(AppContext appContext) runApp)
    async
    {
        FlutterError.onError = _onFlutterError;
        await runZonedGuarded<Future<void>>(() => runApp(_appContext), _onRunZonedGuardedError);
    }

    void _onFlutterError(FlutterErrorDetails details)
    {
        // Examples for errors caught here:
        // ProviderScope is missing: "Bad state: No ProviderScope found"
        // "A RenderFlex overflowed by X pixels on the bottom."
        // Exceptions from synchronous code, e.g. non-async _onPressed
        _appContext.crashlyticsService?.onError(details.exception, details.stack ?? StackTrace.empty);
    }

    void _onRunZonedGuardedError(Object error, StackTrace stack)
    {
        // Examples for errors caught here:
        // Exceptions from synchronous code, e.g. async _onPressed
        _appContext.crashlyticsService?.onError(error, stack);
    }
}
