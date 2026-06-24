import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/firebase/app_firebase.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/features/notifications/application/services/local_notifications_service.dart';
import 'package:rafiq_alhajj/features/notifications/application/utils/push_message_navigation.dart';
import 'package:rafiq_alhajj/features/notifications/data/repositories/device_token_repository.dart';

/// Registers FCM tokens and handles notification open events.
class PushNotificationService {
  PushNotificationService(
    this._tokenRepository, {
    LocalNotificationsService? localNotifications,
  }) : _localNotifications = localNotifications ?? LocalNotificationsService();

  final DeviceTokenRepository _tokenRepository;
  final LocalNotificationsService _localNotifications;

  FirebaseMessaging? _messaging;
  StreamSubscription<String>? _tokenRefreshSub;
  StreamSubscription<RemoteMessage>? _foregroundSub;
  String? _currentProfileId;
  String? _lastRegisteredToken;
  // Guards against handling the same opened message twice (e.g. both
  // getInitialMessage and onMessageOpenedApp firing for one tap).
  final Set<String> _handledOpenedMessageIds = {};

  bool get isSupported {
    if (!AppConfig.hasSupabase) {
      return false;
    }
    if (AppPlatform.isWeb) {
      return AppConfig.hasFirebaseWeb;
    }
    return AppConfig.hasFirebase &&
        (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS);
  }

  Future<void> initialize() async {
    if (!isSupported) {
      return;
    }

    await AppFirebase.initialize();
    _messaging = FirebaseMessaging.instance;

    // flutter_local_notifications has no web implementation; on web, foreground
    // messages are surfaced by the Realtime in-app toast and background ones by
    // the `firebase-messaging-sw.js` service worker.
    if (!AppPlatform.isWeb) {
      await _localNotifications.initialize();

      // iOS presents foreground notifications itself via these options; on
      // Android we render them through [_localNotifications] in
      // [_handleForeground].
      await _messaging!.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    await _requestPermission();

    _foregroundSub = FirebaseMessaging.onMessage.listen(_handleForeground);
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

    final token = await _fetchToken();
    if (token == null || token.isEmpty) {
      return;
    }

    await _persistToken(token);
  }

  // Web requires the VAPID public key to mint a token; mobile ignores it.
  Future<String?> _fetchToken() => _messaging?.getToken(
        vapidKey: AppPlatform.isWeb ? AppConfig.firebaseVapidKey : null,
      ) ??
      Future<String?>.value();

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

    // `defaultTargetPlatform` reports the host OS even on web (e.g. android on
    // a mobile browser), so check `kIsWeb` first to tag web tokens correctly.
    final platform = AppPlatform.isWeb
        ? 'web'
        : switch (defaultTargetPlatform) {
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
    final dedupeKey = message.messageId ??
        message.data['notification_id'] as String? ??
        message.data['id'] as String?;
    if (dedupeKey != null) {
      if (_handledOpenedMessageIds.contains(dedupeKey)) {
        return;
      }
      _handledOpenedMessageIds.add(dedupeKey);
    }
    navigateFromPushData(message.data);
  }

  /// Renders a system notification for messages received while the app is in
  /// the foreground. Only Android needs this; iOS shows them automatically and
  /// web relies on the Realtime in-app toast.
  void _handleForeground(RemoteMessage message) {
    if (AppPlatform.isWeb || defaultTargetPlatform != TargetPlatform.android) {
      return;
    }
    unawaited(_localNotifications.showFromRemoteMessage(message));
  }

  void dispose() {
    unawaited(_tokenRefreshSub?.cancel());
    unawaited(_foregroundSub?.cancel());
  }
}
