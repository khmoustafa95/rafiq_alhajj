import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_invalidation_registry.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_attach.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_providers.dart';
import 'package:rafiq_alhajj/features/admin_groups/application/services/admin_groups_service.dart';
import 'package:rafiq_alhajj/features/admin_groups/data/repositories/admin_groups_repository.dart';
import 'package:rafiq_alhajj/features/admin_groups/domain/models/group_editor_input.dart';
import 'package:rafiq_alhajj/features/admin_groups/domain/models/hajj_group.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'admin_groups_providers.g.dart';

@Riverpod(keepAlive: true)
AdminGroupsRepository adminGroupsRepository(Ref ref) {
  return AdminGroupsRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@Riverpod(keepAlive: true)
AdminGroupsService adminGroupsService(Ref ref) {
  return AdminGroupsService(ref.watch(adminGroupsRepositoryProvider));
}

@riverpod
Future<PaginatedResult<HajjGroup>> adminGroupListPage(
  Ref ref,
  StaffTableQuery query,
) async {
  attachRealtimeSync(
    ref,
    syncKey: RealtimeSyncKeys.adminGroups,
    ensureSyncActive: (ref) => ref.watch(realtimeSyncAdminGroupsProvider),
    handlerId: 'admin_group_list',
    onInvalidate: (ref) => ref.invalidate(adminGroupListPageProvider),
  );

  return ref.read(adminGroupsServiceProvider).listPage(query);
}

@riverpod
Future<HajjGroup> adminGroupDetail(Ref ref, String id) async {
  return ref.read(adminGroupsServiceProvider).getGroup(id);
}

@riverpod
class AdminGroupSave extends _$AdminGroupSave {
  @override
  FutureOr<void> build() {}

  Future<bool> save(GroupEditorInput input) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(adminGroupsServiceProvider).save(input);
      ref.invalidate(adminGroupListPageProvider);
      if (input.id != null) {
        ref.invalidate(adminGroupDetailProvider(input.id!));
      }
    });
    return !state.hasError;
  }
}

@riverpod
class AdminGroupDelete extends _$AdminGroupDelete {
  @override
  FutureOr<void> build() {}

  Future<bool> remove(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(adminGroupsServiceProvider).remove(id);
      ref.invalidate(adminGroupListPageProvider);
    });
    return !state.hasError;
  }
}
