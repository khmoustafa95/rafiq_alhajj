import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/field_pilgrim_status.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/pilgrim_search_item.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/providers/field_operator_providers.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/utils/field_status_l10n.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/widgets/pilgrim_list_tile.dart';
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
          IconButton(
            onPressed: () {
              unawaited(
                ref.read(fieldOperatorSearchProvider.notifier).refresh(),
              );
            },
            tooltip: l10n.retry,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: l10n.fieldOperatorSearchHintExtended,
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide(color: colorScheme.outlineVariant),
                ),
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 40.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              children: [
                _FilterChip(
                  label: l10n.fieldOperatorFilterAll,
                  selected: statusFilter == null,
                  onSelected: () => ref
                      .read(fieldOperatorSearchProvider.notifier)
                      .filterByStatus(null),
                ),
                for (final status in FieldPilgrimStatus.values)
                  _FilterChip(
                    label: fieldStatusLabel(l10n, status),
                    selected: statusFilter == status,
                    onSelected: () => ref
                        .read(fieldOperatorSearchProvider.notifier)
                        .filterByStatus(status),
                  ),
              ],
            ),
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
                      onPressed: () {
                        unawaited(
                          ref.read(fieldOperatorSearchProvider.notifier).refresh(),
                        );
                      },
                      child: Text(l10n.retry),
                    ),
                  ],
                ),
              ),
              data: (pilgrims) {
                if (pilgrims.isEmpty) {
                  return Center(child: Text(l10n.fieldOperatorNoResults));
                }

                return RefreshIndicator(
                  onRefresh: () =>
                      ref.read(fieldOperatorSearchProvider.notifier).refresh(),
                  child: ListView.separated(
                    padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                    itemCount: pilgrims.length,
                    separatorBuilder: (_, _) => SizedBox(height: 10.h),
                    itemBuilder: (context, index) {
                      final item = pilgrims[index];
                      return PilgrimListTile(
                        item: item,
                        onTap: () => _openPilgrim(item),
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
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsetsDirectional.only(end: 8.w),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onSelected(),
        showCheckmark: false,
        selectedColor: colorScheme.primaryContainer,
        checkmarkColor: colorScheme.primary,
        labelStyle: TextStyle(
          color: selected ? colorScheme.onPrimaryContainer : colorScheme.onSurfaceVariant,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
    );
  }
}
