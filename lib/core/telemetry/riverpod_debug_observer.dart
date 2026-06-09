import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';

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

    debugPrint(
      '[riverpod] ${context.provider.name ?? context.provider.runtimeType} '
      '← ${_describeValue(previousValue)} → ${_describeValue(newValue)}',
    );
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

/// Enables Flutter's global dirty-widget rebuild logging (very verbose).
void enableWidgetRebuildLogging() {
  if (!kDebugMode || !AppConfig.rebuildDebugLog) {
    return;
  }
  debugPrintRebuildDirtyWidgets = true;
  debugPrint(
    '[rebuild] debugPrintRebuildDirtyWidgets enabled '
    '(REBUILD_DEBUG_LOG=true)',
  );
}
