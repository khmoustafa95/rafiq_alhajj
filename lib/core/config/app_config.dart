import 'package:flutter/foundation.dart';

/// Application environment configuration via `--dart-define`.
abstract final class AppConfig {
  static const String supabaseUrl = String.fromEnvironment('SUPABASE_URL');

  static const String supabaseAnonKey =
      String.fromEnvironment('SUPABASE_ANON_KEY');

  /// Set to `true` via `--dart-define=CRASH_REPORTING_ENABLED=true` for release builds.
  static const bool crashReportingEnabled = bool.fromEnvironment(
    'CRASH_REPORTING_ENABLED',
  );

  /// Opt-in GoRouter logs: `--dart-define=ROUTER_DEBUG_LOG=true` (debug builds only).
  static const bool routerDebugLog = bool.fromEnvironment('ROUTER_DEBUG_LOG');

  static bool get routerDebugLogDiagnostics =>
      kDebugMode && routerDebugLog;

  static const String firebaseProjectId =
      String.fromEnvironment('FIREBASE_PROJECT_ID');

  static const String firebaseApiKey =
      String.fromEnvironment('FIREBASE_API_KEY');

  static const String firebaseAppId = String.fromEnvironment('FIREBASE_APP_ID');

  static const String firebaseMessagingSenderId =
      String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID');

  static const String firebaseIosBundleId = String.fromEnvironment(
    'FIREBASE_IOS_BUNDLE_ID',
    defaultValue: 'com.example.rafiqAlhajj',
  );

  static const double designWidth = 375;
  static const double designHeight = 812;

  static bool get hasSupabase =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;

  static bool get hasFirebase =>
      firebaseProjectId.isNotEmpty &&
      firebaseApiKey.isNotEmpty &&
      firebaseAppId.isNotEmpty &&
      firebaseMessagingSenderId.isNotEmpty;
}
