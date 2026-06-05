import 'package:flutter_test/flutter_test.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';

void main() {
  test('AppConfig.hasSupabase reflects dart-defines', () {
    expect(
      AppConfig.hasSupabase,
      isTrue,
      reason: 'Run tests with --dart-define-from-file=dart_defines.android.local.json',
    );
    expect(AppConfig.supabaseUrl, contains('54321'));
  });
}
