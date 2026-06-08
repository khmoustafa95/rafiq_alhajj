import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_refresh.dart';
import 'package:rafiq_alhajj/features/admin_operators/application/services/admin_operators_service.dart';
import 'package:rafiq_alhajj/features/admin_operators/data/repositories/admin_operators_repository.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/created_operator_account.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_account.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_editor_input.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'admin_operators_providers.g.dart';

@Riverpod(keepAlive: true)
AdminOperatorsRepository adminOperatorsRepository(Ref ref) {
  return AdminOperatorsRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@Riverpod(keepAlive: true)
AdminOperatorsService adminOperatorsService(Ref ref) {
  return AdminOperatorsService(ref.watch(adminOperatorsRepositoryProvider));
}

@riverpod
Future<PaginatedResult<OperatorAccount>> adminOperatorListPage(
  Ref ref,
  StaffTableQuery query,
) async {
  final result = await ref.read(adminOperatorsServiceProvider).listPage(query);

  watchSupabaseTables(
    ref,
    client: AppConfig.hasSupabase ? Supabase.instance.client : null,
    tables: const ['profiles'],
  );

  return result;
}

@riverpod
Future<OperatorAccount> adminOperatorDetail(Ref ref, String id) async {
  return ref.read(adminOperatorsServiceProvider).getOperator(id);
}

@riverpod
class AdminOperatorSave extends _$AdminOperatorSave {
  @override
  FutureOr<void> build() {}

  Future<CreatedOperatorAccount?> create(OperatorEditorInput input) async {
    state = const AsyncLoading();
    CreatedOperatorAccount? created;
    state = await AsyncValue.guard(() async {
      created = await ref.read(adminOperatorsServiceProvider).create(input);
      ref.invalidate(adminOperatorListPageProvider);
    });
    return state.hasError ? null : created;
  }

  Future<bool> saveExisting(OperatorEditorInput input) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(adminOperatorsServiceProvider).update(input);
      ref.invalidate(adminOperatorListPageProvider);
      if (input.id != null) {
        ref.invalidate(adminOperatorDetailProvider(input.id!));
      }
    });
    return !state.hasError;
  }
}
