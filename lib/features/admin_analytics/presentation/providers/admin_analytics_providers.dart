import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_invalidation_registry.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_attach.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_providers.dart';
import 'package:rafiq_alhajj/features/admin_analytics/application/services/admin_analytics_service.dart';
import 'package:rafiq_alhajj/features/admin_analytics/data/repositories/admin_analytics_repository.dart';
import 'package:rafiq_alhajj/features/admin_analytics/domain/models/admin_dashboard_stats.dart';
import 'package:rafiq_alhajj/features/trips/presentation/providers/trips_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'admin_analytics_providers.g.dart';

@Riverpod(keepAlive: true)
AdminAnalyticsRepository adminAnalyticsRepository(Ref ref) {
  return AdminAnalyticsRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@Riverpod(keepAlive: true)
AdminAnalyticsService adminAnalyticsService(Ref ref) {
  return AdminAnalyticsService(ref.watch(adminAnalyticsRepositoryProvider));
}

@riverpod
class AdminDashboard extends _$AdminDashboard {
  @override
  Future<AdminDashboardStats> build() async {
    attachRealtimeSync(
      ref,
      syncKey: RealtimeSyncKeys.adminAnalytics,
      ensureSyncActive: (ref) => ref.watch(realtimeSyncAdminAnalyticsProvider),
      handlerId: 'admin_dashboard',
      onInvalidate: (ref) => ref.invalidate(adminDashboardProvider),
    );

    final tripId = await ref.watch(activeTripProvider.future);

    return ref.read(adminAnalyticsServiceProvider).loadDashboard(tripId: tripId);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}
