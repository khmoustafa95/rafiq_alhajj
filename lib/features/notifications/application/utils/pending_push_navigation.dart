/// Holds a push-tap payload until [rootNavigatorKey] has a [BuildContext].
abstract final class PendingPushNavigation {
  static Map<String, dynamic>? _pending;

  static bool get hasPending => _pending != null;

  static void setPending(Map<String, dynamic> data) {
    _pending = Map<String, dynamic>.from(data);
  }

  static Map<String, dynamic>? takePending() {
    final pending = _pending;
    _pending = null;
    return pending;
  }
}
