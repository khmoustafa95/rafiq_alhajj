import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_error_view.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/trips/domain/models/trip.dart';
import 'package:rafiq_alhajj/features/trips/domain/models/trip_office.dart';
import 'package:rafiq_alhajj/features/trips/presentation/providers/trips_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminTripOfficesScreen extends ConsumerWidget {
  const AdminTripOfficesScreen({required this.tripId, super.key});

  final String tripId;

  Future<void> _addOffice(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final options = await ref.read(tripAvailableGroupsProvider(tripId).future);
    if (!context.mounted) {
      return;
    }
    if (options.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.adminTripNoAvailableOffices)),
      );
      return;
    }

    final selected = await showDialog<TripGroupOption>(
      context: context,
      builder: (ctx) {
        final l10n = AppLocalizations.of(ctx);
        return SimpleDialog(
          title: Text(l10n.adminTripAddOffice),
          children: [
            for (final option in options)
              SimpleDialogOption(
                onPressed: () => Navigator.pop(ctx, option),
                child: Text(option.name),
              ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.dialogCancel),
            ),
          ],
        );
      },
    );

    if (selected == null || !context.mounted) {
      return;
    }

    final ok = await ref
        .read(tripOfficeMutationProvider.notifier)
        .add(tripId: tripId, groupId: selected.id);
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok ? l10n.adminTripOfficeAdded : l10n.adminTripOfficeError,
        ),
      ),
    );
  }

  Future<void> _toggleStatus(
    BuildContext context,
    WidgetRef ref,
    TripOffice office,
  ) async {
    final l10n = AppLocalizations.of(context);
    final next = office.isActive ? 'withdrawn' : 'active';
    final ok = await ref.read(tripOfficeMutationProvider.notifier).setStatus(
          tripId: tripId,
          tripGroupId: office.tripGroupId,
          status: next,
        );
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok ? l10n.adminTripOfficeUpdated : l10n.adminTripOfficeError,
        ),
      ),
    );
  }

  Future<void> _remove(
    BuildContext context,
    WidgetRef ref,
    TripOffice office,
  ) async {
    final l10n = AppLocalizations.of(context);
    final ok = await ref.read(tripOfficeMutationProvider.notifier).remove(
          tripId: tripId,
          tripGroupId: office.tripGroupId,
        );
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok ? l10n.adminTripOfficeUpdated : l10n.adminTripOfficeError,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tripAsync = ref.watch(tripDetailProvider(tripId));
    final officesAsync = ref.watch(tripOfficesProvider(tripId));

    final body = officesAsync.when(
      skipLoadingOnReload: true,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => StaffErrorView.fromError(
        l10n,
        error: error,
        onRetry: () => ref.invalidate(tripOfficesProvider(tripId)),
      ),
      data: (offices) {
        if (offices.isEmpty) {
          return StaffEmptyState(
            message: l10n.adminTripOfficesEmpty,
            icon: Icons.groups_2_outlined,
            actionLabel: l10n.adminTripAddOffice,
            onAction: () => unawaited(_addOffice(context, ref)),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.all(sw(16)),
          itemCount: offices.length,
          separatorBuilder: (_, _) => SizedBox(height: sh(10)),
          itemBuilder: (context, index) {
            final office = offices[index];
            return _OfficeCard(
              office: office,
              onToggleStatus: () =>
                  unawaited(_toggleStatus(context, ref, office)),
              onRemove: () => unawaited(_remove(context, ref, office)),
            );
          },
        );
      },
    );

    final title = tripAsync.maybeWhen(
      data: (Trip trip) => trip.name,
      orElse: () => l10n.adminTripOfficesTitle,
    );

    return StaffAdaptivePage(
      web: StaffWebPage(
        title: title,
        subtitle: l10n.adminTripOfficesSubtitle,
        scrollable: false,
        actions: [
          FilledButton.icon(
            onPressed: () => unawaited(_addOffice(context, ref)),
            icon: const Icon(Icons.add_rounded),
            label: Text(l10n.adminTripAddOffice),
          ),
        ],
        body: body,
      ),
      mobile: Scaffold(
        appBar: RafiqAppBar(
          title: Text(title),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go(AppRoutes.adminTrips),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => unawaited(_addOffice(context, ref)),
          icon: const Icon(Icons.add),
          label: Text(l10n.adminTripAddOffice),
        ),
        body: body,
      ),
    );
  }
}

class _OfficeCard extends StatelessWidget {
  const _OfficeCard({
    required this.office,
    required this.onToggleStatus,
    required this.onRemove,
  });

  final TripOffice office;
  final VoidCallback onToggleStatus;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.12),
          child: Icon(Icons.business_outlined, color: theme.colorScheme.primary),
        ),
        title: Text(office.groupName, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(office.presidentName ?? '—'),
        trailing: Wrap(
          spacing: sw(4),
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Chip(
              label: Text(
                office.isActive
                    ? l10n.adminTripOfficeActive
                    : l10n.adminTripOfficeWithdrawn,
              ),
              visualDensity: VisualDensity.compact,
            ),
            TextButton(
              onPressed: onToggleStatus,
              child: Text(
                office.isActive
                    ? l10n.adminTripOfficeWithdraw
                    : l10n.adminTripOfficeActivate,
              ),
            ),
            IconButton(
              tooltip: l10n.adminTripOfficeRemove,
              icon: const Icon(Icons.delete_outline),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
