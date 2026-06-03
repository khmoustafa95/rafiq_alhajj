/// Application environment configuration via `--dart-define`.
abstract final class AppConfig {
  static const String supabaseUrl = String.fromEnvironment('SUPABASE_URL');

  static const String supabaseAnonKey =
      String.fromEnvironment('SUPABASE_ANON_KEY');

  /// Set to `true` via `--dart-define=CRASH_REPORTING_ENABLED=true` for release builds.
  static const bool crashReportingEnabled = bool.fromEnvironment(
    'CRASH_REPORTING_ENABLED',
  );

  static const double designWidth = 375;
  static const double designHeight = 812;

  static bool get hasSupabase =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
}
