import 'package:flutter/foundation.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';

/// Records uncaught errors for observability (Sentry, Crashlytics, etc.).
abstract interface class CrashReporter {
  void recordFlutterError(FlutterErrorDetails details);

  Future<void> recordError(Object error, StackTrace stack);

  static CrashReporter get instance => _instance;

  static CrashReporter _instance = createDefault();

  static CrashReporter createDefault() {
    return AppConfig.crashReportingEnabled
        ? const ConfiguredCrashReporter()
        : const DebugCrashReporter();
  }

  /// Called once during [AppBootstrap.initialize].
  static void install(CrashReporter reporter) {
    _instance = reporter;
  }
}

/// Logs in debug; no-op in release until a backend is configured.
final class DebugCrashReporter implements CrashReporter {
  const DebugCrashReporter();

  @override
  void recordFlutterError(FlutterErrorDetails details) {
    if (kDebugMode) {
      debugPrint('FlutterError: ${details.exceptionAsString()}');
    }
  }

  @override
  Future<void> recordError(Object error, StackTrace stack) async {
    if (kDebugMode) {
      debugPrint('Uncaught error: $error\n$stack');
    }
  }
}

/// Forwards errors when [AppConfig.crashReportingEnabled] is true.
final class ConfiguredCrashReporter implements CrashReporter {
  const ConfiguredCrashReporter();

  @override
  void recordFlutterError(FlutterErrorDetails details) {
    if (kDebugMode) {
      debugPrint('FlutterError: ${details.exceptionAsString()}');
    }
    // Integrate Sentry/Crashlytics: SentryFlutter.captureException(...)
  }

  @override
  Future<void> recordError(Object error, StackTrace stack) async {
    if (kDebugMode) {
      debugPrint('Uncaught error: $error\n$stack');
    }
    // Integrate Sentry/Crashlytics here in production.
  }
}
