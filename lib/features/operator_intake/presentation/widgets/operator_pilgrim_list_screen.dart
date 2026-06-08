import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/auth/presentation/controllers/sign_out_controller.dart';
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
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      unawaited(
        ref.read(operatorPilgrimRegistryProvider.notifier).search(value),
      );
    });
  }

  void _openPilgrim(OperatorPilgrimSummary item) {
    unawaited(
      context.push(AppRoutes.operatorPilgrimDetailPath(item.profileId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final pilgrimsAsync = ref.watch(operatorPilgrimRegistryProvider);

    final searchField = TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: l10n.operatorPilgrimSearchHint,
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: AppColors.surface,
      ),
      onChanged: _onSearchChanged,
    );

    final listBody = pilgrimsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => StaffEmptyState(
        message: l10n.operatorPilgrimListLoadError,
        icon: Icons.error_outline,
        actionLabel: l10n.retry,
        onAction: () {
          unawaited(
            ref.read(operatorPilgrimRegistryProvider.notifier).refresh(),
          );
        },
      ),
      data: (pilgrims) {
        if (pilgrims.isEmpty) {
          return StaffEmptyState(
            message: l10n.operatorPilgrimListEmpty,
            icon: Icons.people_outline,
            actionLabel: l10n.operatorIntakeTitle,
            onAction: () => context.go(AppRoutes.operatorIntake),
          );
        }

        return RefreshIndicator(
          onRefresh: () =>
              ref.read(operatorPilgrimRegistryProvider.notifier).refresh(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 720;

              if (isWide) {
                return ListView.separated(
                  padding: EdgeInsets.only(bottom: 24.h),
                  itemCount: pilgrims.length,
                  separatorBuilder: (_, _) => SizedBox(height: 8.h),
                  itemBuilder: (context, index) =>
                      _PilgrimTableRow(
                        item: pilgrims[index],
                        l10n: l10n,
                        onTap: () => _openPilgrim(pilgrims[index]),
                      ),
                );
              }

              return ListView.separated(
                padding: EdgeInsets.only(bottom: 24.h),
                itemCount: pilgrims.length,
                separatorBuilder: (_, _) => SizedBox(height: 10.h),
                itemBuilder: (context, index) => _PilgrimCard(
                  item: pilgrims[index],
                  l10n: l10n,
                  subtitle: _subtitle(l10n, pilgrims[index]),
                  onTap: () => _openPilgrim(pilgrims[index]),
                ),
              );
            },
          ),
        );
      },
    );

    return StaffAdaptivePage(
      web: StaffWebPage(
        title: l10n.operatorPilgrimListTitle,
        subtitle: l10n.operatorPilgrimListSubtitle,
        actions: [
          FilledButton.icon(
            onPressed: () => context.go(AppRoutes.operatorIntake),
            icon: const Icon(Icons.person_add_outlined),
            label: Text(l10n.operatorIntakeTitle),
          ),
        ],
        scrollable: false,
        top: searchField,
        body: listBody,
      ),
      mobile: Scaffold(
        appBar: RafiqAppBar(
          title: Text(l10n.operatorPilgrimListTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go(AppRoutes.operatorIntake),
          ),
          actions: [
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
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
              child: searchField,
            ),
            Expanded(child: listBody),
          ],
        ),
      ),
    );
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
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
            title: Text(item.fullName, style: Theme.of(context).textTheme.titleSmall),
            subtitle: Text(subtitle),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
      ),
    );
  }
}

class _PilgrimTableRow extends StatelessWidget {
  const _PilgrimTableRow({
    required this.item,
    required this.l10n,
    required this.onTap,
  });

  final OperatorPilgrimSummary item;
  final AppLocalizations l10n;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dateLabel = item.travelDate == null
        ? l10n.operatorPilgrimTravelDateUnset
        : MaterialLocalizations.of(context).formatMediumDate(item.travelDate!);

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        child: DecoratedBox(
          decoration: AppDecorations.card(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                  child: Text(
                    item.fullName.isNotEmpty ? item.fullName[0].toUpperCase() : '?',
                    style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  flex: 3,
                  child: Text(
                    item.fullName,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    item.passportNumber ?? '—',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(dateLabel, style: Theme.of(context).textTheme.bodyMedium),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    item.hotelName ?? '—',
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.chevron_right, color: AppColors.textSecondary, size: 20.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
