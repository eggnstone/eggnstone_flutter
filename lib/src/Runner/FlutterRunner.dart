import 'dart:async';

import 'package:eggnstone_dart/eggnstone_dart.dart';
import 'package:flutter/material.dart';

import 'AppCallbacks.dart';

class FlutterRunner
{
    final AppCallbacks _appContext = AppCallbacks();

    Future<void> run(Future<void> Function(AppCallbacks appContext) runApp)
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

        if (_appContext.onError == null)
            logError('FlutterRunner._onFlutterError', details.exception, details.stack);
        else
            _appContext.onError!.call(details.exception, details.stack ?? StackTrace.empty);
    }

    void _onRunZonedGuardedError(Object error, StackTrace stack)
    {
        // Examples for errors caught here:
        // Exceptions from synchronous code, e.g. async _onPressed

        if (_appContext.onError == null)
            logError('FlutterRunner._onFlutterError', error, stack);
        else
            _appContext.onError!.call(error, stack);
    }
}
