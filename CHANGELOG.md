## 4.2.1

* Added CrashlyticsMixin.

## 4.2.0

* Using freezed 3.0.0 now.

## 4.1.2

* Added (Nullable)Date to SharedPreferencesService.

## 4.1.1

* Added NullableDateTime to SharedPreferencesService.

## 4.1.0

* Added Date and Time.

## 4.0.1

* Changed AppContext to AppCallbacks.

## 4.0.0

* Improved FlutterRunner.
* Removed run() from CrashlyticsService.
* Removed CrashlyticsMixin.

## 3.8.2

* SharedPreferences: Added get/set nullable string.

## 3.8.1

* SharedPreferences: Added get/set nullable int.

## 3.8.0

* Added LoggerAnalyticsService.
* SharedPreferences: Added get/set nullable bool.

## 3.7.3

* Added FlutterRunner.

## 3.7.2

* Updated dependencies.

## 3.7.0

* Updated dependencies. Updated min SDK to 3.0.0

## 3.6.3

* Using eggnstone_dart for logging now.

## 3.6.2

* Added colors to logging.

## 3.5.0

* Updated dependencies.

## 3.4.5

* Added SharedPreferencesService.getDouble/setDouble().

## 3.4.4

* Added trackNumberValue,trackTextValue,trackActionAndNumberValue,trackActionAndTextValue to IAnalyticsService.

## 3.4.3

* Added isDebugEnabled to ICrashlyticsService.

## 3.4.2

* Added isDebugEnabled to IAnalyticsService.

## 3.4.1

* Added onError() to ICrashlyticsService.

## 3.4.0

* Added runAsync() to ICrashlyticsService.
* Deprecated run() to ICrashlyticsService.
* Updated dependencies.

## 3.3.2

* Updated dependencies.

## 3.3.1

* Added recordError() to ICrashlyticsService.

## 3.3.0

* Added recordError() to ICrashlyticsService.

## 3.2.2

* Updated dependencies and lints.

## 3.2.1

* Updated dependencies.

## 3.2.0

* Removed PackageInfo because it does not any value over package_info_plus, which you can use instead.

## 3.1.0

* Updated dependencies.

## 3.0.5

* UrlLauncherTools now doesn't call canLaunch() anymore.
* Added StringExtensions.
* Added StackTraceTools.
* Library cleanup.

## 3.0.4

* Nicer logging for non-Web. Old behavior available via: useNewLogger = false;

## 3.0.3

* UrlLauncherTools.launch now returns its result.

## 3.0.2

* Added ActionLink.

## 3.0.1

* Added PlatformTools.htmlNavigatorUserAgent()

## 3.0.0

* Breaking change: Replaced UrlLauncherService/UrlLauncherMixin with UrlLauncherTools.
* Breaking change: Removed DartTools (You can use kDebugMode from foundation.dart).
* Added HyperLink.
* Added PlatformTools.
* Added ClipboardTools.

## 2.0.0

* Breaking change: Replaced Logger Mixin/Service with LogTools.
* Added setUserId/setUserProperty to Analytics/Crashlytics. Changed empty screen name.
* Fixed type of stacktrace.

## 1.1.1

* Switched to package_info_plus.

## 1.1.0

* Supporting null safety / requiring Dart 2.12.0 now.

## 1.0.2

* Removed pointless futures from analytics tracking.

## 1.0.1

* Made stacktrace in analytics optional.

## 1.0.0

* Made stacktrace in analytics optional.

## 0.4.3

* Improved API documentation.

## 0.4.2

* Improved API documentation.

## 0.4.1

* Improved API documentation.

## 0.4.0

* Released with sound null safety.

## 0.4.0-nullsafety.5

* Preparing sound null safety.

## 0.4.0-nullsafety.4

* Preparing sound null safety.

## 0.4.0-nullsafety.3

* Preparing sound null safety.

## 0.4.0-nullsafety.2

* Preparing sound null safety.

## 0.4.0-nullsafety.1

* Preparing sound null safety.

## 0.4.0-nullsafety.0

* Preparing sound null safety.

## 0.3.6

* Updated dependencies.

## 0.3.5

* Updated dependencies.

## 0.3.4

* Fixed exports.

## 0.3.3

* Added PackageInfo.

## 0.3.2

* Updated dependencies.

## 0.3.1

* Adjusted environment.

## 0.3.0

* Extracted Google Crashlytics to eggnstone_google_crashlytics package.

## 0.2.2

* Updated dependencies.

## 0.2.1

* Added textScaleFactor to BusyDialog.

## 0.2.0

* Moved GoogleAnalytics to separate package.

## 0.1.24

* Added BusyDialog.

## 0.1.23

* Added BusyDialog.

## 0.1.22

* Renamed UrlLauncher to UrlLauncherService.

## 0.1.21

* Added UrlLauncher.

## 0.1.20

* Crashlytics: Added CrashlyticsSource.

## 0.1.19

* Analytics: trackWarning/trackError: Renamed source to message, made params optional.

## 0.1.18

* Added SharedPreferencesMixin.staticSharedPreferences.

## 0.1.17

* Added trackWarningWithException.

## 0.1.16

* Fixed DartTools.isReleaseBuild.

## 0.1.15

* Improved and expanded analytics.

## 0.1.14

* Improved and expanded analytics.

## 0.1.13

* Decoupled CrashlyticsService from GoogleAnalyticsService.

## 0.1.12

* Added generic AnalyticsNavigatorObserver.

## 0.1.11

* Added generic Analytics.

## 0.1.10

* Added generic Analytics.

## 0.1.9

* Added generic Analytics.

## 0.1.8

* Added generic Analytics.

## 0.1.7

* Renamed Analytics* to GoogleAnalytics*

## 0.1.6

* Decoupled CrashlyticsService from GoogleAnalyticsService.

## 0.1.5

* Added LoggerMixin.staticLogger.

## 0.1.4

* Added SharedPreferencesService.

## 0.1.3

* Crashlytics does not support web yet, logging to Analytics instead.

## 0.1.2

* Added more already existing methods to IAnalyticsService.

## 0.1.1

* Added missing export.

## 0.1.0

* Good enough for v0.1.0.

## 0.0.6

* Using firebase.analytics for web, because firebase_analytics does not support web yet.

## 0.0.5

* Using firebase_crashlytics instead of flutter_crashlytics now.

## 0.0.4

* Cleanup.

## 0.0.3

* Added DartTools and CrashlyticsService.

## 0.0.2

* Added AnalyticsNavigatorObserver.

## 0.0.1

* Added AnalyticsService.
* Removed ILoggerService (YAGNI).
* Added LoggerService.
