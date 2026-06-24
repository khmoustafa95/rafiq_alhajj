import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';

/// Initializes Firebase with platform-appropriate options.
///
/// Mobile uses the Android/iOS app id ([AppConfig.firebaseAppId]); the web
/// build needs a dedicated web app id plus `authDomain`/`storageBucket`
/// ([AppConfig.hasFirebaseWeb]) for FCM Web Push.
abstract final class AppFirebase {
  static const FirebaseOptions _mobileOptions = FirebaseOptions(
    apiKey: AppConfig.firebaseApiKey,
    appId: AppConfig.firebaseAppId,
    messagingSenderId: AppConfig.firebaseMessagingSenderId,
    projectId: AppConfig.firebaseProjectId,
    iosBundleId: AppConfig.firebaseIosBundleId,
  );

  static const FirebaseOptions _webOptions = FirebaseOptions(
    apiKey: AppConfig.firebaseApiKey,
    appId: AppConfig.firebaseWebAppId,
    messagingSenderId: AppConfig.firebaseMessagingSenderId,
    projectId: AppConfig.firebaseProjectId,
    authDomain: AppConfig.firebaseAuthDomain,
    storageBucket: AppConfig.firebaseStorageBucket,
    measurementId: AppConfig.firebaseMeasurementId,
  );

  static Future<void> initialize() async {
    final configured = kIsWeb ? AppConfig.hasFirebaseWeb : AppConfig.hasFirebase;
    if (!configured) {
      if (kDebugMode) {
        debugPrint(
          kIsWeb
              ? 'Firebase (web) skipped: set FIREBASE_PROJECT_ID, '
                  'FIREBASE_API_KEY, FIREBASE_WEB_APP_ID, '
                  'FIREBASE_MESSAGING_SENDER_ID, FIREBASE_AUTH_DOMAIN and '
                  'FIREBASE_VAPID_KEY via --dart-define.'
              : 'Firebase skipped: set FIREBASE_PROJECT_ID, FIREBASE_API_KEY, '
                  'FIREBASE_APP_ID, FIREBASE_MESSAGING_SENDER_ID via '
                  '--dart-define.',
        );
      }
      return;
    }

    if (Firebase.apps.isNotEmpty) {
      return;
    }

    await Firebase.initializeApp(options: options);
  }

  static FirebaseOptions get options => kIsWeb ? _webOptions : _mobileOptions;
}
