import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/auth/presentation/controllers/sign_out_controller.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/providers/field_operator_providers.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/widgets/field_operator_dashboard_body.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class FieldOperatorDashboardScreen extends ConsumerWidget {
  const FieldOperatorDashboardScreen({super.key});

  Future<void> _refresh(WidgetRef ref) async {
    ref.invalidate(fieldOperatorStatsProvider);
    ref.invalidate(fieldOperatorSearchProvider);
    await ref.read(fieldOperatorStatsProvider.future);
  }

  void _openPilgrimsWithFilter(
    BuildContext context,
    WidgetRef ref,
    String? status,
  ) {
    unawaited(
      ref.read(fieldOperatorSearchProvider.notifier).filterByStatus(status),
    );
    context.go(AppRoutes.fieldOperatorPilgrims);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final statsAsync = ref.watch(fieldOperatorStatsProvider);
    final operatorName = ref.watch(authProfileFullNameProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: RafiqAppBar(
        title: Text(l10n.fieldOperatorDashboardTitle),
        actions: [
          IconButton(
            onPressed: ref.read(signOutControllerProvider.notifier).signOut,
            tooltip: l10n.signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: statsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.fieldOperatorLoadError),
              SizedBox(height: 12.h),
              FilledButton(
                onPressed: () => _refresh(ref),
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
        data: (stats) => RefreshIndicator(
          onRefresh: () => _refresh(ref),
          child: FieldOperatorDashboardBody(
            stats: stats,
            operatorName: operatorName,
            onOpenPilgrimsWithFilter: (status) =>
                _openPilgrimsWithFilter(context, ref, status),
            onOpenPilgrimsList: () => context.go(AppRoutes.fieldOperatorPilgrims),
          ),
        ),
      ),
    );
  }
}
