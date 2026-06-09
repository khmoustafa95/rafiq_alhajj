import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/telemetry/crash_reporter.dart';
import 'package:rafiq_alhajj/core/telemetry/riverpod_debug_observer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Thrown when application startup fails.
class BootstrapException implements Exception {
  const BootstrapException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => 'BootstrapException: $message';
}

/// Configures global handlers and initializes services before [runApp].
abstract final class AppBootstrap {
  static Future<ProviderContainer> initialize() async {
    CrashReporter.install(CrashReporter.createDefault());

    _configureErrorHandlers();

    await _initializeSupabase();

    if (AppConfig.rebuildDebugLogDiagnostics) {
      enableWidgetRebuildLogging();
    }

    final container = ProviderContainer(
      observers: AppConfig.rebuildDebugLogDiagnostics
          ? const [RiverpodDebugObserver()]
          : const [],
    );
    return container;
  }

  static void _configureErrorHandlers() {
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      CrashReporter.instance.recordFlutterError(details);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      unawaited(CrashReporter.instance.recordError(error, stack));
      return true;
    };
  }

  static Future<void> _initializeSupabase() async {
    if (!AppConfig.hasSupabase) {
      if (kDebugMode) {
        debugPrint(
          'Supabase skipped: set SUPABASE_URL and SUPABASE_ANON_KEY '
          'via --dart-define-from-file=dart_defines.android.local.json '
          '(Android) or dart_defines.local.json (web), then full restart.',
        );
      }
      return;
    }

    if (kDebugMode) {
      debugPrint('Supabase configured: ${AppConfig.supabaseUrl}');
    }

    try {
      await Supabase.initialize(
        url: AppConfig.supabaseUrl,
        anonKey: AppConfig.supabaseAnonKey,
      );
    } on AuthException catch (e) {
      throw BootstrapException(
        'Supabase authentication configuration failed.',
        cause: e,
      );
    } catch (e) {
      throw BootstrapException(
        'Supabase initialization failed.',
        cause: e,
      );
    }
  }
}
