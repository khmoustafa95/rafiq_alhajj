import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/notification_type.dart';

part 'inbox_notification.freezed.dart';

@freezed
abstract class InboxNotification with _$InboxNotification {
  const factory InboxNotification({
    required String id,
    required String recipientId,
    String? senderId,
    required InboxNotificationType type,
    required String titleAr,
    required String titleEn,
    String? bodyAr,
    String? bodyEn,
    @Default({}) Map<String, dynamic> payload,
    DateTime? readAt,
    required DateTime createdAt,
  }) = _InboxNotification;

  const InboxNotification._();

  bool get isRead => readAt != null;

  String titleForLocale(String languageCode) =>
      languageCode == 'ar' ? titleAr : titleEn;

  String? bodyForLocale(String languageCode) {
    final body = languageCode == 'ar' ? bodyAr : bodyEn;
    if (body != null && body.isNotEmpty) {
      return body;
    }
    final fallback = languageCode == 'ar' ? bodyEn : bodyAr;
    return fallback?.isNotEmpty == true ? fallback : null;
  }
}
