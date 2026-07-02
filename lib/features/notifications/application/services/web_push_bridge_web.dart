import 'dart:convert';
import 'dart:js_interop';

import 'package:rafiq_alhajj/features/notifications/application/utils/push_message_navigation.dart';
import 'package:web/web.dart' as web;

/// Listens for notification-click messages posted by `firebase-messaging-sw.js`.
void startWebPushClickListener() {
  web.window.navigator.serviceWorker.addEventListener(
    'message',
    ((web.Event event) {
      final messageEvent = event as web.MessageEvent;
      final raw = messageEvent.data;
      if (raw == null || !raw.isA<JSString>()) {
        return;
      }

      try {
        final decoded = jsonDecode((raw as JSString).toDart);
        if (decoded is! Map) {
          return;
        }
        final envelope = decoded.cast<String, dynamic>();
        if (envelope['type'] != 'push_notification_click') {
          return;
        }
        final payload = envelope['data'];
        if (payload is Map) {
          navigateFromPushData(payload.cast<String, dynamic>());
        }
      } on FormatException {
        return;
      }
    }).toJS,
  );
}

/// Reads `?push_route=&push_id=` when the SW opened a new browser tab.
void consumeWebPushLaunchParams() {
  final params = Uri.base.queryParameters;
  final route = params['push_route'];
  if (route == null || route.isEmpty) {
    return;
  }

  navigateFromPushData({
    'route': route,
    if (params['push_id'] != null) 'id': params['push_id']!,
  });

  final cleaned = Uri.base.replace(queryParameters: {});
  web.window.history.replaceState(null, '', cleaned.toString());
}
