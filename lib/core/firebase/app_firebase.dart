import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';

/// Initializes Firebase when [AppConfig.hasFirebase] is true.
abstract final class AppFirebase {
  static const FirebaseOptions _options = FirebaseOptions(
    apiKey: AppConfig.firebaseApiKey,
    appId: AppConfig.firebaseAppId,
    messagingSenderId: AppConfig.firebaseMessagingSenderId,
    projectId: AppConfig.firebaseProjectId,
    iosBundleId: AppConfig.firebaseIosBundleId,
  );

  static Future<void> initialize() async {
    if (!AppConfig.hasFirebase) {
      if (kDebugMode) {
        debugPrint(
          'Firebase skipped: set FIREBASE_PROJECT_ID, FIREBASE_API_KEY, '
          'FIREBASE_APP_ID, FIREBASE_MESSAGING_SENDER_ID via --dart-define.',
        );
      }
      return;
    }

    if (Firebase.apps.isNotEmpty) {
      return;
    }

    await Firebase.initializeApp(options: _options);
  }

  static FirebaseOptions get options => _options;
}
