import 'package:rafiq_alhajj/features/notifications/domain/models/notification_type.dart';

class InboxNotification {
  const InboxNotification({
    required this.id,
    required this.recipientId,
    required this.senderId,
    required this.type,
    required this.titleAr,
    required this.titleEn,
    required this.bodyAr,
    required this.bodyEn,
    required this.payload,
    required this.readAt,
    required this.createdAt,
  });

  final String id;
  final String recipientId;
  final String? senderId;
  final InboxNotificationType type;
  final String titleAr;
  final String titleEn;
  final String? bodyAr;
  final String? bodyEn;
  final Map<String, dynamic> payload;
  final DateTime? readAt;
  final DateTime createdAt;

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
