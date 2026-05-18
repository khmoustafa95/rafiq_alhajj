import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
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
    WidgetsFlutterBinding.ensureInitialized();

    _configureErrorHandlers();

    await _initializeSupabase();

    final container = ProviderContainer();
    return container;
  }

  static void _configureErrorHandlers() {
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      if (kReleaseMode) {
        // Hook crash reporting (e.g. Firebase Crashlytics) here.
      }
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      if (kReleaseMode) {
        // Hook crash reporting here.
      }
      return true;
    };
  }

  static Future<void> _initializeSupabase() async {
    if (!AppConfig.hasSupabase) {
      if (kDebugMode) {
        debugPrint(
          'Supabase skipped: set SUPABASE_URL and SUPABASE_ANON_KEY '
          'via --dart-define to enable.',
        );
      }
      return;
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
