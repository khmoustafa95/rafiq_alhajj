import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/auth/presentation/controllers/sign_out_controller.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/pilgrim_search_item.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/providers/field_operator_providers.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/utils/field_status_l10n.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class FieldOperatorHomeScreen extends ConsumerStatefulWidget {
  const FieldOperatorHomeScreen({super.key});

  @override
  ConsumerState<FieldOperatorHomeScreen> createState() =>
      _FieldOperatorHomeScreenState();
}

class _FieldOperatorHomeScreenState extends ConsumerState<FieldOperatorHomeScreen> {
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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: RafiqAppBar(
        title: Text(l10n.fieldOperatorHomeTitle),
        actions: [
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
                hintText: l10n.fieldOperatorSearchHint,
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
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    itemCount: pilgrims.length,
                    separatorBuilder: (_, _) => SizedBox(height: 8.h),
                    itemBuilder: (context, index) {
                      final item = pilgrims[index];
                      return Card(
                        child: ListTile(
                          title: Text(item.fullName),
                          subtitle: Text(
                            [
                              if (item.passportNumber != null)
                                '${l10n.operatorPassport}: ${item.passportNumber}',
                              fieldStatusLabel(l10n, item.fieldStatus),
                            ].join(' · '),
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: colorScheme.onSurfaceVariant,
                          ),
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
}
