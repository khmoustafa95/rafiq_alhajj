import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';

const _logPath = r'd:\RightCode\Rafiq Al-Hajj\rafiq_alhajj\debug-a2793d.log';
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

  final line = jsonEncode({
    'sessionId': _sessionId,
    'timestamp': DateTime.now().millisecondsSinceEpoch,
    'location': location,
    'message': message,
    'hypothesisId': hypothesisId,
    'data': data,
    'runId': runId,
  });

  try {
    File(_logPath).writeAsStringSync('$line\n', mode: FileMode.append);
  } catch (_) {
    debugPrint('[agent-debug] $line');
  }
}
