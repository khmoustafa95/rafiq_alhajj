// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inbox_notification_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InboxNotificationDto _$InboxNotificationDtoFromJson(
  Map<String, dynamic> json,
) => InboxNotificationDto(
  id: json['id'] as String,
  recipientId: json['recipient_id'] as String,
  senderId: json['sender_id'] as String?,
  type: json['type'] as String,
  titleAr: json['title_ar'] as String,
  titleEn: json['title_en'] as String,
  bodyAr: json['body_ar'] as String?,
  bodyEn: json['body_en'] as String?,
  payload: json['payload'] as Map<String, dynamic>,
  readAt: InboxNotificationDto._nullableDateTime(json['read_at']),
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$InboxNotificationDtoToJson(
  InboxNotificationDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'recipient_id': instance.recipientId,
  'sender_id': instance.senderId,
  'type': instance.type,
  'title_ar': instance.titleAr,
  'title_en': instance.titleEn,
  'body_ar': instance.bodyAr,
  'body_en': instance.bodyEn,
  'payload': instance.payload,
  'read_at': InboxNotificationDto._dateTimeToJson(instance.readAt),
  'created_at': instance.createdAt.toIso8601String(),
};
