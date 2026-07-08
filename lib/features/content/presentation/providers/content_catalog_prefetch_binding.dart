import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/providers/competitions_providers.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_catalog_providers.dart';
import 'package:rafiq_alhajj/features/hajj_journey/presentation/providers/hajj_journey_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'content_catalog_prefetch_binding.g.dart';

Future<bool> _isOnWifi() async {
  final results = await Connectivity().checkConnectivity();
  return results.any(
    (r) => r == ConnectivityResult.wifi || r == ConnectivityResult.ethernet,
  );
}

Future<void> _prefetchCatalog(Ref ref, AppAccessMode accessMode) async {
  if (accessMode != AppAccessMode.pilgrim && accessMode != AppAccessMode.guest) {
    return;
  }
  if (!await _isOnWifi()) {
    return;
  }

  final isPilgrim = accessMode == AppAccessMode.pilgrim;
  final profileId = ref.read(authProfileIdProvider);

  try {
    final catalog = await ref.read(contentCatalogServiceProvider.future);
    await catalog.refreshCatalog(
      isPilgrim: isPilgrim,
      profileId: profileId,
    );

    final cache = await ref.read(contentCatalogCacheProvider.future);
    await ref.read(hajjJourneyServiceProvider).loadActiveSteps(cache: cache);

    if (isPilgrim && profileId != null) {
      final competitions = await ref
          .read(competitionsServiceProvider)
          .loadActiveCompetitions(cache: cache);
      for (final competition in competitions) {
        await ref.read(competitionsServiceProvider).fetchQuizProgress(
              cache: cache,
              competitionId: competition.id,
              profileId: profileId,
            );
      }
    }
  } catch (_) {
    // Prefetch is best-effort.
  }
}

/// Prefetches catalog metadata on Wi-Fi after pilgrim/guest session is active.
@Riverpod(keepAlive: true)
void contentCatalogPrefetchBinding(Ref ref) {
  var lastScope = '';

  void schedulePrefetch(AppAccessMode accessMode) {
    final profileId = ref.read(authProfileIdProvider);
    final scope = '${accessMode.name}_${profileId ?? 'anon'}';
    if (scope == lastScope) {
      return;
    }
    lastScope = scope;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_prefetchCatalog(ref, accessMode));
    });
  }

  ref.listen(authAccessModeProvider, (previous, next) {
    schedulePrefetch(next);
  }, fireImmediately: true);
}
