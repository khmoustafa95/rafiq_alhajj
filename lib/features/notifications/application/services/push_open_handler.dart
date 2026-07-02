/// Optional callback invoked when the user opens a push notification.
///
/// Registered from [pushNotificationBinding] so navigation code can mark the
/// inbox row as read (Gmail/Slack-style) without depending on Riverpod.
typedef PushOpenCallback = Future<void> Function(Map<String, dynamic> data);

class PushOpenHandler {
  PushOpenHandler._();

  static PushOpenCallback? onOpen;

  static Future<void> handleOpen(Map<String, dynamic> data) async {
    final callback = onOpen;
    if (callback == null) {
      return;
    }
    await callback(data);
  }
}
