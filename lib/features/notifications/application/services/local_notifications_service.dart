import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rafiq_alhajj/features/notifications/application/utils/push_message_navigation.dart';
import 'package:rafiq_alhajj/features/notifications/application/utils/push_notification_channels.dart';

/// Renders system-tray (heads-up) notifications for foreground FCM messages,
/// matching the behavior users expect from most apps. Android relies on this
/// service; iOS shows foreground alerts via FCM presentation options.
class LocalNotificationsService {
  LocalNotificationsService();

  static const String _groupKey = 'rafiq_alhajj_notifications';

  static const _channels = <({String id, String name, String description, Importance importance})>[
    (
      id: PushNotificationChannels.announcements,
      name: 'إعلانات',
      description: 'إعلانات عامة من إدارة الرحلة',
      importance: Importance.defaultImportance,
    ),
    (
      id: PushNotificationChannels.content,
      name: 'محتوى جديد',
      description: 'أخبار ومحتوى تعليمي جديد',
      importance: Importance.defaultImportance,
    ),
    (
      id: PushNotificationChannels.competitions,
      name: 'مسابقات',
      description: 'مسابقات وتحديات جديدة',
      importance: Importance.defaultImportance,
    ),
    (
      id: PushNotificationChannels.urgent,
      name: 'تنبيهات عاجلة',
      description: 'النجدة وتحديثات الحالة وتنبيهات النظام',
      importance: Importance.high,
    ),
  ];

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    const androidSettings =
        AndroidInitializationSettings('@drawable/ic_stat_notification');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await _plugin.initialize(
      settings: const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
      onDidReceiveNotificationResponse: _onResponse,
    );

    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    for (final channel in _channels) {
      await androidPlugin?.createNotificationChannel(
        AndroidNotificationChannel(
          channel.id,
          channel.name,
          description: channel.description,
          importance: channel.importance,
        ),
      );
    }

    _initialized = true;
  }

  /// Shows a heads-up notification from a foreground [message].
  Future<void> showFromRemoteMessage(RemoteMessage message) async {
    final title = _localizedTitle(message);
    final body = _localizedBody(message);

    if ((title == null || title.isEmpty) && (body == null || body.isEmpty)) {
      return;
    }

    final type = message.data['type'] as String?;
    final channelId = PushNotificationChannels.forType(type);
    final channelMeta = _channels.firstWhere(
      (c) => c.id == channelId,
      orElse: () => _channels.first,
    );

    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelMeta.name,
      channelDescription: channelMeta.description,
      importance: channelMeta.importance,
      priority: channelMeta.importance == Importance.high
          ? Priority.high
          : Priority.defaultPriority,
      icon: '@drawable/ic_stat_notification',
      groupKey: _groupKey,
    );
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    await _plugin.show(
      id: message.messageId.hashCode,
      title: title,
      body: body,
      notificationDetails: NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      ),
      payload: jsonEncode(message.data),
    );
  }

  void _onResponse(NotificationResponse response) {
    final payload = response.payload;
    if (payload == null || payload.isEmpty) {
      return;
    }

    try {
      final decoded = jsonDecode(payload);
      if (decoded is Map) {
        final data = decoded.cast<String, dynamic>();
        navigateFromPushData(data);
      }
    } on FormatException catch (e) {
      if (kDebugMode) {
        debugPrint('Invalid notification payload: $e');
      }
    }
  }

  String? _localizedTitle(RemoteMessage message) {
    final data = message.data;
    final locale = PlatformDispatcher.instance.locale.languageCode;
    if (locale == 'ar') {
      return _nonEmpty(data['title_ar'] as String?) ??
          message.notification?.title ??
          _nonEmpty(data['title_en'] as String?);
    }
    return _nonEmpty(data['title_en'] as String?) ??
        message.notification?.title ??
        _nonEmpty(data['title_ar'] as String?);
  }

  String? _localizedBody(RemoteMessage message) {
    final data = message.data;
    final locale = PlatformDispatcher.instance.locale.languageCode;
    if (locale == 'ar') {
      return _nonEmpty(data['body_ar'] as String?) ??
          message.notification?.body ??
          _nonEmpty(data['body_en'] as String?);
    }
    return _nonEmpty(data['body_en'] as String?) ??
        message.notification?.body ??
        _nonEmpty(data['body_ar'] as String?);
  }

  String? _nonEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    return value;
  }
}
