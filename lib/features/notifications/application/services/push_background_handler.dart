import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/firebase/app_firebase.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (!AppConfig.hasFirebase) {
    return;
  }

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(options: AppFirebase.options);
  }
}
