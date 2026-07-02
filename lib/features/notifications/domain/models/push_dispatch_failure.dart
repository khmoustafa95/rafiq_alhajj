/// A logged FCM delivery failure (admin observability).
class PushDispatchFailure {
  const PushDispatchFailure({
    required this.id,
    required this.notificationId,
    required this.recipientId,
    required this.deviceTokenPreview,
    required this.error,
    required this.attempts,
    required this.createdAt,
  });

  final String id;
  final String notificationId;
  final String recipientId;
  final String deviceTokenPreview;
  final String error;
  final int attempts;
  final DateTime createdAt;
}
