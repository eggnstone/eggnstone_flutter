import 'dart:async';

import 'package:eggnstone_flutter/eggnstone_flutter.dart';
import 'package:flutter_test/flutter_test.dart';

const String TIME_REGEX = r'\d{2}:\d{2}:\d{2}';

void main()
{
    testIsEnabled();
    testLogDebug();
    testLogInfo();
    testLogWarning();
    testLogError();
}

void testIsEnabled()
{
    group('isEnabled', ()
    {
        test('Logger created disabled => is not enabled', ()
        {
            ILoggerService logger = LoggerService(false);
            expect(logger.isEnabled, isFalse);
        });

        test('Logger created enabled => is enabled', ()
        {
            ILoggerService logger = LoggerService(true);
            expect(logger.isEnabled, isTrue);
        });

        test('Logger later enabled => is enabled', ()
        {
            ILoggerService logger = LoggerService(false);
            logger.isEnabled = true;
            expect(logger.isEnabled, isTrue);
        });

        test('Logger later disabled => is not enabled', ()
        {
            ILoggerService logger = LoggerService(true);
            logger.isEnabled = false;
            expect(logger.isEnabled, isFalse);
        });
    });
}

void testLogDebug()
{
    group('logDebug', ()
    {
        List<String> loggerNotEnabledLog = [];
        test('Logger not enabled => no log', overridePrint(loggerNotEnabledLog, ()
        {
            ILoggerService logger = LoggerService(false);
            logger.logDebug('Test');
            expect(loggerNotEnabledLog.length, 0);
        }));

        List<String> loggerEnabledLog = [];
        test('Logger enabled => log', overridePrint(loggerEnabledLog, ()
        {
            ILoggerService logger = LoggerService(true);
            logger.logDebug('Test');
            expect(loggerEnabledLog.length, 1);
        }));

        List<String> log = [];
        test('Prefixes text with time and type annotation', overridePrint(log, ()
        {
            const String MESSAGE = 'TestDebug';
            const String ANNOTATED_MESSAGE = 'Debug: ' + MESSAGE;

            ILoggerService logger = LoggerService(true);
            logger.logDebug(MESSAGE);
            expect(RegExp('^' + TIME_REGEX + ' ' + ANNOTATED_MESSAGE + '\$').hasMatch(log[0]), isTrue);
        }));
    });
}

void testLogInfo()
{
    group('logInfo', ()
    {
        List<String> loggerNotEnabledLog = [];
        test('Logger not enabled => no log', overridePrint(loggerNotEnabledLog, ()
        {
            ILoggerService logger = LoggerService(false);
            logger.logInfo('Test');
            expect(loggerNotEnabledLog.length, 0);
        }));

        List<String> loggerEnabledLog = [];
        test('Logger enabled => log', overridePrint(loggerEnabledLog, ()
        {
            ILoggerService logger = LoggerService(true);
            logger.logInfo('Test');
            expect(loggerEnabledLog.length, 1);
        }));

        List<String> log = [];
        test('Prefixes text with time and type annotation', overridePrint(log, ()
        {
            const String MESSAGE = 'TestInfo';
            const String ANNOTATED_MESSAGE = 'Info:  ' + MESSAGE;

            ILoggerService logger = LoggerService(true);
            logger.logInfo(MESSAGE);
            expect(RegExp('^' + TIME_REGEX + ' ' + ANNOTATED_MESSAGE + '\$').hasMatch(log[0]), isTrue);
        }));
    });
}

void testLogWarning()
{
    group('logWarning', ()
    {
        List<String> loggerNotEnabledLog = [];
        test('Logger not enabled => no log', overridePrint(loggerNotEnabledLog, ()
        {
            ILoggerService logger = LoggerService(false);
            logger.logWarning('Test');
            expect(loggerNotEnabledLog.length, 0);
        }));

        List<String> loggerEnabledLog = [];
        test('Logger enabled => log', overridePrint(loggerEnabledLog, ()
        {
            ILoggerService logger = LoggerService(true);
            logger.logWarning('Test');
            expect(loggerEnabledLog.length, 1);
        }));

        List<String> log = [];
        test('Prefixes text with time and type annotation', overridePrint(log, ()
        {
            const String MESSAGE = 'TestWarning';
            const String ANNOTATED_MESSAGE = 'Warn:  ' + MESSAGE;

            ILoggerService logger = LoggerService(true);
            logger.logWarning(MESSAGE);
            expect(RegExp('^' + TIME_REGEX + ' ' + ANNOTATED_MESSAGE + '\$').hasMatch(log[0]), isTrue);
        }));
    });
}

void testLogError()
{
    group('logError', ()
    {
        List<String> loggerNotEnabledLog = [];
        test('Logger not enabled => no log', overridePrint(loggerNotEnabledLog, ()
        {
            ILoggerService logger = LoggerService(false);
            logger.logError('Test');
            expect(loggerNotEnabledLog.length, 0);
        }));

        List<String> loggerEnabledLog = [];
        test('Logger enabled => log', overridePrint(loggerEnabledLog, ()
        {
            ILoggerService logger = LoggerService(true);
            logger.logError('Test');
            expect(loggerEnabledLog.length, 1);
        }));

        List<String> log = [];
        test('Prefixes text with time and type annotation', overridePrint(log, ()
        {
            const String MESSAGE = 'TestError';
            const String ANNOTATED_MESSAGE = 'ERROR: ' + MESSAGE;

            ILoggerService logger = LoggerService(true);
            logger.logError(MESSAGE);
            expect(RegExp('^' + TIME_REGEX + ' ' + ANNOTATED_MESSAGE + '\$').hasMatch(log[0]), isTrue);
        }));
    });
}

overridePrint(List<String> log, testFunction())
{
    return ()
    {
        var specification = new ZoneSpecification(
            print: (_, __, ___, String msg)
            {
                // Add to log instead of printing to stdout
                log.add(msg);
            }
        );

        return Zone.current.fork(specification: specification).run(testFunction);
    };
}
