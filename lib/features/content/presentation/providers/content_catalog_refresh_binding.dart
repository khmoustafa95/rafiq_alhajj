import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/providers/competitions_providers.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_topics_providers.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/public_content_feed_provider.dart';
import 'package:rafiq_alhajj/features/hajj_journey/presentation/providers/hajj_journey_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'content_catalog_refresh_binding.g.dart';

/// Refreshes cached content catalogs when connectivity is restored.
@Riverpod(keepAlive: true)
void contentCatalogRefreshBinding(Ref ref) {
  var wasOffline = false;

  final sub = Connectivity().onConnectivityChanged.listen((results) {
    final online = results.any((r) => r != ConnectivityResult.none);
    if (wasOffline && online) {
      final accessMode = ref.read(authAccessModeProvider);
      ref.invalidate(homeContentFeedProvider(accessMode));
      ref.invalidate(contentTopicsListProvider(accessMode));
      ref.invalidate(hajjJourneyStepsProvider);
      ref.invalidate(activeCompetitionsProvider);
    }
    wasOffline = !online;
  });

  ref.onDispose(() => unawaited(sub.cancel()));
}
