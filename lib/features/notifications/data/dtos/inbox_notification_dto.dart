import 'package:json_annotation/json_annotation.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/inbox_notification.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/notification_type.dart';

part 'inbox_notification_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class InboxNotificationDto {
  const InboxNotificationDto({
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

  factory InboxNotificationDto.fromJson(Map<String, dynamic> json) =>
      _$InboxNotificationDtoFromJson(json);

  final String id;
  final String recipientId;
  final String? senderId;
  final String type;
  final String titleAr;
  final String titleEn;
  final String? bodyAr;
  final String? bodyEn;
  final Map<String, dynamic> payload;
  @JsonKey(fromJson: _nullableDateTime, toJson: _dateTimeToJson)
  final DateTime? readAt;
  final DateTime createdAt;

  static DateTime? _nullableDateTime(Object? value) {
    if (value == null) {
      return null;
    }
    return DateTime.parse(value as String);
  }

  static String? _dateTimeToJson(DateTime? value) => value?.toIso8601String();

  InboxNotification toDomain() {
    return InboxNotification(
      id: id,
      recipientId: recipientId,
      senderId: senderId,
      type: InboxNotificationType.fromDatabase(type),
      titleAr: titleAr,
      titleEn: titleEn,
      bodyAr: bodyAr,
      bodyEn: bodyEn,
      payload: payload,
      readAt: readAt,
      createdAt: createdAt,
    );
  }
}
