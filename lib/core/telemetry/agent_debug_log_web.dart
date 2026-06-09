import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';

import 'package:flutter/foundation.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:web/web.dart' as web;

const _endpoint =
    'http://127.0.0.1:7847/ingest/cf5411c0-ea2c-45e2-9533-e9b2eaad561e';
const _sessionId = 'a2793d';

void agentDebugLog({
  required String location,
  required String message,
  required String hypothesisId,
  Map<String, Object?> data = const {},
  String runId = 'pre-fix',
}) {
  if (!kDebugMode || !AppConfig.rebuildDebugLog) {
    return;
  }

  final body = jsonEncode({
    'sessionId': _sessionId,
    'timestamp': DateTime.now().millisecondsSinceEpoch,
    'location': location,
    'message': message,
    'hypothesisId': hypothesisId,
    'data': data,
    'runId': runId,
  });

  try {
    unawaited(
      web.window
          .fetch(
            _endpoint.toJS,
            web.RequestInit(
              method: 'POST',
              body: body.toJS,
              headers: {
                'Content-Type': 'application/json',
                'X-Debug-Session-Id': _sessionId,
              }.jsify()! as web.HeadersInit,
            ),
          )
          .toDart,
    );
  } catch (_) {
    debugPrint('[agent-debug] $body');
  }
}
