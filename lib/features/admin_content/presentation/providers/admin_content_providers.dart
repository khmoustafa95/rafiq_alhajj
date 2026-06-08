import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_refresh.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_tables.dart';
import 'package:rafiq_alhajj/features/admin_content/application/services/admin_content_service.dart';
import 'package:rafiq_alhajj/features/admin_content/data/repositories/admin_content_repository.dart';
import 'package:rafiq_alhajj/features/admin_content/domain/models/content_editor_input.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'admin_content_providers.g.dart';

@Riverpod(keepAlive: true)
AdminContentRepository adminContentRepository(Ref ref) {
  return AdminContentRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@Riverpod(keepAlive: true)
AdminContentService adminContentService(Ref ref) {
  return AdminContentService(ref.watch(adminContentRepositoryProvider));
}

@riverpod
Future<PaginatedResult<ContentItem>> adminContentListPage(
  Ref ref,
  StaffTableQuery query,
) async {
  final result = await ref.read(adminContentServiceProvider).listPage(query);

  watchSupabaseTables(
    ref,
    client: AppConfig.hasSupabase ? Supabase.instance.client : null,
    tables: RealtimeTables.contentFeed,
  );

  return result;
}

@riverpod
Future<ContentItem?> adminContentDetail(Ref ref, String id) async {
  final item = await ref.read(adminContentServiceProvider).getById(id);

  watchSupabaseTables(
    ref,
    client: AppConfig.hasSupabase ? Supabase.instance.client : null,
    tables: RealtimeTables.contentFeed,
  );

  return item;
}

@riverpod
class AdminContentDelete extends _$AdminContentDelete {
  @override
  FutureOr<void> build() {}

  Future<bool> deleteItem(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(adminContentServiceProvider).remove(id);
      ref.invalidate(adminContentListPageProvider);
    });
    return !state.hasError;
  }
}

@riverpod
class AdminContentSave extends _$AdminContentSave {
  @override
  FutureOr<void> build() {}

  Future<bool> save(ContentEditorInput input) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(adminContentServiceProvider).save(input);
      ref.invalidate(adminContentListPageProvider);
      if (input.id != null) {
        ref.invalidate(adminContentDetailProvider(input.id!));
      }
    });
    return !state.hasError;
  }
}
