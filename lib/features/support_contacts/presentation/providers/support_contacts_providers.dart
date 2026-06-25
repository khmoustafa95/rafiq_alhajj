import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_invalidation_registry.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_attach.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_providers.dart';
import 'package:rafiq_alhajj/features/support_contacts/application/services/support_contacts_service.dart';
import 'package:rafiq_alhajj/features/support_contacts/data/repositories/support_contacts_repository.dart';
import 'package:rafiq_alhajj/features/support_contacts/domain/models/support_contact.dart';
import 'package:rafiq_alhajj/features/support_contacts/domain/models/support_contact_input.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'support_contacts_providers.g.dart';

@Riverpod(keepAlive: true)
SupportContactsRepository supportContactsRepository(Ref ref) {
  return SupportContactsRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@Riverpod(keepAlive: true)
SupportContactsService supportContactsService(Ref ref) {
  return SupportContactsService(ref.watch(supportContactsRepositoryProvider));
}

/// Contacts visible to the current pilgrim / guest.
@riverpod
Future<List<SupportContact>> supportContacts(Ref ref) async {
  attachRealtimeSync(
    ref,
    syncKey: RealtimeSyncKeys.supportContacts,
    ensureSyncActive: (ref) => ref.watch(realtimeSyncSupportContactsProvider),
    handlerId: 'support_contacts',
    // Invalidate via the container: this provider depends on the sync
    // provider, so `ref.invalidate` trips Riverpod's debug can-depend-on
    // guard (false-positive cycle) and silently skips the realtime refresh.
    onInvalidate: (ref) => ref.container.invalidate(supportContactsProvider),
  );

  return ref.read(supportContactsServiceProvider).loadVisible();
}

/// Every contact (admin management view).
@riverpod
Future<List<SupportContact>> adminSupportContacts(Ref ref) async {
  attachRealtimeSync(
    ref,
    syncKey: RealtimeSyncKeys.supportContacts,
    ensureSyncActive: (ref) => ref.watch(realtimeSyncSupportContactsProvider),
    handlerId: 'admin_support_contacts',
    onInvalidate: (ref) =>
        ref.container.invalidate(adminSupportContactsProvider),
  );

  return ref.read(supportContactsServiceProvider).loadAll();
}

@riverpod
class SupportContactSave extends _$SupportContactSave {
  @override
  FutureOr<void> build() {}

  Future<bool> save(SupportContactInput input) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(supportContactsServiceProvider).save(input);
      ref.invalidate(adminSupportContactsProvider);
      ref.invalidate(supportContactsProvider);
    });
    return !state.hasError;
  }
}

@riverpod
class SupportContactDelete extends _$SupportContactDelete {
  @override
  FutureOr<void> build() {}

  Future<bool> remove(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(supportContactsServiceProvider).remove(id);
      ref.invalidate(adminSupportContactsProvider);
      ref.invalidate(supportContactsProvider);
    });
    return !state.hasError;
  }
}
