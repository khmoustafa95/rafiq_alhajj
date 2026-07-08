import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/features/admin_accounts/application/services/admin_accounts_service.dart';
import 'package:rafiq_alhajj/features/admin_accounts/data/repositories/admin_accounts_repository.dart';
import 'package:rafiq_alhajj/features/admin_accounts/domain/models/admin_account.dart';
import 'package:rafiq_alhajj/features/admin_operators/presentation/providers/admin_operators_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'admin_accounts_providers.g.dart';

@Riverpod(keepAlive: true)
AdminAccountsRepository adminAccountsRepository(Ref ref) {
  return AdminAccountsRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@Riverpod(keepAlive: true)
AdminAccountsService adminAccountsService(Ref ref) {
  return AdminAccountsService(ref.watch(adminAccountsRepositoryProvider));
}

@riverpod
Future<PaginatedResult<AdminAccount>> adminAccountListPage(
  Ref ref,
  StaffTableQuery query,
) {
  return ref.read(adminAccountsServiceProvider).listPage(query);
}

@riverpod
class AdminAccountPromote extends _$AdminAccountPromote {
  @override
  FutureOr<void> build() {}

  Future<bool> promoteOperator(String profileId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(adminAccountsServiceProvider).promoteOperator(profileId);
      ref.invalidate(adminAccountListPageProvider);
      ref.invalidate(adminOperatorListPageProvider);
    });
    return !state.hasError;
  }
}
