import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_media_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'content_download_recovery_binding.g.dart';

Future<void> _reconcileOfflineMedia(Ref ref) async {
  try {
    final cache = await ref.read(contentMediaCacheServiceProvider.future);
    await cache.reconcileManifest();
  } catch (_) {
    // Recovery is best-effort.
  }
}

/// Reconciles the encrypted media manifest when the app resumes.
@Riverpod(keepAlive: true)
void contentDownloadRecoveryBinding(Ref ref) {
  final listener = AppLifecycleListener(
    onResume: () {
      unawaited(_reconcileOfflineMedia(ref));
    },
  );

  ref.onDispose(listener.dispose);

  WidgetsBinding.instance.addPostFrameCallback((_) {
    unawaited(_reconcileOfflineMedia(ref));
  });
}
