import 'dart:async';

import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Returns true when [error] likely indicates a network/connectivity problem.
bool isStaffNetworkError(Object error) {
  if (error is TimeoutException) {
    return true;
  }
  if (error is PostgrestException) {
    final code = error.code?.toLowerCase() ?? '';
    if (code.contains('network') ||
        code.contains('timeout') ||
        code.contains('connection')) {
      return true;
    }
    final message = error.message.toLowerCase();
    return message.contains('network') ||
        message.contains('connection') ||
        message.contains('timeout') ||
        message.contains('failed host lookup');
  }

  final text = error.toString().toLowerCase();
  return text.contains('clientexception') ||
      text.contains('socketexception') ||
      text.contains('failed host lookup') ||
      text.contains('network is unreachable') ||
      text.contains('connection refused') ||
      text.contains('connection reset');
}

/// User-safe staff-area error message (never expose raw exception strings).
String staffErrorMessage(AppLocalizations l10n, Object error) {
  if (isStaffNetworkError(error)) {
    return l10n.staffErrorNetwork;
  }
  if (error is PostgrestException) {
    final code = error.code ?? '';
    if (code == '42501' || code == 'PGRST301') {
      return l10n.staffErrorPermission;
    }
  }
  return l10n.staffErrorGeneric;
}
