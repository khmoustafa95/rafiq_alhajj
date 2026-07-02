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
  Future<void>? _initialization;
  StreamSubscription<String>? _tokenRefreshSub;
  StreamSubscription<RemoteMessage>? _foregroundSub;
  String? _currentProfileId;
  String? _lastRegisteredToken;
  bool _permissionRequested = false;
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

  /// Runs [_initialize] at most once. `bindUser` awaits this so a token is
  /// never fetched before FCM setup + permission completes (otherwise
  /// `getToken()` returns null and the token is never registered).
  Future<void> initialize() => _initialization ??= _initialize();

  Future<void> _initialize() async {
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

    _foregroundSub = FirebaseMessaging.onMessage.listen(_handleForeground);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleRemoteMessage);
    final initial = await _messaging!.getInitialMessage();
    if (initial != null) {
      _handleRemoteMessage(initial);
    }

    _tokenRefreshSub = _messaging!.onTokenRefresh.listen((token) {
      unawaited(_onTokenRefreshed(token));
    });
  }

  Future<void> bindUser(String? profileId) async {
    _currentProfileId = profileId;

    if (!isSupported || profileId == null) {
      if (kDebugMode) {
        debugPrint(
          'FCM bindUser skipped: supported=$isSupported profile=$profileId',
        );
      }
      return;
    }

    // Ensure FCM is fully initialized before requesting a token. The auth
    // listener can fire `bindUser` before `initialize()` finishes (e.g. on a
    // relaunch with an already-signed-in user); calling getToken too early
    // returns null. `initialize()` is idempotent so this is cheap when done.
    await initialize();
    await _requestPermissionIfNeeded();

    String? token;
    try {
      token = await _fetchToken();
    } catch (e) {
      if (kDebugMode) {
        debugPrint('FCM getToken failed: $e');
      }
      return;
    }

    if (kDebugMode) {
      final preview = (token == null || token.isEmpty)
          ? 'NULL/EMPTY'
          : 'len=${token.length} ${token.substring(0, 12)}…';
      debugPrint('FCM bindUser profile=$profileId token=$preview');
    }

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

    _clearRegistration();
  }

  // Clears local registration state only. We intentionally do NOT call
  // `_messaging.deleteToken()`: the DB row is already removed in
  // `unregisterCurrentUser()`, which is what stops server-side push targeting.
  // Deleting the FCM token device-wide forces a fresh mint and can leave the
  // next signed-in user without a token (getToken() races and returns null
  // right after a delete), which silently breaks re-registration on re-login.
  void _clearRegistration() {
    _currentProfileId = null;
    _lastRegisteredToken = null;
  }

  Future<void> _requestPermissionIfNeeded() async {
    if (_permissionRequested) {
      return;
    }
    _permissionRequested = true;

    final settings = await _messaging!.requestPermission();
    if (kDebugMode) {
      debugPrint('FCM permission: ${settings.authorizationStatus}');
    }
  }

  Future<void> _onTokenRefreshed(String newToken) async {
    final profileId = _currentProfileId;
    final oldToken = _lastRegisteredToken;

    if (profileId != null &&
        oldToken != null &&
        oldToken.isNotEmpty &&
        oldToken != newToken) {
      try {
        await _tokenRepository.deleteToken(
          profileId: profileId,
          token: oldToken,
        );
      } on DeviceTokenException catch (e) {
        if (kDebugMode) {
          debugPrint('Push token rotation cleanup failed: $e');
        }
      }
    }

    await _persistToken(newToken);
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
      if (kDebugMode) {
        debugPrint('FCM token persisted ($platform) for profile $profileId');
      }
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
