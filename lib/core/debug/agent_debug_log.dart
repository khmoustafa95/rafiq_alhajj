import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

/// Debug-session logger (NDJSON ingest). Fold with #region agent log in callers.
abstract final class AgentDebugLog {
  static const _sessionId = '6a4de3';
  static const _ingestPath =
      '/ingest/cf5411c0-ea2c-45e2-9533-e9b2eaad561e';

  static void log(
    String location,
    String message, {
    String? hypothesisId,
    Map<String, Object?>? data,
    String runId = 'pre-fix',
  }) {
    if (kReleaseMode) {
      return;
    }
    unawaited(
      _post(
        location: location,
        message: message,
        hypothesisId: hypothesisId,
        data: data,
        runId: runId,
      ),
    );
  }

  static String _host() {
    if (kIsWeb) {
      return '127.0.0.1';
    }
    if (Platform.isAndroid) {
      return '10.0.2.2';
    }
    return '127.0.0.1';
  }

  static Future<void> _post({
    required String location,
    required String message,
    String? hypothesisId,
    Map<String, Object?>? data,
    required String runId,
  }) async {
    final client = HttpClient();
    try {
      final request = await client.post(
        _host(),
        7847,
        _ingestPath,
      );
      request.headers.contentType = ContentType.json;
      request.headers.set('X-Debug-Session-Id', _sessionId);
      request.write(
        jsonEncode({
          'sessionId': _sessionId,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          'location': location,
          'message': message,
          'hypothesisId': ?hypothesisId,
          'data': ?data,
          'runId': runId,
        }),
      );
      await request.close();
    } catch (_) {
      // Best-effort debug logging only.
    } finally {
      client.close(force: true);
    }
  }
}
