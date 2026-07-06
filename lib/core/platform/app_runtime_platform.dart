import 'package:flutter/foundation.dart';

/// Runtime platform key stored in [app_version_policies.platform].
enum AppRuntimePlatform {
  android('android'),
  ios('ios'),
  web('web');

  const AppRuntimePlatform(this.storageKey);

  final String storageKey;

  static AppRuntimePlatform get current {
    if (kIsWeb) {
      return AppRuntimePlatform.web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AppRuntimePlatform.android;
      case TargetPlatform.iOS:
        return AppRuntimePlatform.ios;
      default:
        return AppRuntimePlatform.android;
    }
  }
}
