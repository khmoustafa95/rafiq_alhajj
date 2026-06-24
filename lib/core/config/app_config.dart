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

  /// Opt-in Riverpod + widget rebuild logs:
  /// `--dart-define=REBUILD_DEBUG_LOG=true` (debug builds only).
  static const bool rebuildDebugLog = bool.fromEnvironment('REBUILD_DEBUG_LOG');

  static bool get rebuildDebugLogDiagnostics =>
      kDebugMode && rebuildDebugLog;

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

  /// Web-specific Firebase App ID (`1:...:web:...`). Distinct from the
  /// Android/iOS [firebaseAppId] and required for FCM Web Push.
  static const String firebaseWebAppId =
      String.fromEnvironment('FIREBASE_WEB_APP_ID');

  /// Required by web [FirebaseOptions] (e.g. `your-project.firebaseapp.com`).
  static const String firebaseAuthDomain =
      String.fromEnvironment('FIREBASE_AUTH_DOMAIN');

  /// Required by web [FirebaseOptions] (e.g. `your-project.appspot.com`).
  static const String firebaseStorageBucket =
      String.fromEnvironment('FIREBASE_STORAGE_BUCKET');

  /// VAPID public key from Firebase Console → Cloud Messaging → Web Push
  /// certificates. Required by `FirebaseMessaging.getToken(vapidKey:)` on web.
  static const String firebaseVapidKey =
      String.fromEnvironment('FIREBASE_VAPID_KEY');

  /// Optional Google Analytics measurement id (`G-XXXXXXX`) for web.
  static const String firebaseMeasurementId =
      String.fromEnvironment('FIREBASE_MEASUREMENT_ID');

  static const double designWidth = 375;
  static const double designHeight = 812;

  static bool get hasSupabase =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;

  static bool get hasFirebase =>
      firebaseProjectId.isNotEmpty &&
      firebaseApiKey.isNotEmpty &&
      firebaseAppId.isNotEmpty &&
      firebaseMessagingSenderId.isNotEmpty;

  /// Whether FCM Web Push is fully configured. Web needs a dedicated web App ID,
  /// `authDomain` and a VAPID key in addition to the shared Firebase fields.
  static bool get hasFirebaseWeb =>
      firebaseProjectId.isNotEmpty &&
      firebaseApiKey.isNotEmpty &&
      firebaseMessagingSenderId.isNotEmpty &&
      firebaseWebAppId.isNotEmpty &&
      firebaseAuthDomain.isNotEmpty &&
      firebaseVapidKey.isNotEmpty;
}
