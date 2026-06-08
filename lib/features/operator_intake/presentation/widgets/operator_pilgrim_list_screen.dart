import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_data_table.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/controllers/sign_out_controller.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_summary.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/operator_registry_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class OperatorPilgrimListScreen extends ConsumerStatefulWidget {
  const OperatorPilgrimListScreen({super.key});

  @override
  ConsumerState<OperatorPilgrimListScreen> createState() =>
      _OperatorPilgrimListScreenState();
}

class _OperatorPilgrimListScreenState
    extends ConsumerState<OperatorPilgrimListScreen> {
  StaffTableQuery _query = const StaffTableQuery(
    sortColumnId: 'full_name',
  );

  void _openPilgrim(OperatorPilgrimSummary item) {
    final path = AppRoutes.operatorPilgrimDetailPath(item.profileId);
    if (AppPlatform.isWeb) {
      context.go(path);
    } else {
      unawaited(context.push(path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isAdmin = ref.watch(authAccessModeProvider) == AppAccessMode.admin;
    final pageAsync = ref.watch(operatorPilgrimRegistryPageProvider(_query));

    final toolbarActions = isAdmin
        ? const <Widget>[]
        : [
            FilledButton.icon(
              onPressed: () => context.go(AppRoutes.operatorIntake),
              icon: const Icon(Icons.person_add_outlined),
              label: Text(l10n.operatorIntakeTitle),
            ),
          ];

    final listBody = pageAsync.when(
      skipLoadingOnReload: true,
      loading: () => AppPlatform.isWeb
          ? StaffDataTable<OperatorPilgrimSummary>(
              columns: _columns(context, l10n),
              rows: const [],
              totalCount: 0,
              query: _query,
              onQueryChanged: (query) => setState(() => _query = query),
              searchHint: l10n.operatorPilgrimSearchHint,
              toolbarActions: toolbarActions,
              isLoading: true,
              emptyMessage: l10n.operatorPilgrimListEmpty,
              emptyIcon: Icons.people_outline,
            )
          : const Center(child: CircularProgressIndicator()),
      error: (_, _) => StaffEmptyState(
        message: l10n.operatorPilgrimListLoadError,
        icon: Icons.error_outline,
        actionLabel: l10n.retry,
        onAction: () {
          ref.invalidate(operatorPilgrimRegistryPageProvider(_query));
        },
      ),
      data: (page) {
        if (AppPlatform.isWeb) {
          return StaffDataTable<OperatorPilgrimSummary>(
            columns: _columns(context, l10n),
            rows: page.items,
            totalCount: page.totalCount,
            query: _query,
            onQueryChanged: (query) => setState(() => _query = query),
            searchHint: l10n.operatorPilgrimSearchHint,
            toolbarActions: toolbarActions,
            isLoading: pageAsync.isLoading,
            onRowTap: _openPilgrim,
            trailingBuilder: (_, _) => Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
              size: ss(20),
            ),
            emptyMessage: l10n.operatorPilgrimListEmpty,
            emptyIcon: Icons.people_outline,
          );
        }

        if (page.items.isEmpty) {
          return StaffEmptyState(
            message: l10n.operatorPilgrimListEmpty,
            icon: Icons.people_outline,
            actionLabel: isAdmin ? null : l10n.operatorIntakeTitle,
            onAction:
                isAdmin ? null : () => context.go(AppRoutes.operatorIntake),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.all(sw(16)),
          itemCount: page.items.length,
          separatorBuilder: (_, _) => SizedBox(height: sh(10)),
          itemBuilder: (context, index) {
            final item = page.items[index];
            return _PilgrimCard(
              item: item,
              l10n: l10n,
              subtitle: _subtitle(l10n, item),
              onTap: () => _openPilgrim(item),
            );
          },
        );
      },
    );

    return StaffAdaptivePage(
      web: StaffWebPage(
        title: l10n.operatorPilgrimListTitle,
        subtitle: l10n.operatorPilgrimListSubtitle,
        scrollable: false,
        body: listBody,
      ),
      mobile: Scaffold(
        appBar: RafiqAppBar(
          title: Text(l10n.operatorPilgrimListTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go(
              isAdmin ? AppRoutes.adminDashboard : AppRoutes.operatorIntake,
            ),
          ),
          actions: [
            if (!isAdmin)
              IconButton(
                onPressed: () => context.go(AppRoutes.operatorIntake),
                icon: const Icon(Icons.person_add_outlined),
                tooltip: l10n.operatorIntakeTitle,
              ),
            IconButton(
              onPressed: ref.read(signOutControllerProvider.notifier).signOut,
              tooltip: l10n.signOut,
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: listBody,
      ),
    );
  }

  List<StaffTableColumn<OperatorPilgrimSummary>> _columns(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return [
      StaffTableColumn(
        id: 'full_name',
        label: l10n.operatorFullName,
        flex: 3,
        sortable: true,
        cellBuilder: (context, item) => Row(
          children: [
            CircleAvatar(
              radius: sr(16),
              backgroundColor: AppColors.primary.withValues(alpha: 0.12),
              child: Text(
                item.fullName.isNotEmpty ? item.fullName[0].toUpperCase() : '?',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(width: sw(10)),
            Expanded(
              child: Text(
                item.fullName,
                style: Theme.of(context).textTheme.titleSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      StaffTableColumn(
        id: 'passport',
        label: l10n.operatorPassport,
        flex: 2,
        cellBuilder: (context, item) => Text(
          item.passportNumber ?? '—',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      StaffTableColumn(
        id: 'travel_date',
        label: l10n.pilgrimTravelDate,
        flex: 2,
        cellBuilder: (context, item) => Text(
          item.travelDate == null
              ? l10n.operatorPilgrimTravelDateUnset
              : MaterialLocalizations.of(context)
                  .formatMediumDate(item.travelDate!),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      StaffTableColumn(
        id: 'hotel',
        label: l10n.pilgrimHotel,
        flex: 2,
        cellBuilder: (context, item) => Text(
          item.hotelName ?? '—',
          style: Theme.of(context).textTheme.bodyMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ];
  }

  String _subtitle(AppLocalizations l10n, OperatorPilgrimSummary item) {
    final parts = <String>[];
    if (item.passportNumber != null) {
      parts.add('${l10n.operatorPassport}: ${item.passportNumber}');
    }
    if (item.travelDate != null) {
      parts.add(
        '${l10n.pilgrimTravelDate}: '
        '${MaterialLocalizations.of(context).formatMediumDate(item.travelDate!)}',
      );
    }
    if (item.hotelName != null) {
      parts.add(item.hotelName!);
    }
    return parts.isEmpty ? l10n.operatorPilgrimNoLogisticsYet : parts.join(' · ');
  }
}

class _PilgrimCard extends StatelessWidget {
  const _PilgrimCard({
    required this.item,
    required this.l10n,
    required this.subtitle,
    required this.onTap,
  });

  final OperatorPilgrimSummary item;
  final AppLocalizations l10n;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        child: DecoratedBox(
          decoration: AppDecorations.card(),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: sw(16),
              vertical: sh(8),
            ),
            leading: CircleAvatar(
              backgroundColor: AppColors.primary.withValues(alpha: 0.12),
              child: Text(
                item.fullName.isNotEmpty ? item.fullName[0].toUpperCase() : '?',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            title: Text(
              item.fullName,
              style: Theme.of(context).textTheme.titleSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
      ),
    );
  }
}
