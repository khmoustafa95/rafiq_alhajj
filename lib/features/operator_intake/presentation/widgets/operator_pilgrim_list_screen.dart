import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
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

    return Scaffold(
      appBar: AppBar(
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
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: l10n.operatorPilgrimSearchHint,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          Expanded(
            child: pilgrimsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(l10n.operatorPilgrimListLoadError),
                    SizedBox(height: 12.h),
                    FilledButton(
                      onPressed: () {
                        unawaited(
                          ref
                              .read(operatorPilgrimRegistryProvider.notifier)
                              .refresh(),
                        );
                      },
                      child: Text(l10n.retry),
                    ),
                  ],
                ),
              ),
              data: (pilgrims) {
                if (pilgrims.isEmpty) {
                  return Center(child: Text(l10n.operatorPilgrimListEmpty));
                }

                return RefreshIndicator(
                  onRefresh: () => ref
                      .read(operatorPilgrimRegistryProvider.notifier)
                      .refresh(),
                  child: ListView.separated(
                    padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
                    itemCount: pilgrims.length,
                    separatorBuilder: (_, _) => SizedBox(height: 8.h),
                    itemBuilder: (context, index) {
                      final item = pilgrims[index];
                      return Card(
                        child: ListTile(
                          title: Text(item.fullName),
                          subtitle: Text(_subtitle(l10n, item)),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _openPilgrim(item),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
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
