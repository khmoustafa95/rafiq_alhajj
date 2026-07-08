import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/pilgrim_search_item.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/providers/field_operator_providers.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/widgets/field_operator_pilgrim_list_body.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/widgets/field_operator_pilgrim_search_bar.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/widgets/field_operator_pilgrim_status_filters.dart';
import 'package:rafiq_alhajj/features/trips/presentation/widgets/trip_selector.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class FieldOperatorPilgrimsScreen extends ConsumerStatefulWidget {
  const FieldOperatorPilgrimsScreen({super.key});

  @override
  ConsumerState<FieldOperatorPilgrimsScreen> createState() =>
      _FieldOperatorPilgrimsScreenState();
}

class _FieldOperatorPilgrimsScreenState
    extends ConsumerState<FieldOperatorPilgrimsScreen> {
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
        ref.read(fieldOperatorSearchProvider.notifier).search(value),
      );
    });
  }

  Future<void> _refresh() =>
      ref.read(fieldOperatorSearchProvider.notifier).refresh();

  void _openPilgrim(PilgrimSearchItem item) {
    unawaited(context.push(AppRoutes.fieldOperatorPilgrimPath(item.profileId)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final pilgrimsAsync = ref.watch(fieldOperatorSearchProvider);
    final statusFilter =
        ref.read(fieldOperatorSearchProvider.notifier).statusFilter;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: RafiqAppBar(
        title: Text(l10n.fieldOperatorPilgrimsTitle),
        actions: [
          const Padding(
            padding: EdgeInsetsDirectional.only(end: 8),
            child: Center(child: TripSelector()),
          ),
          Semantics(
            button: true,
            label: l10n.retry,
            child: IconButton(
              onPressed: () => unawaited(_refresh()),
              tooltip: l10n.retry,
              icon: const Icon(Icons.refresh),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          FieldOperatorPilgrimSearchBar(
            controller: _searchController,
            onChanged: _onSearchChanged,
          ),
          SizedBox(height: 10.h),
          FieldOperatorPilgrimStatusFilters(
            selectedStatus: statusFilter,
            onFilterSelected: (status) => ref
                .read(fieldOperatorSearchProvider.notifier)
                .filterByStatus(status),
          ),
          SizedBox(height: 8.h),
          Expanded(
            child: pilgrimsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(l10n.fieldOperatorLoadError),
                    SizedBox(height: 12.h),
                    FilledButton(
                      onPressed: () => unawaited(_refresh()),
                      child: Text(l10n.retry),
                    ),
                  ],
                ),
              ),
              data: (pilgrims) => FieldOperatorPilgrimListBody(
                pilgrims: pilgrims,
                onRefresh: _refresh,
                onPilgrimTap: _openPilgrim,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
