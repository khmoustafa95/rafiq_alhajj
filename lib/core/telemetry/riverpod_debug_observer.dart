import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/telemetry/agent_debug_log.dart';

/// Logs Riverpod provider updates when [AppConfig.rebuildDebugLog] is enabled.
///
/// Enable with: `--dart-define=REBUILD_DEBUG_LOG=true`
final class RiverpodDebugObserver extends ProviderObserver {
  const RiverpodDebugObserver();

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    if (!AppConfig.rebuildDebugLog) {
      return;
    }

    final name = context.provider.name ?? context.provider.runtimeType.toString();
    debugPrint(
      '[riverpod] $name '
      '← ${_describeValue(previousValue)} → ${_describeValue(newValue)}',
    );
    // #region agent log
    agentDebugLog(
      location: 'riverpod_debug_observer.dart:didUpdateProvider',
      message: 'Provider updated',
      hypothesisId: 'B',
      data: {
        'provider': name,
        'previous': _describeValue(previousValue),
        'next': _describeValue(newValue),
      },
    );
    // #endregion
  }

  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    if (!AppConfig.rebuildDebugLog) {
      return;
    }

    debugPrint(
      '[riverpod] ${context.provider.name ?? context.provider.runtimeType} '
      'added: ${_describeValue(value)}',
    );
  }

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    if (!AppConfig.rebuildDebugLog) {
      return;
    }

    debugPrint(
      '[riverpod] ${context.provider.name ?? context.provider.runtimeType} disposed',
    );
  }

  static String _describeValue(Object? value) {
    if (value is AsyncValue<dynamic>) {
      return 'AsyncValue('
          'loading: ${value.isLoading}, '
          'hasValue: ${value.hasValue}, '
          'hasError: ${value.hasError}'
          ')';
    }
    final text = value.toString();
    if (text.length > 120) {
      return '${text.substring(0, 117)}...';
    }
    return text;
  }
}

/// Enables targeted rebuild instrumentation (see [agentDebugLog]).
void enableWidgetRebuildLogging() {
  if (!kDebugMode || !AppConfig.rebuildDebugLog) {
    return;
  }
  debugPrint(
    '[rebuild] Targeted NDJSON logging enabled (REBUILD_DEBUG_LOG=true). '
    'Global debugPrintRebuildDirtyWidgets is off to reduce noise.',
  );
}
