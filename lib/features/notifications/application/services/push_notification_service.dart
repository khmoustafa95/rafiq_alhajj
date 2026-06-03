import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/firebase/app_firebase.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/features/notifications/application/utils/push_message_navigation.dart';
import 'package:rafiq_alhajj/features/notifications/data/repositories/device_token_repository.dart';

/// Registers FCM tokens and handles notification open events.
class PushNotificationService {
  PushNotificationService(this._tokenRepository);

  final DeviceTokenRepository _tokenRepository;

  FirebaseMessaging? _messaging;
  StreamSubscription<String>? _tokenRefreshSub;
  String? _currentProfileId;
  String? _lastRegisteredToken;

  bool get isSupported =>
      !AppPlatform.isWeb &&
      AppConfig.hasFirebase &&
      AppConfig.hasSupabase &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  Future<void> initialize() async {
    if (!isSupported) {
      return;
    }

    await AppFirebase.initialize();
    _messaging = FirebaseMessaging.instance;

    await _messaging!.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await _requestPermission();

    FirebaseMessaging.onMessageOpenedApp.listen(_handleRemoteMessage);
    final initial = await _messaging!.getInitialMessage();
    if (initial != null) {
      _handleRemoteMessage(initial);
    }

    _tokenRefreshSub = _messaging!.onTokenRefresh.listen((token) {
      unawaited(_persistToken(token));
    });
  }

  Future<void> bindUser(String? profileId) async {
    _currentProfileId = profileId;

    if (!isSupported || profileId == null) {
      await _clearRegistration();
      return;
    }

    final token = await _messaging?.getToken();
    if (token == null || token.isEmpty) {
      return;
    }

    await _persistToken(token);
  }

  Future<void> unregisterCurrentUser() async {
    final profileId = _currentProfileId;
    final token = _lastRegisteredToken;

    if (profileId != null && token != null) {
      try {
        await _tokenRepository.deleteToken(
          profileId: profileId,
          token: token,
        );
      } on DeviceTokenException catch (e) {
        if (kDebugMode) {
          debugPrint('Push token delete failed: $e');
        }
      }
    }

    await _clearRegistration();
  }

  Future<void> _clearRegistration() async {
    _currentProfileId = null;
    _lastRegisteredToken = null;
    if (isSupported) {
      await _messaging?.deleteToken();
    }
  }

  Future<void> _requestPermission() async {
    final settings = await _messaging!.requestPermission();
    if (kDebugMode) {
      debugPrint('FCM permission: ${settings.authorizationStatus}');
    }
  }

  Future<void> _persistToken(String token) async {
    final profileId = _currentProfileId;
    if (profileId == null) {
      return;
    }

    final platform = switch (defaultTargetPlatform) {
      TargetPlatform.iOS => 'ios',
      TargetPlatform.android => 'android',
      _ => 'web',
    };

    try {
      await _tokenRepository.upsertToken(
        profileId: profileId,
        token: token,
        platform: platform,
      );
      _lastRegisteredToken = token;
    } on DeviceTokenException catch (e) {
      if (kDebugMode) {
        debugPrint('Push token upsert failed: $e');
      }
    }
  }

  void _handleRemoteMessage(RemoteMessage message) {
    navigateFromPushData(message.data);
  }

  void dispose() {
    unawaited(_tokenRefreshSub?.cancel());
  }
}
